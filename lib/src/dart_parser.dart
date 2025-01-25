import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:dart_doc_markdown/src/class_data.dart';
import 'package:dart_doc_markdown/src/dart_file_data.dart';
import 'package:dart_doc_markdown/src/method_data.dart';
import 'package:dart_doc_markdown/src/parameter_data.dart';

/// Responsible for parsing Dart files to extract documentation-relevant data.
class DartParser {
  /// Parses a Dart file and extracts information about its classes, methods, and variables.
  ///
  /// [filePath] is the path to the Dart file to be parsed.
  ///
  /// Returns a [DartFileData] object containing extracted documentation-relevant data.
  DartFileData parseFile(String filePath) {
    // Read the content of the Dart file.
    final String fileContent = File(filePath).readAsStringSync();

    // Parse the file content into an Abstract Syntax Tree (AST).
    final ParseStringResult parseResult = parseString(content: fileContent);

    // Initialize the data container for the parsed file.
    final DartFileData fileData = DartFileData(filePath: filePath);

    // Traverse the AST to extract relevant data.
    for (final CompilationUnitMember declaration in parseResult.unit.declarations) {
      if (declaration is ClassDeclaration) {
        final ClassData classData = _extractClassData(declaration);
        fileData.classes.add(classData);
      }
    }

    return fileData;
  }

  /// Extracts information about a class, including its methods and members.
  ///
  /// [classDeclaration] is the AST node representing the class.
  ///
  /// Returns a [ClassData] object containing the class name, comments, and its members.
  ClassData _extractClassData(ClassDeclaration classDeclaration) {
    // Get the name of the class
    final String className = classDeclaration.name.lexeme;

    // Get the tokens in the Dartdoc comment for the class.
    final List<Token>? documentationCommentTokens = classDeclaration.documentationComment?.tokens;

    // Convert the list of tokens to a string.
    final String? documentationComment = documentationCommentTokens?.map((Token token) => token.lexeme).join('\n');

    final ClassData classData = ClassData(
      name: className,
      documentation: documentationComment,
    );

    // Extract methods and members of the class.
    for (final ClassMember member in classDeclaration.members) {
      if (member is MethodDeclaration) {
        final MethodData methodData = _extractMethodData(member);
        classData.methods.add(methodData);
      }
    }

    return classData;
  }

  /// Extracts information about a method, including its parameters and return type.
  ///
  /// [methodDeclaration] is the AST node representing the method.
  ///
  /// Returns a [MethodData] object containing the method name, comments, parameters, and return type.
  MethodData _extractMethodData(MethodDeclaration methodDeclaration) {
    // Get the name of the method.
    final String methodName = methodDeclaration.name.lexeme;

    // Get the tokens in the Dartdoc comment for the method.
    final List<Token>? documentationCommentTokens = methodDeclaration.documentationComment?.tokens;

    // Convert the list of tokens to a string.
    final String? documentationComment = documentationCommentTokens?.map((Token token) => token.lexeme).join('\n');

    // Get the return type for the method.
    final String? returnType = methodDeclaration.returnType?.toSource();

    final MethodData methodData = MethodData(
      name: methodName,
      documentation: documentationComment,
      returnType: returnType,
    );

    // Extract parameters of the method.
    for (final FormalParameter parameter in methodDeclaration.parameters?.parameters ?? []) {
      String parameterName = '';
      String? parameterType;

      if (parameter is SimpleFormalParameter) {
        // For SimpleFormalParameter, get the name and type.
        parameterName = parameter.name?.lexeme ?? '';
        parameterType = parameter.type?.toSource();
      } else if (parameter is FieldFormalParameter) {
        // For FieldFormalParameter, get the name.
        parameterName = parameter.name.lexeme;
      }

      methodData.parameters.add(
        ParameterData(
          name: parameterName,
          type: parameterType,
        ),
      );
    }

    return methodData;
  }
}

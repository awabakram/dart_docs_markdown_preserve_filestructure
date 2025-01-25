import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:dart_doc_markdown/src/models/class_data.dart';
import 'package:dart_doc_markdown/src/models/constructor_data.dart';
import 'package:dart_doc_markdown/src/models/dart_file_data.dart';
import 'package:dart_doc_markdown/src/models/field_data.dart';
import 'package:dart_doc_markdown/src/models/function_data.dart';
import 'package:dart_doc_markdown/src/models/method_data.dart';
import 'package:dart_doc_markdown/src/models/parameter_data.dart';

/// Responsible for parsing Dart files to extract documentation-relevant data.
class DartParser {
  /// Parses a Dart file and extracts information about its classes, methods, and global functions.
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
      } else if (declaration is FunctionDeclaration) {
        final FunctionData functionData = _extractFunctionData(declaration);
        fileData.globalFunctions.add(functionData);
      }
    }

    return fileData;
  }

  /// Extracts information about a class, including its constructors, methods, and dependencies.
  ///
  /// [classDeclaration] is the AST node representing the class.
  ///
  /// Returns a [ClassData] object containing the class name, comments, and its members.
  ClassData _extractClassData(ClassDeclaration classDeclaration) {
    // Get the name of the class.
    final String className = classDeclaration.name.lexeme;

    // Get the tokens in the Dartdoc comment for the class.
    final List<Token>? documentationCommentTokens = classDeclaration.documentationComment?.tokens;

    // Convert the list of tokens to a string.
    final String? documentationComment = documentationCommentTokens?.map((Token token) => token.lexeme).join('\n');

    // Initialize ClassData.
    final ClassData classData = ClassData(
      name: className,
      documentation: documentationComment,
    );

    // Extract fields (members), methods, constructors, and dependencies.
    for (final ClassMember member in classDeclaration.members) {
      // If the member is a field, extract its name and type.
      if (member is FieldDeclaration) {
        for (final VariableDeclaration field in member.fields.variables) {
          // Get the name of the field
          final String fieldName = field.name.lexeme;

          // Get the type declaration of the field
          final String? fieldType = member.fields.type?.toSource();

          // Get the Dartdoc comment for the field
          final String? fieldDocumentation = member.documentationComment?.tokens.map((Token token) => token.lexeme).join('\n');

          classData.fields.add(
            FieldData(
              name: fieldName,
              type: fieldType,
              documentation: fieldDocumentation,
            ),
          );
        }
      }
      // If the member is a constructor, extract its parameters.
      else if (member is ConstructorDeclaration) {
        final ConstructorData constructorData = _extractConstructorData(member);
        classData.constructors.add(constructorData);
      }
      // If the member is a method, extract its parameters and return type.
      else if (member is MethodDeclaration) {
        final MethodData methodData = _extractMethodData(member);
        classData.methods.add(methodData);
      }
    }

    // Extract dependencies (superclass and mixins).
    if (classDeclaration.extendsClause != null) {
      classData.dependencies.add(classDeclaration.extendsClause!.superclass.name2.lexeme);
    }

    // Extract dependencies (mixins and interfaces).
    if (classDeclaration.withClause != null) {
      for (final NamedType mixin in classDeclaration.withClause!.mixinTypes) {
        classData.dependencies.add(mixin.name2.lexeme);
      }
    }

    // Extract dependencies (interfaces).
    if (classDeclaration.implementsClause != null) {
      for (final NamedType interface in classDeclaration.implementsClause!.interfaces) {
        classData.dependencies.add(interface.name2.lexeme);
      }
    }

    return classData;
  }

  /// Extracts information about a constructor, including its parameters and documentation.
  ///
  /// [constructorDeclaration] is the AST node representing the constructor.
  ///
  /// Returns a [ConstructorData] object containing the constructor name, comments, and parameters.
  ConstructorData _extractConstructorData(ConstructorDeclaration constructorDeclaration) {
    final String constructorName = constructorDeclaration.name?.lexeme ?? 'Unnamed Constructor';

    // Get the tokens in the Dartdoc comment for the constructor.
    final List<Token>? documentationCommentTokens = constructorDeclaration.documentationComment?.tokens;

    // Convert the list of tokens to a string.
    final String? documentationComment = documentationCommentTokens?.map((Token token) => token.lexeme).join('\n');

    // Determine if this is an unnamed constructor.
    final bool isUnnamedConstructor = constructorDeclaration.name == null;

    final ConstructorData constructorData = ConstructorData(
      name: constructorName,
      documentation: documentationComment,
      isUnnamedConstructor: isUnnamedConstructor,
    );

    // Extract parameters of the constructor.
    for (final FormalParameter parameter in constructorDeclaration.parameters.parameters) {
      String parameterName = '';
      String? parameterType;

      if (parameter is SimpleFormalParameter) {
        parameterName = parameter.name?.lexeme ?? '';
        parameterType = parameter.type?.toSource();
      } else if (parameter is FieldFormalParameter) {
        parameterName = parameter.name.lexeme;
        parameterType = parameter.type?.toSource();
      }

      constructorData.parameters.add(
        ParameterData(
          name: parameterName,
          type: parameterType,
        ),
      );
    }

    return constructorData;
  }

  /// Extracts information about a global function, including its parameters and return type.
  ///
  /// [functionDeclaration] is the AST node representing the function.
  ///
  /// Returns a [FunctionData] object containing the function name, comments, parameters, and return type.
  FunctionData _extractFunctionData(FunctionDeclaration functionDeclaration) {
    // Get the name of the function.
    final String functionName = functionDeclaration.name.lexeme;

    // Get the tokens in the Dartdoc comment for the function.
    final List<Token>? documentationCommentTokens = functionDeclaration.documentationComment?.tokens;

    // Convert the list of tokens to a string.
    final String? documentationComment = documentationCommentTokens?.map((Token token) => token.lexeme).join('\n');

    // Get the return type for the function.
    final String? returnType = functionDeclaration.returnType?.toSource();

    final FunctionData functionData = FunctionData(
      name: functionName,
      documentation: documentationComment,
      returnType: returnType,
    );

    // Extract parameters of the function.
    if (functionDeclaration.functionExpression.parameters != null) {
      for (final FormalParameter parameter in functionDeclaration.functionExpression.parameters!.parameters) {
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

        functionData.parameters.add(
          ParameterData(
            name: parameterName,
            type: parameterType,
          ),
        );
      }
    }

    return functionData;
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

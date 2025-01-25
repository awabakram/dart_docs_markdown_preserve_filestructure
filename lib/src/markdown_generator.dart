import 'dart:io';

import 'package:dart_doc_markdown/src/models/class_data.dart';
import 'package:dart_doc_markdown/src/models/constructor_data.dart';
import 'package:dart_doc_markdown/src/models/dart_file_data.dart';
import 'package:dart_doc_markdown/src/models/function_data.dart';
import 'package:dart_doc_markdown/src/models/method_data.dart';
import 'package:dart_doc_markdown/src/models/parameter_data.dart';

/// Responsible for generating Markdown documentation from parsed Dart file data.
class MarkdownGenerator {
  /// Generates Markdown documentation for a given [DartFileData] object.
  ///
  /// [fileData] contains the parsed information from a Dart file.
  /// [outputDirectory] specifies where the generated Markdown file should be saved.
  void generateMarkdown(DartFileData fileData, String outputDirectory) {
    final StringBuffer markdownBuffer = StringBuffer()

      // Add file-level information.
      ..writeln('# File: `${fileData.filePath}`\n');

    // Add class-level documentation.
    if (fileData.classes.isNotEmpty) {
      for (final ClassData classData in fileData.classes) {
        markdownBuffer.writeln(_generateClassMarkdown(classData));
      }
    }

    // Add global function-level documentation.
    if (fileData.globalFunctions.isNotEmpty) {
      markdownBuffer.writeln('## Global Function Documentation\n');
      for (final FunctionData functionData in fileData.globalFunctions) {
        markdownBuffer.writeln(_generateFunctionMarkdown(functionData));
      }
    }

    // Save the generated Markdown to the output directory.
    File(
      '$outputDirectory/${_generateFileName(fileData.filePath)}.md',
    )
      ..createSync(recursive: true)
      ..writeAsStringSync(markdownBuffer.toString());
  }

  /// Sanitizes the documentation string by removing leading slashes and extra spaces.
  String _sanitizeDocumentation(String? documentation) {
    return documentation?.replaceAll('///', '').trim() ?? '';
  }

  /// Generates Markdown for a given class, including its methods and documentation.
  String _generateClassMarkdown(ClassData classData) {
    final StringBuffer buffer = StringBuffer()

      // Create a title for the section about this class.
      ..writeln('## Class Documentation: `${classData.name}`\n')

      // Add class name and documentation.
      ..writeln('### Overview\n');
    final documentation = classData.documentation;
    if (documentation != null) {
      buffer.writeln('${_sanitizeDocumentation(classData.documentation)}\n');
    }

    // Add dependencies.
    if (classData.dependencies.isNotEmpty) {
      buffer
        ..writeln('This class depends on the following package${classData.dependencies.length > 1 ? 's' : ''}:')
        ..writeln('- **Dependencies:** ${classData.dependencies.join(', ')}\n');
    }

    // Add constructor-level documentation.
    if (classData.constructors.isNotEmpty) {
      buffer.writeln('### Constructor${classData.constructors.length > 1 ? 's' : ''}\n');
      for (final ConstructorData constructor in classData.constructors) {
        buffer.writeln('#### ${constructor.name}\n');
        if (constructor.documentation != null) {
          buffer.writeln('${_sanitizeDocumentation(constructor.documentation)}\n');
        }
        // Document the parameters for named or factory constructors.
        if (constructor.parameters.isNotEmpty && !constructor.isUnnamedConstructor) {
          buffer.writeln('##### Parameters\n');
          for (final ParameterData param in constructor.parameters) {
            buffer.writeln('- `${param.name}`: `${param.type ?? "dynamic"}`');
          }
        }
      }
    }

    // Add method-level documentation.
    if (classData.methods.isNotEmpty) {
      buffer.writeln('### Methods\n');
      for (final MethodData method in classData.methods) {
        buffer.writeln(_generateMethodMarkdown(method));
      }
    }

    return buffer.toString();
  }

  /// Generates Markdown for a given global function.
  String _generateFunctionMarkdown(FunctionData functionData) {
    final StringBuffer buffer = StringBuffer()

      // Add function name and signature.
      ..writeln('### ${functionData.name}\n');
    if (functionData.documentation != null) {
      buffer.writeln('${_sanitizeDocumentation(functionData.documentation)}\n');
    }
    if (functionData.returnType != null) {
      buffer.writeln('- **Return Type:** `${functionData.returnType}`');
    }

    // Add parameters.
    if (functionData.parameters.isNotEmpty) {
      buffer.writeln('- **Parameters:**');
      for (final ParameterData param in functionData.parameters) {
        buffer.writeln('  - `${param.name}`: `${param.type ?? "dynamic"}`');
      }
    }

    return buffer.toString();
  }

  /// Generates Markdown for a given method, including its parameters and return type.
  String _generateMethodMarkdown(MethodData methodData) {
    final StringBuffer buffer = StringBuffer()

      // Add method name and signature.
      ..writeln('- **${methodData.name}()**');
    if (methodData.returnType != null) {
      buffer.writeln('  - Return Type:\n`${methodData.returnType}`');
    }

    // Add method documentation.
    if (methodData.documentation != null) {
      buffer.writeln('  - Documentation:\n${_sanitizeDocumentation(methodData.documentation)}');
    }

    // Add parameters.
    if (methodData.parameters.isNotEmpty) {
      buffer.writeln('  - Parameters:');
      for (final ParameterData param in methodData.parameters) {
        buffer.writeln('    - `${param.name}`: `${param.type ?? "dynamic"}`');
      }
    }

    return buffer.toString();
  }

  /// Generates a file name for the Markdown file based on the Dart file path.
  ///
  /// Removes directory paths and replaces `.dart` with `.md`.
  String _generateFileName(String filePath) {
    return filePath.split(Platform.pathSeparator).last.replaceAll('.dart', '');
  }
}

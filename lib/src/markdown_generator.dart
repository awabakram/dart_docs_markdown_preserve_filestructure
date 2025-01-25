import 'dart:io';

import 'package:dart_doc_markdown/src/models/class_data.dart';
import 'package:dart_doc_markdown/src/models/dart_file_data.dart';
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
      markdownBuffer.writeln('## Classes\n');
      for (final ClassData classData in fileData.classes) {
        markdownBuffer.writeln(_generateClassMarkdown(classData));
      }
    }

    // Save the generated Markdown to the output directory.
    final File outputFile = File(
      '$outputDirectory/${_generateFileName(fileData.filePath)}.md',
    )
    ..createSync(recursive: true)
    ..writeAsStringSync(markdownBuffer.toString());
  }

  /// Generates Markdown for a given class, including its methods and documentation.
  String _generateClassMarkdown(ClassData classData) {
    final StringBuffer buffer = StringBuffer()

    // Add class name and documentation.
    ..writeln('### ${classData.name}\n');
    if (classData.documentation != null) {
      buffer.writeln('${classData.documentation}\n');
    }

    // Add method-level documentation.
    if (classData.methods.isNotEmpty) {
      buffer.writeln('#### Methods\n');
      for (final MethodData method in classData.methods) {
        buffer.writeln(_generateMethodMarkdown(method));
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
      buffer.writeln('  - Return Type: `${methodData.returnType}`');
    }

    // Add method documentation.
    if (methodData.documentation != null) {
      buffer.writeln('  - Documentation: ${methodData.documentation}');
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

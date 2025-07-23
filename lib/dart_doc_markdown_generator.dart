import 'dart:io';

import 'package:dart_doc_markdown_generator/models/cli_config.dart';
import 'package:dart_doc_markdown_generator/src/dart_parser.dart';
import 'package:dart_doc_markdown_generator/src/directory_traversal.dart';
import 'package:dart_doc_markdown_generator/src/markdown_generator.dart';
import 'package:dart_doc_markdown_generator/src/models/class_data.dart';
import 'package:dart_doc_markdown_generator/src/models/dart_file_data.dart';
import 'package:dart_doc_markdown_generator/src/models/method_data.dart';
import 'package:dart_doc_markdown_generator/src/models/parameter_data.dart';
import 'package:path/path.dart' as path;


/// Entry point for the CLI application.
///
/// The purpose of this Dart CLI tool is to automate the process of generating documentation for a Dart/Flutter project.
/// This function wraps this process and, at a high leve, performs the following steps:
///
///   1.  **Traverse**: Scan the project directory for .dart files.
///   2.  **Parse**: Extract documentation-relevant data using Dart’s analyzer.
///   3.  **Generate**: Format the extracted data into Markdown files.
void runDocumentationGeneration(CLIConfig config) {
  // Step 1: Traverse the directory to get all Dart files.
  final DirectoryTraversal traversal = DirectoryTraversal(
    projectDirectory: config.projectDirectory,
    ignorePatterns: DirectoryTraversal.loadIgnorePatterns('.dartdocmarkdownrc'),
  );
  final List<String> dartFiles = traversal.findDartFiles();

  // Log the files found (useful for debugging in verbose mode).
  _printFilesList(
    config: config,
    dartFiles: dartFiles,
  );

  // Step 2: Analyze each Dart file using DartParser.
  final DartParser parser = DartParser();
  final List<DartFileData> parsedFiles = [];
  for (final String filePath in dartFiles) {
    try {
      final DartFileData fileData = parser.parseFile(filePath);
      parsedFiles.add(fileData);

      // Log parsed information if verbose mode is enabled.
      _printFileData(
        config: config,
        filePath: filePath,
        fileData: fileData,
      );
    } catch (e) {
      // Log any errors encountered during parsing.
      print('Error analyzing file $filePath: $e');
    }
  }

  // Step 3: Generate Markdown documentation from parsed data.
  final MarkdownGenerator markdownGenerator = MarkdownGenerator();
  for (final DartFileData fileData in parsedFiles) {
    try {
      final String relativePath = 
        fileData.filePath.replaceFirst('${config.projectDirectory}${Platform.pathSeparator}', '');

      final String markdownOutputPath = 
          path.join(config.outputDirectory, relativePath).replaceAll('.dart', '.md');

      // Create parent directories if needed
      File(markdownOutputPath).parent.createSync(recursive: true);

      // Generate the markdown
      markdownGenerator.generateMarkdown(fileData, markdownOutputPath);

      // Log generated Markdown file name if verbose mode is enabled.
      _printMarkdownFileName(
        config: config,
        fileData: fileData,
      );
    } catch (e) {
      print('Error generating Markdown for file ${fileData.filePath}: $e');
    }
  }
}

/// Prints the list of Dart files found during directory traversal if verbose mode is enabled.
void _printFilesList({
  required CLIConfig config,
  required List<String> dartFiles,
}) {
  if (config.verbose) {
    print('Found Dart files:');
    for (final String file in dartFiles) {
      print(file);
    }
  }
}

/// Prints the parsed data for a file if verbose mode is enabled.
void _printFileData({
  required CLIConfig config,
  required String filePath,
  required DartFileData fileData,
}) {
  if (config.verbose) {
    print('Analyzed file: $filePath');
    for (final ClassData classData in fileData.classes) {
      print('  Class: ${classData.name}');
      for (final MethodData method in classData.methods) {
        print('    Method: ${method.name}');
        if (method.returnType != null) {
          print('      Return Type: ${method.returnType}');
        }
        for (final ParameterData param in method.parameters) {
          print('      Parameter: ${param.name}');
          if (param.type != null) {
            print('        Type: ${param.type}');
          }
        }
      }
    }
  }
}

/// Prints the generated Markdown file name if verbose mode is enabled.
void _printMarkdownFileName({
  required CLIConfig config,
  required DartFileData fileData,
}) {
  if (config.verbose) {
    final String outputFileName = fileData.filePath.split(Platform.pathSeparator).last.replaceAll('.dart', '.md');
    print('Generated Markdown: ${config.outputDirectory}/$outputFileName');
  }
}

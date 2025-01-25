import 'dart:io';

import 'package:dart_doc_markdown/models/cli_config.dart';
import 'package:dart_doc_markdown/src/dart_parser.dart';
import 'package:dart_doc_markdown/src/directory_traversal.dart';
import 'package:dart_doc_markdown/src/markdown_generator.dart';
import 'package:dart_doc_markdown/src/models/class_data.dart';
import 'package:dart_doc_markdown/src/models/dart_file_data.dart';
import 'package:dart_doc_markdown/src/models/method_data.dart';
import 'package:dart_doc_markdown/src/models/parameter_data.dart';

/// Entry point for the CLI application.
///
/// The purpose of this Dart CLI tool is to automate the process of generating documentation for a Dart/Flutter project.
/// This function wraps this process and, at a high leve, performs the following steps:
///
/// 	1.	**Traverse**: Scan the project directory for .dart files.
/// 	2.	**Parse**: Extract documentation-relevant data using Dart’s analyzer.
/// 	3.	**Generate**: Format the extracted data into Markdown files.
/// 	4.	**Write**: Save the Markdown files to the specified output directory.
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
      markdownGenerator.generateMarkdown(fileData, config.outputDirectory);

      // Log generated Markdown file name if verbose mode is enabled.
      _printMarkdownFileName(
        config: config,
        fileData: fileData,
      );
    } catch (e) {
      print('Error generating Markdown for file ${fileData.filePath}: $e');
    }
  }

  // TODO(Toglefritz): Step 4 - Write the Markdown files to storage.
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

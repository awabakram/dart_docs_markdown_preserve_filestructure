import 'package:dart_doc_markdown/models/cli_config.dart';
import 'package:dart_doc_markdown/src/class_data.dart';
import 'package:dart_doc_markdown/src/dart_file_data.dart';
import 'package:dart_doc_markdown/src/dart_parser.dart';
import 'package:dart_doc_markdown/src/directory_traversal.dart';
import 'package:dart_doc_markdown/src/method_data.dart';
import 'package:dart_doc_markdown/src/parameter_data.dart';

/// Entry point for the CLI application.
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
  for (final String filePath in dartFiles) {
    try {
      final DartFileData fileData = parser.parseFile(filePath);

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

  // TODO(Toglefritz): Step 3 - Generate Markdown documentation from parsed data.
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

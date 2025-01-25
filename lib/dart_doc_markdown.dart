import 'package:dart_doc_markdown/models/cli_config.dart';
import 'package:dart_doc_markdown/src/directory_traversal.dart';

/// Entry point for the CLI application.
void runDocumentationGeneration(CLIConfig config) {
  // Step 1: Traverse the directory to get all Dart files.
  final DirectoryTraversal traversal = DirectoryTraversal(
    projectDirectory: config.projectDirectory,
    ignorePatterns: DirectoryTraversal.loadIgnorePatterns('.dartdocmarkdownrc'),
  );
  final List<String> dartFiles = traversal.findDartFiles();

  // Log the files found (useful for debugging in verbose mode).
  if (config.verbose) {
    print('Found Dart files:');
    for (final String file in dartFiles) {
      print(file);
    }
  }

  // TODO(Toglefritz): Step 2 - Parse the Dart files (to be implemented).
}

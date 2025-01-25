import 'package:dart_doc_markdown/dart_doc_markdown.dart';
import 'package:dart_doc_markdown/models/cli_config.dart';

/// Entry point for the CLI application.
void main(List<String> arguments) {
  try {
    // Parse and validate arguments.
    final CLIConfig config = _parseArguments(arguments);

    // Delegate to the library with validated config.
    runDocumentationGeneration(config);
  } catch (e) {
    print('Error: $e');
    print('Usage: dart_to_docusaurus <project_directory> <output_directory> [--verbose]');
  }
}

/// Parses the CLI arguments and returns a configuration object.
CLIConfig _parseArguments(List<String> arguments) {
  try {
    return CLIConfig.fromArguments(arguments);
  } catch (e) {
    throw Exception('Failed to parse arguments: $e');
  }
}

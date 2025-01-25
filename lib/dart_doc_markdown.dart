library;

import 'models/cli_config.dart';

/// Entry point for the CLI application.
void runDocumentationGeneration(CLIConfig config) {
  // Core functionality to traverse the project, parse files, and generate Markdown.

  // TODO(Toglefritz): For testing, return the config object.
  print('Project Directory: ${config.projectDirectory}');
  print('Output Directory: ${config.outputDirectory}');
}
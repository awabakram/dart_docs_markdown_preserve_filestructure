import 'dart:io';

/// Represents the configuration for the CLI tool parsed from arguments.
class CLIConfig {
  /// The directory containing the Dart/Flutter project to document.
  final String projectDirectory;

  /// The directory where the generated Markdown files will be stored.
  final String outputDirectory;

  /// Optional flag to enable verbose logging.
  final bool verbose;

  /// Constructor to initialize the CLI configuration.
  CLIConfig({
    required this.projectDirectory,
    required this.outputDirectory,
    this.verbose = false,
  });

  /// Factory method to parse and validate arguments.
  factory CLIConfig.fromArguments(List<String> arguments) {
    // If the number of arguments is less than 2, throw an error.
    if (arguments.length < 2) {
      throw ArgumentError('Usage: dart_to_docusaurus <project_directory> <output_directory> [--verbose]');
    }

    // Extract the project directory, output directory, and optional verbose flag.
    final String projectDirectory = arguments[0];

    // Extract the project directory, output directory, and optional verbose flag.
    final String outputDirectory = arguments[1];

    // Determines if the verbose flag is present in the arguments.
    final bool verbose = arguments.contains('--verbose');

    // If either the project directory or output directory is empty, throw an error.
    if (projectDirectory.isEmpty || outputDirectory.isEmpty) {
      throw ArgumentError('Project directory and output directory must be specified and non-empty.');
    }

    // Check if a file exists at the project directory path.
    if (!Directory(projectDirectory).existsSync()) {
      throw ArgumentError('Project directory does not exist.');
    }

    return CLIConfig(
      projectDirectory: projectDirectory,
      outputDirectory: outputDirectory,
      verbose: verbose,
    );
  }
}

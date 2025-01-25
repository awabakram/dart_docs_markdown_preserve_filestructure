import 'dart:io';

/// Handles directory traversal to identify Dart files for documentation.
class DirectoryTraversal {
  /// The root directory to traverse.
  final String projectDirectory;

  /// List of patterns to ignore during traversal (e.g., directories or files).
  final List<String> ignorePatterns;

  /// Creates a new instance of [DirectoryTraversal].
  ///
  /// [projectDirectory] specifies the root directory to traverse.
  /// [ignorePatterns] allows specifying directories or files to exclude.
  DirectoryTraversal({
    required this.projectDirectory,
    this.ignorePatterns = const [],
  });

  /// Traverses the project directory recursively to find all `.dart` files.
  ///
  /// Returns a list of file paths to `.dart` files, excluding ignored files and directories.
  List<String> findDartFiles() {
    final List<String> dartFiles = [];
    final Directory directory = Directory(projectDirectory);

    if (!directory.existsSync()) {
      throw FileSystemException('The directory does not exist', projectDirectory);
    }

    // Recursively traverse the directory
    for (final FileSystemEntity entity in directory.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        if (!_isIgnored(entity.path)) {
          dartFiles.add(entity.path);
        }
      }
    }

    return dartFiles;
  }

  /// Checks whether a file path matches any of the ignore patterns.
  ///
  /// Returns `true` if the file path should be ignored, `false` otherwise.
  bool _isIgnored(String filePath) {
    for (final String pattern in ignorePatterns) {
      if (filePath.contains(pattern)) {
        return true;
      }
    }
    return false;
  }

  /// Loads ignore patterns from a configuration file (e.g., `.dartdocmarkdownrc`).
  ///
  /// If the file does not exist, an empty list is returned.
  static List<String> loadIgnorePatterns(String configFilePath) {
    final File configFile = File(configFilePath);

    if (!configFile.existsSync()) {
      return [];
    }

    // Read all lines from the configuration file.
    final List<String> lines = configFile.readAsLinesSync();

    // Trim whitespace from each line.
    final Iterable<String> trimmedLines = lines.map((String line) => line.trim());

    // Filter out empty lines.
    final Iterable<String> nonEmptyLines = trimmedLines.where((String line) => line.isNotEmpty);

    // Convert the result to a list and return it.
    return nonEmptyLines.toList();
  }
}

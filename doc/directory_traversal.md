# File: `./lib/src/directory_traversal.dart`

## Classes

### DirectoryTraversal

/// Handles directory traversal to identify Dart files for documentation.

#### Methods

- **findDartFiles()**
  - Return Type: `List<String>`
  - Documentation: /// Traverses the project directory recursively to find all `.dart` files.
///
/// Returns a list of file paths to `.dart` files, excluding ignored files and directories.

- **_isIgnored()**
  - Return Type: `bool`
  - Documentation: /// Checks whether a file path matches any of the ignore patterns.
///
/// Returns `true` if the file path should be ignored, `false` otherwise.
  - Parameters:
    - `filePath`: `String`

- **loadIgnorePatterns()**
  - Return Type: `List<String>`
  - Documentation: /// Loads ignore patterns from a configuration file (e.g., `.dartdocmarkdownrc`).
///
/// If the file does not exist, an empty list is returned.
  - Parameters:
    - `configFilePath`: `String`



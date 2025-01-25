# File: `./lib/src/dart_parser.dart`

## Classes

### DartParser

/// Responsible for parsing Dart files to extract documentation-relevant data.

#### Methods

- **parseFile()**
  - Return Type: `DartFileData`
  - Documentation: /// Parses a Dart file and extracts information about its classes, methods, and variables.
///
/// [filePath] is the path to the Dart file to be parsed.
///
/// Returns a [DartFileData] object containing extracted documentation-relevant data.
  - Parameters:
    - `filePath`: `String`

- **_extractClassData()**
  - Return Type: `ClassData`
  - Documentation: /// Extracts information about a class, including its methods and members.
///
/// [classDeclaration] is the AST node representing the class.
///
/// Returns a [ClassData] object containing the class name, comments, and its members.
  - Parameters:
    - `classDeclaration`: `ClassDeclaration`

- **_extractMethodData()**
  - Return Type: `MethodData`
  - Documentation: /// Extracts information about a method, including its parameters and return type.
///
/// [methodDeclaration] is the AST node representing the method.
///
/// Returns a [MethodData] object containing the method name, comments, parameters, and return type.
  - Parameters:
    - `methodDeclaration`: `MethodDeclaration`



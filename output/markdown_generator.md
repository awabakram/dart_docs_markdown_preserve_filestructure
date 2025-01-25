# File: `./lib/src/markdown_generator.dart`

## Class Documentation: `MarkdownGenerator`

### Overview

Responsible for generating Markdown documentation from parsed Dart file data.

### Methods

- **generateMarkdown()**
  - Return Type: `void`
  - Documentation: Generates Markdown documentation for a given [DartFileData] object.

 [fileData] contains the parsed information from a Dart file.
 [outputDirectory] specifies where the generated Markdown file should be saved.
  - Parameters:
    - `fileData`: `DartFileData`
    - `outputDirectory`: `String`

- **_sanitizeDocumentation()**
  - Return Type: `String`
  - Documentation: Sanitizes the documentation string by removing leading slashes and extra spaces.
  - Parameters:
    - `documentation`: `String?`

- **_generateClassMarkdown()**
  - Return Type: `String`
  - Documentation: Generates Markdown for a given class, including its methods and documentation.
  - Parameters:
    - `classData`: `ClassData`

- **_generateFunctionMarkdown()**
  - Return Type: `String`
  - Documentation: Generates Markdown for a given global function.
  - Parameters:
    - `functionData`: `FunctionData`

- **_generateMethodMarkdown()**
  - Return Type: `String`
  - Documentation: Generates Markdown for a given method, including its parameters and return type.
  - Parameters:
    - `methodData`: `MethodData`

- **_generateFileName()**
  - Return Type: `String`
  - Documentation: Generates a file name for the Markdown file based on the Dart file path.

 Removes directory paths and replaces `.dart` with `.md`.
  - Parameters:
    - `filePath`: `String`



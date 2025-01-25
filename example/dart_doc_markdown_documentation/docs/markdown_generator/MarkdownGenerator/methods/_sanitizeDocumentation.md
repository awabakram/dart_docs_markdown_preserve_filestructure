# Method: `_sanitizeDocumentation`

## Description

Sanitizes the documentation string by removing leading slashes and extra spaces.

 All entities within the Dart file data processed by this class contain `documentation` members, assuming
 documentation has been provided for the code entities. This documentation is in the form of Dartdoc comments
 for each class, member, method, or function. This method removes leading slashes (``) and trims any extra
 spaces to ensure the Documentation is clean and readable in the generated Markdown files.

## Return Type
`String`

## Parameters

- `documentation`: `String?`

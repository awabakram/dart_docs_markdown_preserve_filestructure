# Method: `generateMarkdown`

## Description

Generates Markdown documentation for a given [DartFileData] object.

 This is the main method for the [MarkdownGenerator]. It delegates to several private methods to generate
 the individual Markdown files for classes, methods, and global functions within the provided [DartFileData]
 object, which represents the contents of a single Dart file. The generated Markdown files are written to the
 specified [outputDirectory].

 [fileData] contains the parsed information from a Dart file.
 [outputDirectory] specifies where the generated Markdown files should be saved.

## Return Type
`void`

## Parameters

- `fileData`: `DartFileData`
- `outputDirectory`: `String`

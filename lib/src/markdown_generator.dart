import 'dart:io';

import 'package:dart_doc_markdown_generator/src/models/class_data.dart';
import 'package:dart_doc_markdown_generator/src/models/constructor_data.dart';
import 'package:dart_doc_markdown_generator/src/models/dart_file_data.dart';
import 'package:dart_doc_markdown_generator/src/models/field_data.dart';
import 'package:dart_doc_markdown_generator/src/models/function_data.dart';
import 'package:dart_doc_markdown_generator/src/models/method_data.dart';
import 'package:dart_doc_markdown_generator/src/models/parameter_data.dart';

/// A utility class for generating Markdown documentation for Dart/Flutter projects.
///
/// The [MarkdownGenerator] class is responsible for creating a structured set of Markdown documents
/// from parsed Dart file data. This is particularly useful for projects integrating with Markdown-based
/// documentation sites such as Docusaurus, enabling a clear, navigable documentation structure.
///
/// ### Purpose
/// This class processes a parsed representation of Dart files ([DartFileData]), extracting information
/// about classes, their members, constructors, and methods, as well as global functions and variables.
/// It then generates corresponding Markdown files with detailed documentation for each entity. The
/// resulting output is organized into a directory structure designed to facilitate easy navigation
/// and integration with a documentation site.
///
/// ### Process
/// The Markdown generation process follows these steps:
/// 1. **Traverse Classes**: For each class in a Dart file:
///    - Create an overview document containing:
///      - The class name and its Dartdoc comments.
///      - A list of dependencies (e.g., superclasses, mixins, interfaces).
///      - A list of all class members, including:
///        - Unnamed and factory constructors.
///        - Fields and their associated documentation.
///    - Create a folder named after the class, containing a subfolder (`methods/`) where
///      each method (public or private) has its own Markdown document. These documents include:
///      - The method name and Dartdoc comments.
///      - Details about its parameters, return type, and any exceptions thrown.
/// 2. **Document Global Functions and Variables**:
///    - Generate a single `global_functions.md` file at the root of the output directory.
///    - This file contains details for all global functions and variables in the Dart file,
///      including their names, Dartdoc comments, parameters, and return types.
///
/// ### Output Directory Structure
/// For a Dart file named `example.dart`, the following directory structure is generated:
///
/// ```plaintext
/// output/
/// └── example/
///     ├── ClassName/
///     │   ├── overview.md        // Documentation for the class, including members and constructors.
///     │   └── methods/
///     │       ├── method1.md     // Documentation for a specific method.
///     │       ├── method2.md
///     │       └── ...
///     └── global_functions.md   // Documentation for global functions and variables in the file.
/// ```
///
/// ### Integration with Documentation Sites
/// The generated Markdown files are designed for compatibility with Markdown-based documentation
/// platforms like Docusaurus. Each class and method is documented in a modular fashion, enabling
/// easy linking and navigation within a documentation site.
///
/// This class ensures that the documentation generated is comprehensive, readable, and easy to navigate.
class MarkdownGenerator {
  /// Generates Markdown documentation for a given [DartFileData] object.
  ///
  /// This is the main method for the [MarkdownGenerator]. It delegates to several private methods to generate
  /// the individual Markdown files for classes, methods, and global functions within the provided [DartFileData]
  /// object, which represents the contents of a single Dart file. The generated Markdown files are written to the
  /// specified [outputDirectory].
  ///
  /// [fileData] contains the parsed information from a Dart file.
  /// [outputDirectory] specifies where the generated Markdown files should be saved.
  void generateMarkdown(DartFileData fileData, String outputDirectory) {
    // Create a base folder for this Dart file’s documentation.
    final String baseFolder = '$outputDirectory/${_generateFileName(fileData.filePath)}';
    Directory(baseFolder).createSync(recursive: true);

    // Generate documentation for each class in the file.
    for (final ClassData classData in fileData.classes) {
      // Generate the overview Markdown document for the class.
      _generateClassOverview(classData, baseFolder);

      // Generate documentation for the class methods.
      if (classData.methods.isNotEmpty) {
        _generateClassMethodsDocumentation(classData, '$baseFolder/${classData.name}');
      }
    }

    // Generate global function documentation at the root of the Dart file folder.
    if (fileData.globalFunctions.isNotEmpty) {
      _generateGlobalFunctionsDocumentation(fileData, baseFolder);
    }
  }

  /// Generates a file name for the Markdown file based on the Dart file path.
  ///
  /// Removes directory paths and replaces `.dart` with `.md`.
  String _generateFileName(String filePath) {
    return filePath.split(Platform.pathSeparator).last.replaceAll('.dart', '');
  }

  /// Sanitizes the documentation string by removing leading slashes and extra spaces.
  ///
  /// All entities within the Dart file data processed by this class contain `documentation` members, assuming
  /// documentation has been provided for the code entities. This documentation is in the form of Dartdoc comments
  /// for each class, member, method, or function. This method removes leading slashes (`///`) and trims any extra
  /// spaces to ensure the Documentation is clean and readable in the generated Markdown files.
  String _sanitizeDocumentation(String? documentation) {
    return documentation?.replaceAll('///', '').replaceAll('/// ', '').trim() ?? '';
  }

  /// Generates an overview Markdown document for a class.
  ///
  /// The generated document includes:
  ///
  /// - The class name and its Dartdoc comment.
  /// - A list of dependencies (e.g., superclass, mixins, and interfaces).
  /// - A list of class members (fields) and their documentation.
  /// - A list of constructors, including their Dartdoc comments and parameters.
  void _generateClassOverview(ClassData classData, String baseFolder) {
    // Create a folder for the class documentation.
    final String classFolder = '$baseFolder/${classData.name}';
    Directory(classFolder).createSync(recursive: true);

    // Initialize the buffer for the overview document.
    final StringBuffer overviewBuffer = StringBuffer()
      ..writeln('# Overview for `${classData.name}`\n')
      ..writeln('## Description\n')
      ..writeln('${_sanitizeDocumentation(classData.documentation)}\n');

    // Add dependencies.
    if (classData.dependencies.isNotEmpty) {
      overviewBuffer
        ..writeln('## Dependencies\n')
        ..writeln('- ${classData.dependencies.join(', ')}\n');
    }

    // Add class members (fields).
    if (classData.fields.isNotEmpty) {
      overviewBuffer.writeln('## Members\n');
      for (final FieldData member in classData.fields) {
        overviewBuffer.writeln('- **${member.name}**: `${member.type ?? "dynamic"}`');
        if (member.documentation != null && member.documentation!.isNotEmpty) {
          overviewBuffer.writeln('  ${_sanitizeDocumentation(member.documentation)}\n');
        }
      }
    }

    // Add constructors.
    if (classData.constructors.isNotEmpty) {
      overviewBuffer.writeln('## Constructors\n');
      for (final ConstructorData constructor in classData.constructors) {
        overviewBuffer
          ..writeln('### ${constructor.name}')
          ..writeln('${_sanitizeDocumentation(constructor.documentation)}\n');
        // Add parameters if the constructor has any and is not the unnamed constructor.
        if (constructor.parameters.isNotEmpty && !constructor.isUnnamedConstructor) {
          overviewBuffer.writeln('#### Parameters\n');
          for (final ParameterData param in constructor.parameters) {
            overviewBuffer.writeln('- `${param.name}`: `${param.type ?? "dynamic"}`');
          }
        }
      }
    }

    // Write the overview Markdown file.
    File('$classFolder/overview.md')
      ..createSync()
      ..writeAsStringSync(overviewBuffer.toString());
  }

  /// Generates Markdown documentation for members within the provided [ClassData].
  ///
  /// For each method in the class, a separate Markdown file is created containing:
  ///
  /// - The method name and its Dartdoc comment.
  /// - Details about the method's parameters, return type, and exceptions thrown.
  ///
  /// The generated Markdown files are stored in a `methods/` subfolder within the class folder.
  void _generateClassMethodsDocumentation(ClassData classData, String classFolder) {
    if (classData.methods.isNotEmpty) {
      final String methodsFolder = '$classFolder/methods';
      Directory(methodsFolder).createSync();

      for (final MethodData method in classData.methods) {
        final StringBuffer methodBuffer = StringBuffer()
          ..writeln('# Method: `${method.name}`\n')
          ..writeln('## Description\n')
          ..writeln('${_sanitizeDocumentation(method.documentation)}\n');

        if (method.returnType != null) {
          methodBuffer.writeln('## Return Type\n`${method.returnType}`\n');
        }

        if (method.parameters.isNotEmpty) {
          methodBuffer.writeln('## Parameters\n');
          for (final ParameterData param in method.parameters) {
            methodBuffer.writeln('- `${param.name}`: `${param.type ?? "dynamic"}`');
          }
        }

        File('$methodsFolder/${method.name}.md')
          ..createSync()
          ..writeAsStringSync(methodBuffer.toString());
      }
    }
  }

  /// Generates Markdown for a given global function.
  String _generateFunctionMarkdown(FunctionData functionData) {
    final StringBuffer buffer = StringBuffer()
      ..writeln('## ${functionData.name}\n')
      ..writeln('${_sanitizeDocumentation(functionData.documentation)}\n');

    if (functionData.returnType != null) {
      buffer.writeln('- **Return Type:** `${functionData.returnType}`');
    }

    if (functionData.parameters.isNotEmpty) {
      buffer.writeln('- **Parameters:**');
      for (final ParameterData param in functionData.parameters) {
        buffer.writeln('  - `${param.name}`: `${param.type ?? "dynamic"}`');
      }
    }

    return buffer.toString();
  }

  /// Generates Markdown documentation for global functions and variables in a Dart file.
  void _generateGlobalFunctionsDocumentation(DartFileData fileData, String baseFolder) {
    final StringBuffer globalBuffer = StringBuffer()..writeln('# Global Functions and Variables\n');
    for (final FunctionData functionData in fileData.globalFunctions) {
      globalBuffer.writeln(_generateFunctionMarkdown(functionData));
    }

    // Write the Markdown file for global functions.
    File('$baseFolder/global_functions.md')
      ..createSync()
      ..writeAsStringSync(globalBuffer.toString());
  }
}

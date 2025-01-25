import 'package:dart_doc_markdown/src/models/parameter_data.dart';

/// Represents a global function or variable and its associated metadata.
///
/// **Purpose in the CLI Tool:**
/// The `FunctionData` class serves as a data structure for storing detailed metadata about global functions and
/// variables encountered during the analysis of Dart files. This metadata is used to generate structured Markdown
/// documentation, enabling a clear and comprehensive representation of globally scoped entities in the Dart project.
///
/// **How It Works:**
/// - During the parsing phase, the `DartParser` class identifies and processes global functions and variables within a
///   Dart file, creating a `FunctionData` object for each one.
/// - Each `FunctionData` object captures the name, Dartdoc comments, return type, and parameters of the function or
///   variable.
/// - This data is later used by the `MarkdownGenerator` class to generate a `global_functions.md` document for each
///   Dart file, ensuring that globally scoped entities are documented alongside class-specific details.
///
/// **Responsibilities:**
/// The `FunctionData` class plays a central role in documenting global functions and variables. Its primary
/// responsibilities include:
/// - **Encapsulation:**
///   Provide a structured way to store metadata about global functions and variables.
/// - **Integration with Parsing:**
///   Allow the `DartParser` to populate detailed information about each function, including its
///   parameters, return type, and documentation.
/// - **Support for Markdown Generation:**
///   Enable the `MarkdownGenerator` to produce a clear and organized representation of global
///   functions in the output documentation.
///
/// **Fields:**
/// - `name`:
///   The name of the function or variable. This serves as the identifier for the entity being documented.
/// - `documentation`:
///   The Dartdoc comment associated with the function or variable, providing descriptive details for the generated
///   documentation. If no documentation is provided in the source code, this field may be `null`.
/// - `returnType`:
///   The return type of the function, if any. If the return type is not explicitly declared in the source code, this
///   field may be `null`.
/// - `parameters`:
///   A list of `ParameterData` objects, each representing a parameter of the function. This includes the parameter's
///   name, type, and additional metadata.
///
/// **Usage in Markdown Generation:**
/// The `MarkdownGenerator` class uses `FunctionData` to create documentation for global functions and variables. The
/// metadata is included in the `global_functions.md` file, which provides a detailed overview of all global entities
/// in the analyzed Dart file. Each function is documented with:
/// - Its name as a section header.
/// - The Dartdoc comment as a description.
/// - A list of parameters with their types and names.
/// - The return type of the function.
///
/// **Integration with Parsing:**
/// The `DartParser` class extracts metadata from global functions and variables, populating `FunctionData` objects.
/// This ensures that all globally scoped entities are accurately captured and included in the generated documentation.
class FunctionData {
  /// The name of the function.
  final String name;

  /// The documentation comment for the function, if any.
  final String? documentation;

  /// The return type of the function, if any.
  final String? returnType;

  /// List of parameters for the function.
  final List<ParameterData> parameters;

  /// Constructor to initialize the function data.
  FunctionData({
    required this.name,
    this.documentation,
    this.returnType,
    this.parameters = const [],
  });
}

import 'package:dart_doc_markdown/src/models/parameter_data.dart';

/// Represents metadata for a method, including its name, documentation, return type, and parameters.
///
/// **Purpose in the CLI Tool:**
/// The `MethodData` class is an essential component of the CLI tool's architecture. It is responsible for encapsulating
/// all relevant metadata about a Dart method, making this information accessible for generating structured Markdown
/// documentation. By organizing details such as the method name, parameters, and Dartdoc comments, the `MethodData`
/// class ensures that the tool can produce detailed and navigable documentation for each method in the analyzed Dart
/// files.
///
/// **How It Works:**
/// - During the parsing phase, the `DartParser` class identifies method declarations in a Dart file's classes. For
///   each method, it creates a `MethodData` object containing metadata extracted from the Dart Abstract Syntax Tree.
/// - Each `MethodData` object captures the following details about a method:
///   - Its name.
///   - The Dartdoc comment describing the method, if present.
///   - The return type of the method, if explicitly declared.
///   - A list of parameters for the method, represented as `ParameterData` objects.
/// - This data is then passed to the `MarkdownGenerator`, which uses it to create Markdown documents for each method,
///   including standalone files for detailed documentation when required.
///
/// **Responsibilities:**
/// The `MethodData` class plays a critical role in documenting methods effectively. Its main responsibilities are:
/// - **Encapsulation:**
///   Store all metadata related to a method in a structured way, allowing other components of the tool to access
///   it efficiently.
/// - **Parameter Representation:**
///   Maintain a list of parameters using `ParameterData`, ensuring that each parameter's name and type are documented
///   alongside the method.
/// - **Support for Markdown Generation:**
///   Provide a comprehensive data model for the `MarkdownGenerator` to produce detailed method documentation,
///   including usage of parameters and return types.
///
/// **Fields:**
/// - `name`:
///   The name of the method, as defined in the Dart class. This is used as the primary identifier for the method
///   in the generated documentation.
/// - `documentation`:
///   The Dartdoc comment associated with the method, providing descriptive information for the generated
///   documentation. If no Dartdoc comment is present, this field may be `null`.
/// - `returnType`:
///   The return type of the method, if explicitly declared in the Dart code. If the method does not specify a
///   return type, this field may be `null`.
/// - `parameters`:
///   A list of `ParameterData` objects, each representing a parameter of the method. This includes the parameter's
///   name, type, and additional metadata.
///
/// **Usage in Markdown Generation:**
/// The `MarkdownGenerator` class uses `MethodData` to create Markdown documentation for methods. This includes:
/// - A section header with the method's name.
/// - A description of the method, derived from its Dartdoc comment.
/// - A list of parameters, showing their names and types.
/// - The return type of the method, if applicable.
///
/// **Integration with Parsing:**
/// The `DartParser` class extracts metadata from method declarations in Dart classes, populating `MethodData`
/// objects. This ensures that all relevant details about methods are captured and included in the generated
/// documentation.
class MethodData {
  /// The name of the method.
  final String name;

  /// The documentation comment for the method, if any.
  final String? documentation;

  /// The return type of the method, if any.
  final String? returnType;

  /// List of parameters for the method.
  final List<ParameterData> parameters = [];

  /// Constructor to initialize the method data.
  MethodData({
    required this.name,
    this.documentation,
    this.returnType,
  });
}

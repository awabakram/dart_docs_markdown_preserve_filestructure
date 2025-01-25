import 'package:dart_doc_markdown_generator/src/models/parameter_data.dart';

/// Represents metadata for a Dart constructor, including its name, documentation, and parameters.
///
/// **Purpose in the CLI Tool:**
/// The `ConstructorData` class is a critical component of the CLI tool's architecture. It serves as a data structure
/// for capturing all relevant details about constructors in Dart classes, extracted during the parsing phase. This
/// information is subsequently used to generate Markdown documentation for each class, ensuring that constructors are
/// accurately documented along with their associated parameters and descriptions.
///
/// **How It Works:**
/// - The `DartParser` class uses the `_extractConstructorData` method to populate instances of `ConstructorData` by
/// traversing the Abstract Syntax Tree (AST) of a Dart file.
/// - Each `ConstructorData` object encapsulates the following details:
///   - The name of the constructor.
///   - The Dartdoc comment associated with the constructor, if any.
///   - A list of parameters defined in the constructor, stored as `ParameterData` objects.
///   - A flag (`isUnnamedConstructor`) to indicate whether the constructor is unnamed.
///
/// **Responsibilities:**
/// The primary responsibilities of the `ConstructorData` class are:
/// - **Encapsulation:**
///   Provide a structured way to store all information about a single constructor, ensuring that the
///   data can be easily accessed during Markdown generation.
/// - **Integration:**
///   Serve as part of the `ClassData` object, allowing the CLI tool to generate comprehensive class
///   documentation, including details about all constructors.
/// - **Support for Markdown Generation:**
///   Enable the `MarkdownGenerator` class to include constructors in the `overview.md` file for
///   each class, listing their names, documentation, and parameters.
///
/// **Fields:**
/// - `name`: The name of the constructor, as extracted from the Dart code. If the constructor is unnamed, this will
///    typically be a default placeholder or empty string.
/// - `documentation`: The Dartdoc comment associated with the constructor, used to provide descriptive information in
///    the generated documentation.
/// - `parameters`: A list of `ParameterData` objects, each representing a parameter defined in the constructor,
///    including its name, type, and additional metadata.
/// - `isUnnamedConstructor`: A boolean flag indicating whether the constructor is unnamed. This is particularly useful
///    for distinguishing default constructors from named or factory ones.
///
/// **Usage in Markdown Generation:**
/// The `MarkdownGenerator` class uses `ConstructorData` objects to include detailed constructor documentation in class
/// overview files. For example:
/// - The constructor's name is displayed as a section header.
/// - The Dartdoc comment is included as a description beneath the header.
/// - Parameters are listed in a structured format, showing their names and types.
class ConstructorData {
  /// The name of the constructor.
  final String name;

  /// The documentation comment for the constructor, if any.
  final String? documentation;

  /// List of parameters for the constructor.
  final List<ParameterData> parameters = [];

  /// Determines if the constructor is unnamed.
  final bool isUnnamedConstructor;

  /// Constructor to initialize the constructor data.
  ConstructorData({
    required this.name,
    this.documentation,
    this.isUnnamedConstructor = false,
  });
}

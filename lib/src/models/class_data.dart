import 'package:dart_doc_markdown/src/models/constructor_data.dart';
import 'package:dart_doc_markdown/src/models/field_data.dart';
import 'package:dart_doc_markdown/src/models/method_data.dart';

/// Represents the parsed data for a Dart class, including its members, methods, constructors, and dependencies.
///
/// The [ClassData] class serves as a container for all the metadata extracted from a Dart class during the parsing
/// phase of the CLI tool. It is designed to store a detailed representation of a Dart class and its associated elements,
/// enabling the generation of Markdown documentation for each class in a structured and modular format.
///
/// **Purpose in the CLI Tool:**
/// The `ClassData` class is a core component in the overall architecture of the CLI tool. It provides a way to
/// encapsulate all relevant information about a Dart class, which is later used to generate documentation files. This
/// ensures that the documentation for each class is both comprehensive and easy to navigate when integrated into
/// Markdown-based documentation platforms like Docusaurus.
///
/// **Responsibilities:**
/// - **Store Class Metadata**:
///   - The name of the class.
///   - The Dartdoc comment for the class, if any.
///
/// - **Capture Class Members**:
///   - Fields (member variables) and their metadata, such as name, type, and Dartdoc comment.
///
/// - **Document Class Methods**:
///   - Methods, including their names, Dartdoc comments, parameters, return types, and visibility.
///
/// - **Record Constructors**:
///   - Unnamed and factory constructors, with their associated parameters and documentation.
///
/// - **Track Dependencies**:
///   - Superclasses, mixins, and interfaces that the class depends on.
///
/// **Usage in the Markdown Generation Process:**
/// During the parsing phase:
/// 1. The `DartParser` class extracts information from Dart classes in the source code.
/// 2. For each class encountered, a `ClassData` object is created and populated with metadata for
///    fields, methods, constructors, and dependencies.
///
/// During the Markdown generation phase:
/// 1. The `MarkdownGenerator` uses the `ClassData` object to create:
///    - An `overview.md` document for the class, summarizing its metadata.
///    - Individual documentation files for each method, placed in a dedicated folder.
///
/// **Fields:**
/// - **`name`**: The name of the class.
/// - **`documentation`**: The Dartdoc comment associated with the class.
/// - **`fields`**: A list of fields (member variables) belonging to the class.
/// - **`methods`**: A list of methods defined in the class.
/// - **`constructors`**: A list of constructors, including unnamed and factory constructors.
/// - **`dependencies`**: A list of dependencies, such as superclass, mixins, and interfaces.
///
/// This class is central to the CLI tool's ability to process and document Dart classes effectively.
class ClassData {
  /// The name of the class.
  final String name;

  /// The documentation comment for the class, if any.
  final String? documentation;

  /// A list of fields (member variables) belonging to the class.
  final List<FieldData> fields = [];

  /// List of methods belonging to the class.
  final List<MethodData> methods = [];

  /// List of constructors belonging to the class.
  final List<ConstructorData> constructors = [];

  /// List of dependencies (superclasses, mixins, or interfaces) for the class.
  final List<String> dependencies = [];

  /// Constructor to initialize the class data.
  ClassData({
    required this.name,
    this.documentation,
  });
}

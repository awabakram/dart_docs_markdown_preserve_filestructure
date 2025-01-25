import 'package:dart_doc_markdown/src/models/constructor_data.dart';
import 'package:dart_doc_markdown/src/models/method_data.dart';

/// Data class to represent a class and its members.
class ClassData {
  /// The name of the class.
  final String name;

  /// The documentation comment for the class, if any.
  final String? documentation;

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

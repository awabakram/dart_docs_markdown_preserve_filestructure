import 'package:dart_doc_markdown/src/models/method_data.dart';

/// Data class to represent a class and its members.
class ClassData {
  /// The name of the class.
  final String name;

  /// The documentation comment for the class, if any.
  final String? documentation;

  /// List of methods belonging to the class.
  final List<MethodData> methods = [];

  /// Constructor to initialize the class data.
  ClassData({required this.name, this.documentation});
}

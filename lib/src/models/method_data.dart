import 'package:dart_doc_markdown/src/models/parameter_data.dart';

/// Data class to represent a method and its parameters.
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

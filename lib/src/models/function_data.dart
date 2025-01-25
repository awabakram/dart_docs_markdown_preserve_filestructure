import 'package:dart_doc_markdown/src/models/parameter_data.dart';

/// Represents a global function and its metadata.
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

import 'package:dart_doc_markdown/src/models/parameter_data.dart';

/// Represents a constructor and its metadata.
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

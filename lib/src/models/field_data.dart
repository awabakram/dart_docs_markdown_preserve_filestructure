/// Represents a field (member variable) within a class and its metadata.
class FieldData {
  /// The name of the field.
  final String name;

  /// The type of the field, if specified.
  final String? type;

  /// The documentation comment for the field, if any.
  final String? documentation;

  /// Constructor to initialize the field data.
  FieldData({
    required this.name,
    this.type,
    this.documentation,
  });
}

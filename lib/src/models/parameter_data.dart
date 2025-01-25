/// Data class to represent a method parameter.
class ParameterData {
  /// The name of the parameter.
  final String name;

  /// The type of the parameter, if any.
  final String? type;

  /// Constructor to initialize the parameter data.
  ParameterData({
    required this.name,
    this.type,
  });
}

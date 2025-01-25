import 'package:dart_doc_markdown/src/models/class_data.dart';
import 'package:dart_doc_markdown/src/models/function_data.dart';

/// Data class to represent the parsed content of a Dart file.
class DartFileData {
  /// The path of the Dart file.
  final String filePath;

  /// List of classes found in the file.
  final List<ClassData> classes = [];

  /// List of global functions found in the file.
  final List<FunctionData> globalFunctions = [];

  /// Constructor to initialize the file path.
  DartFileData({
    required this.filePath,
  });
}

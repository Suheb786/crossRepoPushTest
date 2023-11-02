import 'package:domain/error/api_error_model.dart';

class ErrorInfo {
  final String message;
  final int? code;
  final String description;
  final APIErrorModel? apiErrorModel;

  ErrorInfo({required this.message, this.code, this.description = '', this.apiErrorModel});
}

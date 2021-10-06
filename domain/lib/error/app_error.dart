import 'package:domain/constants/error_types.dart';
import 'package:domain/model/base/error_info.dart';

class AppError implements Exception {
  ErrorType type;
  ErrorInfo error;
  Exception cause;

  AppError({
    required this.cause,
    required this.error,
    required this.type,
  });
}

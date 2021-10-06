import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';

class LocalError extends BaseError {
  LocalError({
    required String message,
    required int localError,
    required Exception cause,
  }) : super(
            error: ErrorInfo(message: message, code: localError), cause: cause);

  @override
  String getFriendlyMessage() {
    return "${error.message}";
  }

  @override
  AppError transform() {
    switch (error.code) {
      case 1:
        return AppError(error: error, cause: cause, type: ErrorType.UI);
      default:
        return AppError(
            error: error, cause: cause, type: ErrorType.IOEXCEPTION);
    }
  }
}

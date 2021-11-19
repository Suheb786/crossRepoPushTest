import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';

class NetworkError extends BaseError {
  NetworkError(
      {required int httpError,
      String errorCode: "",
      String message: "",
      required Exception cause,
      String description: ""})
      : super(
            error: ErrorInfo(
                code: httpError, message: errorCode, description: description),
            cause: cause);

  @override
  String getFriendlyMessage() {
    return "${this.error.message}";
  }

  @override
  AppError transform() {
    switch (error.code) {
      case 503:
        return AppError(
            error: error,
            cause: cause,
            type: ErrorType.NET_NO_INTERNET_CONNECTION);

      case 504:
        return AppError(
            cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      case 502:
        return AppError(
            cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      case 404:
        return AppError(
            cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      default:
        print('error message-->${error.message}');
        switch (error.message) {
          case "err-014":
            print('error message--returned');
            return AppError(
                cause: cause, error: error, type: ErrorType.DEVICE_NOT_FOUND);

          default:
            print('error message-- default returned');
            return AppError(
                cause: cause, error: error, type: ErrorType.NETWORK);
        }
    }
  }
}

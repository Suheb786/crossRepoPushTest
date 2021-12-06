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
        print("I AM EXECUTED with error code ${error.message}");
        switch (error.message) {
          case "err-014":
            return AppError(
                cause: cause, error: error, type: ErrorType.DEVICE_NOT_FOUND);

          case "ex-058":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_SAVING_ID_CARD);

          case "err-154":
            return AppError(
                cause: cause, error: error, type: ErrorType.ID_CARD_EXPIRED);

          case "err-061":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.INVALID_USERNAME_PASSWORD);

          case "err-151":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ID_CARD_NOT_ALLOWED);

          case "ex-050":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_SAVING_STATUS);

          case "ex-055":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_WHILE_UPLOADING_IMAGE);

          case "err-069":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.INVALID_NETWORK_OTP);

          case "err-070":
            return AppError(
                cause: cause, error: error, type: ErrorType.OTP_EXPIRED);

          case "suc-004":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.EMAIL_ALREADY_EXIST);

          case "err-280":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.OTP_VERIFY_LIMIT_EXCEEDED);

          case "ex-017":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_CREATING_ACCOUNT);

          case "err-020":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.UNABLE_TO_VERIFY_ID_CARD);

          case "err-047":
            return AppError(
                cause: cause, error: error, type: ErrorType.INVALID_USER);

          case "err-060":
            return AppError(
                cause: cause, error: error, type: ErrorType.ERROR_WHILE_LOGOUT);

          case "err-235":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.MOBILE_NUMBER_EXIST);

          case "err-033":
            return AppError(
                cause: cause, error: error, type: ErrorType.USER_NOT_REGISTER);

          case "ex-153":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_WHILE_REGISTRATION);

          case "ex-007":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_GET_ADDITIONAL_DOCUMENTATION);

          case "err-062":
            return AppError(
                cause: cause, error: error, type: ErrorType.ACCOUNT_LOCKED);

          default:
            return AppError(
                cause: cause, error: error, type: ErrorType.NETWORK);
        }
    }
  }
}

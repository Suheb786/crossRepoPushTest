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

      case 1500:
        return AppError(
            cause: cause, error: error, type: ErrorType.CALL_HANGUP_ERROR);

      case 1501:
        return AppError(
            cause: cause,
            error: error,
            type: ErrorType.INIT_INFOBIP_PLUGIN_ERROR);

      case 1502:
        return AppError(
            cause: cause, error: error, type: ErrorType.GET_CALL_TOKEN_ERROR);

      case 1503:
        return AppError(
            cause: cause, error: error, type: ErrorType.ESTABLISH_CALL_ERROR);
      case 1504:
        return AppError(
            cause: cause,
            error: error,
            type: ErrorType.GET_CALL_DURATION_ERROR);

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

          case "ex-131":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.CHECK_PASSWORD_CRED_ERROR);

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

          case "err-349":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.INVALID_BENEFICIARY);

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

          case "ex-018":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_WHILE_GET_ACCOUNT);

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

          case "err-063":
            return AppError(
                cause: cause, error: error, type: ErrorType.INVALID_USERNAME);

          case "err-293":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ACCOUNT_INQUIRY_WENT_WRONG);

          case "err-064":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.WENT_WRONG_WHILE_LOGIN);

          case "ex-019":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_GET_ACCOUNT_DETAILS);

          case "err-208":
            return AppError(
                cause: cause, error: error, type: ErrorType.ACCOUNT_NOT_FOUND);

          case "err-069":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.INVALID_OTP_ENTERED);

          case "err-147":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.BENEFICIARY_NOT_FOUND);

          case "err-166":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_WHILE_BALANCE_INQUIRY);

          case "err-148":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.INSUFFICIENT_BALANCE);

          case "err-304":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.REQUEST_NOT_COMPLETED);

          case "ex-011":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_WHILE_GET_COMBO_VALUES);

          case "err-005":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.USER_ALREADY_EXISTS);

          case "err-015":
            return AppError(
                cause: cause, error: error, type: ErrorType.PLEASE_TRY_AGAIN);

          case "err-054":
            return AppError(
                cause: cause, error: error, type: ErrorType.ERROR_ACCESSING_ID);

          case "ex-048":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_GETTING_FATCA_CRS);

          case "ex-163":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_WHILE_GETTING_DASHBOARD);

          case "Err-SN1":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.MOBILE_ALREADY_EXIST);

          case "err-125":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.DO_NOT_RECOMMEND_TO_USE_PREVIOUS_TENPASS);

          case "err-351":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.CURRENT_PASSWORD_INCORRECT);

          case "ex-191":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_PROCESS_WHILE_LOAN_REQUEST);

          case "ex-002":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_WHILE_GETTING_ACCOUNT_CLOSE_OTP);

          case "err-022":
            return AppError(
                cause: cause, error: error, type: ErrorType.INVALID_DOCUMENT);

          case "err-053":
            return AppError(
                cause: cause, error: error, type: ErrorType.ID_CARD_NOT_FOUND);

          case "err-071":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.INVALID_BENEFICIARY);

          case "ex-187":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.CHANGE_CARD_PIN_ERROR);

          case "err-210":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.ERROR_WHILE_LINKING_DEBIT_CARD);

          default:
            return AppError(
                cause: cause, error: error, type: ErrorType.NETWORK);
        }
    }
  }
}

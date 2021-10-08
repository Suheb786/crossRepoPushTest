import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:neo_bank/generated/l10n.dart';

class ErrorParser {
  ErrorParser._();

  static String getLocalisedStringError(
      {AppError? error, required S localisedHelper}) {
    switch (error?.type) {
      case ErrorType.IOEXCEPTION:
        return localisedHelper.appName;
      case ErrorType.UI:
        return localisedHelper.appName;
      case ErrorType.NETWORK:
        return localisedHelper.appName;
      case ErrorType.NET_SERVER_MESSAGE:
        return localisedHelper.appName;
      case ErrorType.NET_NO_INTERNET_CONNECTION:
        return localisedHelper.appName;
      case ErrorType.DATABASE:
        return localisedHelper.appName;
      case ErrorType.DATABASE_NOT_SUPPORTED:
        return localisedHelper.appName;
      case ErrorType.DB_ERROR1:
        return localisedHelper.appName;
      case ErrorType.DB_USER_NOT_FOUND:
        return localisedHelper.appName;
      case ErrorType.INVALID_PIN:
        return localisedHelper.appName;
      case ErrorType.NO_DOCUMENT_FOUND:
        return localisedHelper.appName;
      case ErrorType.INVALID_MOBILE:
        return localisedHelper.enterValidMobileNumber;
      default:
        return "";
    }
  }
}

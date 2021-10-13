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
      case ErrorType.INVALID_OTP:
        return localisedHelper.enterValidOtp;
      case ErrorType.EMPTY_EMAIL:
        return localisedHelper.emptyEmailMessage;
      case ErrorType.INVALID_EMAIL:
        return localisedHelper.enterValidEmail;
      case ErrorType.EMPTY_PASSWORD:
        return localisedHelper.enterPassword;
      case ErrorType.EMPTY_CONFIRM_PASSWORD:
        return localisedHelper.enterConfirmPassword;
      case ErrorType.PASSWORD_MISMATCH:
        return localisedHelper.passwordMismatch;
      case ErrorType.CONDITION_NOT_CHECKED:
        return localisedHelper.retrieveConditionNotChecked;
      case ErrorType.EMPTY_NAME:
        return localisedHelper.emptyName;
      case ErrorType.EMPTY_ID_NUMBER:
        return localisedHelper.emptyIdNumber;
      case ErrorType.EMPTY_DATE_OF_BIRTH:
        return localisedHelper.emptyDob;
      case ErrorType.EMPTY_NATIONALITY:
        return localisedHelper.emptyNationality;
      case ErrorType.EMPTY_EXPIRY_DATE:
        return localisedHelper.emptyExpiryDate;
      case ErrorType.EMPTY_GENDER:
        return localisedHelper.emptyGender;
      case ErrorType.EMPTY_RESIDENT_COUNTRY:
        return localisedHelper.emptyResidentCountry;
      case ErrorType.EMPTY_HOME_ADDRESS:
        return localisedHelper.emptyHomeAddress;
      case ErrorType.EMPTY_STREET_ADDRESS:
        return localisedHelper.emptyStreetAddress;
      case ErrorType.EMPTY_BUILDING_NAME_OR_NUMBER:
        return localisedHelper.emptyBuildingNameOrNo;
      default:
        return "";
    }
  }
}

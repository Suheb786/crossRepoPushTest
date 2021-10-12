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
      case ErrorType.INVALID_EMPLOYMENT_STATUS:
        return localisedHelper.invalidEmploymentStatus;
      case ErrorType.INVALID_OCCUPATION:
        return localisedHelper.invalidOccupation;
      case ErrorType.INVALID_SOURCE_INCOME:
        return localisedHelper.invalidMainSourceIncome;
      case ErrorType.INVALID_MONTHLY_INCOME:
        return localisedHelper.invalidMonthlyIncome;
      case ErrorType.INVALID_ANNUAL_INCOME:
        return localisedHelper.invalidAnnualIncome;
      case ErrorType.INVALID_PURPOSE_OF_ACCOUNT_OPENING:
        return localisedHelper.invalidPurposeOfOpeningAccount;
      case ErrorType.INVALID_EMPLOYER_NAME:
        return localisedHelper.invalidEmployerName;
      case ErrorType.INVALID_EMPLOYER_COUNTRY:
        return localisedHelper.invalidEmployerCountry;
      case ErrorType.INVALID_EMPLOYER_CITY:
        return localisedHelper.employerCity;
      case ErrorType.INVALID_EMPLOYER_CONTACT:
        return localisedHelper.invalidEmployerContact;
      case ErrorType.INVALID_ADDITIONAL_SOURCE_INCOME:
        return localisedHelper.invalidAdditionSourceIncome;
      case ErrorType.INVALID_TOTAL_ADDITIONAL_INCOME:
        return localisedHelper.invalidTotalAdditionalIncome;
      case ErrorType.EMPTY_EMAIL:
        return localisedHelper.emptyEmailMessage;
      case ErrorType.INVALID_EMAIL:
        return localisedHelper.enterValidEmail;
      default:
        return "";
    }
  }
}

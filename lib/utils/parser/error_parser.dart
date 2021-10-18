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
        return localisedHelper.invalidEmployerCity;
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
      case ErrorType.INVALID_TAX_COUNTRY:
        return localisedHelper.invalidTaxCountry;
      case ErrorType.INVALID_TIN_NUMBER:
        return localisedHelper.invalidTinNumber;
      case ErrorType.INVALID_REASON_OF_UNAVAILABILITY:
        return localisedHelper.invalidReasonUnavailability;
      case ErrorType.INVALID_EXPLANATION_FOR_UNAVAILABILITY:
        return localisedHelper.invalidExplanationForUnavailability;
      case ErrorType.INVALID_NAME:
        return localisedHelper.enterValidSpouseName;
      case ErrorType.INVALID_NATURE:
        return localisedHelper.enterValidNature;
      case ErrorType.INVALID_RELATIONSHIP:
        return localisedHelper.enterValidRelationshipWithPEP;
      case ErrorType.INVALID_PERSON_NAME:
        return localisedHelper.enterValidPersonsName;
      case ErrorType.INVALID_PERSON_ROLE:
        return localisedHelper.enterValidPersonsRole;
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
      case ErrorType.INVALID_EXPECTED_ANNUAL_TRANSACTION:
        return localisedHelper.invalidExpectedAnnualTransaction;
      case ErrorType.INVALID_EXPECTED_MONTHLY_TRANSACTION:
        return localisedHelper.invalidExpectedMonthlyTransaction;
      case ErrorType.INVALID_TYPES_OF_TRANSACTION:
        return localisedHelper.invalidTypesOfTransaction;

      default:
        return "";
    }
  }
}

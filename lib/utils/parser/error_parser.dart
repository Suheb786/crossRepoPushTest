import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:neo_bank/generated/l10n.dart';

class ErrorParser {
  ErrorParser._();

  static String getLocalisedStringError(
      {AppError? error, required S localisedHelper}) {
    switch (error?.type) {
      case ErrorType.IOEXCEPTION:
        return localisedHelper.genericError;
      case ErrorType.UI:
        return localisedHelper.genericError;
      case ErrorType.NETWORK:
        return localisedHelper.genericError;
      case ErrorType.NET_SERVER_MESSAGE:
        return localisedHelper.genericError;
      case ErrorType.NET_NO_INTERNET_CONNECTION:
        return localisedHelper.genericError;
      case ErrorType.DATABASE:
        return localisedHelper.genericError;
      case ErrorType.DATABASE_NOT_SUPPORTED:
        return localisedHelper.genericError;
      case ErrorType.DB_ERROR1:
        return localisedHelper.genericError;
      case ErrorType.DB_USER_NOT_FOUND:
        return localisedHelper.genericError;
      case ErrorType.INVALID_PIN:
        return localisedHelper.genericError;
      case ErrorType.NO_DOCUMENT_FOUND:
        return localisedHelper.genericError;
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
      case ErrorType.INVALID_EMPLOYEE_STATUS:
        return localisedHelper.enterValidEmployeeStatus;
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
      case ErrorType.EMPTY_MOTHER_NAME:
        return localisedHelper.emptyMotherName;
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
      case ErrorType.INVALID_DECLARATION_SELECTION:
        return localisedHelper.invalidDeclarationSelection;
      case ErrorType.INVALID_VERIFY_INFO_DECLARATION_SELECTION:
        return localisedHelper.invalidDeclarationSelection;
      case ErrorType.INVALID_NAME_AS_PER_TAX_RETURN:
        return localisedHelper.invalidNameAsPerTaxReturn;
      case ErrorType.INVALID_DOB:
        return localisedHelper.invalidDOB;
      case ErrorType.INVALID_CITIZENSHIP:
        return localisedHelper.invalidCitizenship;
      case ErrorType.INVALID_PERMANENT_ADDRESS_LINE:
        return localisedHelper.invalidPermanentAddress;
      case ErrorType.INVALID_COUNTRY:
        return localisedHelper.invalidCountry;
      case ErrorType.INVALID_STATE:
        return localisedHelper.invalidState;
      case ErrorType.INVALID_CITY:
        return localisedHelper.invalidCity;
      case ErrorType.INVALID_POSTCODE:
        return localisedHelper.invalidPostCode;
      case ErrorType.INVALID_ADDRESS:
        return localisedHelper.invalidAddress;
      case ErrorType.INVALID_REQUESTER_NAME:
        return localisedHelper.nameHint;
      case ErrorType.INVALID_REQUESTER_ADDRESS:
        return localisedHelper.invalidAddress;
      case ErrorType.INVALID_REQUESTER_STATE:
        return localisedHelper.invalidState;
      case ErrorType.INVALID_REQUESTER_CITY:
        return localisedHelper.invalidCity;
      case ErrorType.INVALID_REQUESTER_POSTCODE:
        return localisedHelper.invalidPostCode;
      case ErrorType.INVALID_TAX_PAYER:
        return localisedHelper.invalidTaxPayer;
      case ErrorType.INVALID_SECURITY_NUMBER:
        return localisedHelper.invalidSocialSecurityNumber;
      case ErrorType.INVALID_IDENTIFICATION_NUMBER:
        return localisedHelper.invalidIdentificationNumber;
      case ErrorType.INVALID_BENEFICIAL_ADDRESS:
        return localisedHelper.invalidCountry;
      case ErrorType.INVALID_BENEFICIAL_IDENTIFICATION_NUMBER:
        return localisedHelper.invalidIdentificationNumber;
      case ErrorType.INVALID_INCOME_TYPE:
        return localisedHelper.invalidIncomeType;
      case ErrorType.INVALID_EXPLANATION:
        return localisedHelper.invalidExplanation;
      case ErrorType.INVALID_REFERENCE_NO:
        return localisedHelper.invalidReferenceNumber;
      case ErrorType.INVALID_PREFERRED_DATE:
        return localisedHelper.invalidPreferredDate;
      case ErrorType.INVALID_PREFERRED_TIME:
        return localisedHelper.invalidPreferredTime;
      case ErrorType.INVALID_RELATIONSHIP:
        return localisedHelper.invalidRelationship;
      case ErrorType.INVALID_PERSON_NAME:
        return localisedHelper.invalidName;
      case ErrorType.INVALID_PERSON_ROLE:
        return localisedHelper.invalidRole;
      case ErrorType.EMPTY_INCOME_PROOF:
        return localisedHelper.invalidRole;
      case ErrorType.EMPTY_INCOME_DOCUMENT:
        return localisedHelper.emptyIncomeDocument;
      case ErrorType.EMPTY_ADDRESS_DOCUMENT:
        return localisedHelper.emptyAddressDocument;
      case ErrorType.EMPTY_PERMANENT_HOME_ADDRESS:
        return localisedHelper.emptyHomeAddress;
      case ErrorType.EMPTY_PERMANENT_STREET_ADDRESS:
        return localisedHelper.emptyStreetAddress;
      case ErrorType.EMPTY_PERMANENT_BUILDING_NAME_OR_NUMBER:
        return localisedHelper.emptyBuildingNameOrNo;
      case ErrorType.INVALID_JOB_NAME:
        return localisedHelper.invalidJobName;
      case ErrorType.EMPTY_DOCUMENT:
        return localisedHelper.emptyDocument;
      case ErrorType.EMPTY_PERMANENT_RESIDENT_COUNTRY:
        return localisedHelper.emptyResidentCountry;
      case ErrorType.EMPTY_CITY:
        return localisedHelper.emptyCity;
      case ErrorType.INVALID_BENEFICIAL_OWNER_ACCOUNT:
        return localisedHelper.invalidBeneficialOwnerAccount;
      case ErrorType.INVALID_BUSINESS_TYPE:
        return localisedHelper.invalidBusinessType;
      case ErrorType.EMPTY_BUSINESS:
        return localisedHelper.emptyBusiness;
      case ErrorType.INVALID_LEGAL_DOCUMENT:
        return localisedHelper.invalidDocumentNo;
      case ErrorType.INVALID_ISSUING_DATE:
        return localisedHelper.invalidIssuingDate;
      case ErrorType.INVALID_ISSUING_PLACE:
        return localisedHelper.invalidIssuingPlace;
      case ErrorType.EMPTY_DISTRICT:
        return localisedHelper.emptyDistrict;
      case ErrorType.PERMANENT_EMPTY_CITY:
        return localisedHelper.emptyCity;
      case ErrorType.DEVICE_NOT_FOUND:
        return localisedHelper.deviceNotFound;
      case ErrorType.ERROR_SAVING_ID_CARD:
        return localisedHelper.errorSavingIdCard;
      case ErrorType.ID_CARD_EXPIRED:
        return localisedHelper.idCardExpired;
      case ErrorType.INVALID_USERNAME_PASSWORD:
        return localisedHelper.invalidUserNamePassword;
      case ErrorType.ID_CARD_NOT_ALLOWED:
        return localisedHelper.idCardNotAllowed;
      case ErrorType.ERROR_SAVING_STATUS:
        return localisedHelper.errorSavingStatus;
      case ErrorType.EMPTY_NATIONALITY_DOCUMENT:
        return localisedHelper.emptyNationalityDocument;
      case ErrorType.ERROR_WHILE_UPLOADING_IMAGE:
        return localisedHelper.errorUploadImage;
      case ErrorType.INVALID_NETWORK_OTP:
        return localisedHelper.invalidOtp;
      case ErrorType.OTP_EXPIRED:
        return localisedHelper.otpExpired;
      case ErrorType.EMAIL_ALREADY_EXIST:
        return localisedHelper.emailAlreadyExist;
      case ErrorType.OTP_VERIFY_LIMIT_EXCEEDED:
        return localisedHelper.otpLimitExceed;
      case ErrorType.ERROR_CREATING_ACCOUNT:
        return localisedHelper.errorCreatingAccount;
      case ErrorType.UNABLE_TO_VERIFY_ID_CARD:
        return localisedHelper.unableToVerifyIDCard;
      case ErrorType.INVALID_USER:
        return localisedHelper.invalidUser;
      case ErrorType.ERROR_WHILE_LOGOUT:
        return localisedHelper.errorWhileLogout;
      case ErrorType.MOBILE_NUMBER_EXIST:
        return localisedHelper.mobileNoExist;
      case ErrorType.USER_NOT_REGISTER:
        return localisedHelper.userNotRegister;
      case ErrorType.ERROR_WHILE_REGISTRATION:
        return localisedHelper.errorWhileRegistration;
      case ErrorType.ERROR_GET_ADDITIONAL_DOCUMENTATION:
        return localisedHelper.errorWhileGetAdditionalDocument;
      case ErrorType.ACCOUNT_LOCKED:
        return localisedHelper.accountLocked;
      case ErrorType.IMAGE_UPLOAD_ERROR:
        return localisedHelper.pleaseProvideSelfie;
      case ErrorType.DIFFERENT_ADDRESS_LINE:
        return localisedHelper.enterMailingAddress;
      case ErrorType.DIFFERENT_COUNTRY:
        return localisedHelper.invalidCountry;
      case ErrorType.DIFFERENT_STATE:
        return localisedHelper.invalidState;
      case ErrorType.DIFFERENT_CITY:
        return localisedHelper.invalidCity;
      case ErrorType.DIFFERENT_POSTCODE:
        return localisedHelper.invalidPostCode;
      case ErrorType.INVALID_TREATY_CLAIM_RATE:
        return localisedHelper.invalidProvisionClaim;
      case ErrorType.INVALID_PROVISION_CLAIM:
        return localisedHelper.invalidTreatyClaimRate;
      case ErrorType.INVALID_SIGNATURE:
        return localisedHelper.emptySignature;
      case ErrorType.INVALID_USERNAME:
        return localisedHelper.invalidUserName;
      case ErrorType.ERROR_WHILE_GET_ACCOUNT:
        return localisedHelper.errorWhileGetAccount;
      case ErrorType.EMPTY_PIN:
        return localisedHelper.emptyPin;
      case ErrorType.INVALID_PIN_LENGTH:
        return localisedHelper.invalidPinLength;
      case ErrorType.PIN_NOT_MATCH:
        return localisedHelper.pinDoesNotMatch;
      case ErrorType.ACCOUNT_INQUIRY_WENT_WRONG:
        return localisedHelper.accountInquiryWentWrong;
      default:
        return "";
    }
  }
}

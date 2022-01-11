enum ErrorType {
  IOEXCEPTION,
  UI,

  //Network Error
  NETWORK,
  NET_SERVER_MESSAGE,
  NET_NO_INTERNET_CONNECTION,
  INVALID_BENEFICIARY,

  //DB ERROR
  DATABASE,
  DATABASE_NOT_SUPPORTED,
  DB_ERROR1,
  DB_USER_NOT_FOUND,

  //ui
  INVALID_PIN,
  INVALID_MOBILE,
  INVALID_OTP,
  INVALID_REQUESTED_AMOUNT,
  EMPTY_PASSWORD,
  EMPTY_CONFIRM_PASSWORD,
  PASSWORD_MISMATCH,
  INVALID_EMPLOYMENT_STATUS,
  INVALID_OCCUPATION,
  INVALID_BUSINESS_TYPE,
  EMPTY_BUSINESS,
  INVALID_SOURCE_INCOME,
  INVALID_MONTHLY_INCOME,
  INVALID_ANNUAL_INCOME,
  INVALID_EMPLOYER_NAME,
  INVALID_EMPLOYER_COUNTRY,
  INVALID_EMPLOYER_CITY,
  INVALID_EMPLOYER_CONTACT,
  INVALID_ADDITIONAL_SOURCE_INCOME,
  INVALID_TOTAL_ADDITIONAL_INCOME,
  EMPTY_EMAIL,
  INVALID_EMAIL,
  CONDITION_NOT_CHECKED,
  EMPTY_NAME,
  EMPTY_ID_NUMBER,
  EMPTY_DATE_OF_BIRTH,
  EMPTY_NATIONALITY,
  EMPTY_EXPIRY_DATE,
  EMPTY_GENDER,
  EMPTY_MOTHER_NAME,
  INVALID_LEGAL_DOCUMENT,
  INVALID_ISSUING_DATE,
  INVALID_ISSUING_PLACE,
  NOT_ALLOWED_COUNTRY,
  EMPTY_RESIDENT_COUNTRY,
  EMPTY_PERMANENT_RESIDENT_COUNTRY,
  EMPTY_CITY,
  PERMANENT_EMPTY_CITY,
  EMPTY_DISTRICT,
  EMPTY_HOME_ADDRESS,
  EMPTY_STREET_ADDRESS,
  EMPTY_BUILDING_NAME_OR_NUMBER,
  EMPTY_PERMANENT_HOME_ADDRESS,
  EMPTY_PERMANENT_STREET_ADDRESS,
  EMPTY_PERMANENT_BUILDING_NAME_OR_NUMBER,
  INVALID_TAX_COUNTRY,
  INVALID_TIN_NUMBER,
  INVALID_REASON_OF_UNAVAILABILITY,
  INVALID_EXPLANATION_FOR_UNAVAILABILITY,
  EMPTY_NEW_PASSWORD,
  PASSWORD_NOT_MEET_CRITERIA,
  CURRENT_PASSWORD_INVALID,
  ERROR_WHILE_GET_COMBO_VALUES,
  USER_ALREADY_EXISTS,
  PLEASE_TRY_AGAIN,
  INVALID_EMPLOYER_ID,
  ERROR_ACCESSING_ID,
  ERROR_WHILE_GETTING_DASHBOARD,

  //purpose of account opening error
  INVALID_PURPOSE_OF_ACCOUNT_OPENING,
  INVALID_TYPES_OF_TRANSACTION,
  INVALID_EXPECTED_MONTHLY_TRANSACTION,
  INVALID_EXPECTED_ANNUAL_TRANSACTION,
  EMPTY_INCOME,
  SELECT_EXPECTED_TRANSACTION,

  // Scanner Error
  NO_DOCUMENT_FOUND,

  //profile
  INVALID_NAME,
  INVALID_NATURE,
  INVALID_RELATIONSHIP,
  INVALID_PERSON_ROLE,
  INVALID_PERSON_NAME,
  INVALID_EMPLOYEE_STATUS,
  INVALID_DECLARATION_SELECTION,
  INVALID_VERIFY_INFO_DECLARATION_SELECTION,
  INVALID_JOB_NAME,
  INVALID_BENEFICIAL_OWNER_ACCOUNT,
  INVALID_SIGNATURE,

  //us resident
  INVALID_NAME_AS_PER_TAX_RETURN,
  INVALID_DOB,
  INVALID_CITIZENSHIP,

  //us resident address details
  INVALID_PERMANENT_ADDRESS_LINE,
  INVALID_COUNTRY,
  INVALID_STATE,
  INVALID_CITY,
  INVALID_POSTCODE,
  INVALID_ADDRESS,
  DIFFERENT_ADDRESS_LINE,
  DIFFERENT_COUNTRY,
  DIFFERENT_STATE,
  DIFFERENT_CITY,
  DIFFERENT_POSTCODE,
  INVALID_EXEMPTION_FATCA_CODE,

  //additional requester details
  INVALID_REQUESTER_NAME,
  INVALID_REQUESTER_ADDRESS,
  INVALID_REQUESTER_STATE,
  INVALID_REQUESTER_CITY,
  INVALID_REQUESTER_POSTCODE,

  //us w9 tax payer
  INVALID_TAX_PAYER,
  INVALID_SECURITY_NUMBER,

  //us w8 tax payer
  INVALID_IDENTIFICATION_NUMBER,
  INVALID_BENEFICIAL_ADDRESS,
  INVALID_BENEFICIAL_IDENTIFICATION_NUMBER,
  INVALID_INCOME_TYPE,
  INVALID_EXPLANATION,
  INVALID_REFERENCE_NO,
  INVALID_PROVISION_CLAIM,
  INVALID_TREATY_CLAIM_RATE,
  INVALID_FOREIGN_IDENTIFICATION_NUMBER,

  //upload
  EMPTY_INCOME_PROOF,
  EMPTY_ADDRESS_PROOF,
  EMPTY_INCOME_DOCUMENT,
  EMPTY_ADDRESS_DOCUMENT,
  EMPTY_NATIONALITY_DOCUMENT,
  EMPTY_DOCUMENT,

  //schedule video call
  INVALID_PREFERRED_DATE,
  INVALID_PREFERRED_TIME,

  //Api error codes
  DEVICE_NOT_FOUND,
  INVALID_USERNAME_PASSWORD,
  INVALID_NETWORK_OTP,
  OTP_EXPIRED,
  EMAIL_ALREADY_EXIST,
  ERROR_SAVING_ID_CARD,
  ID_CARD_EXPIRED,
  ID_CARD_NOT_ALLOWED,
  ERROR_SAVING_STATUS,
  ERROR_WHILE_UPLOADING_IMAGE,
  OTP_VERIFY_LIMIT_EXCEEDED,
  ERROR_CREATING_ACCOUNT,
  UNABLE_TO_VERIFY_ID_CARD,
  INVALID_USER,
  ERROR_WHILE_LOGOUT,
  MOBILE_NUMBER_EXIST,
  USER_NOT_REGISTER,
  ERROR_WHILE_REGISTRATION,
  ERROR_GET_ADDITIONAL_DOCUMENTATION,
  ACCOUNT_LOCKED,
  IMAGE_UPLOAD_ERROR,
  INVALID_USERNAME,
  ERROR_WHILE_GET_ACCOUNT,
  ACCOUNT_INQUIRY_WENT_WRONG,
  WENT_WRONG_WHILE_LOGIN,
  ERROR_GET_ACCOUNT_DETAILS,
  ACCOUNT_NOT_FOUND,
  INVALID_OTP_ENTERED,
  BENEFICIARY_NOT_FOUND,
  ERROR_WHILE_BALANCE_INQUIRY,
  INSUFFICIENT_BALANCE,
  REQUEST_NOT_COMPLETED,
  MOBILE_ALREADY_EXIST,
  DO_NOT_RECOMMEND_TO_USE_PREVIOUS_TENPASS,
  CURRENT_PASSWORD_INCORRECT,
  ERROR_GETTING_FATCA_CRS,

  //card delivery
  EMPTY_PIN,
  INVALID_PIN_LENGTH,
  PIN_NOT_MATCH,
  INVALID_ID_CARD,

  //payment
  EMPTY_IBAN_MOBILE,
  EMPTY_PURPOSE,
  EMPTY_PURPOSE_DETAIL,
  LOCATION_SERVICE_NOT_ENABLED,
  INSUFFICIENT_BALANCE_TRANSFER,
  LIMIT_EXCEEDED,
  EMPTY_NICKNAME_VALUE,

//card settings
  SELECT_CANCELATION_REASON,
  AGREE_TO_THE_TERM_AND_CONDITION,
  INVALID_LIMIT_VALUE,
  EMPTY_CONFIRM_PIN,
  SELECT_CREDIT_LIMIT_SETTINGS,
  SELECT_MINIMUM_SETTLEMENT,
  EMPTY_NICKNAME,
  ERROR_DECRYPT_CARD,
  ERROR_GENERATE_BLOCK_PIN,

  // blink credit card
  INVALID_CHECKED_VALUE,

  // set credit limit
  EMPTY_MINIMUM_SETTLEMENT_VALUE,

  //infobip
  CALL_HANGUP_ERROR,
  INIT_INFOBIP_PLUGIN_ERROR,
  GET_CALL_TOKEN_ERROR,
  GET_CALL_DURATION_ERROR,
  ESTABLISH_CALL_ERROR
}

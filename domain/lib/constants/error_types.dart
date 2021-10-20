enum ErrorType {
  IOEXCEPTION,
  UI,

  //Network Error
  NETWORK,
  NET_SERVER_MESSAGE,
  NET_NO_INTERNET_CONNECTION,

  //DB ERROR
  DATABASE,
  DATABASE_NOT_SUPPORTED,
  DB_ERROR1,
  DB_USER_NOT_FOUND,

  //ui
  INVALID_PIN,
  INVALID_MOBILE,
  INVALID_OTP,
  EMPTY_PASSWORD,
  EMPTY_CONFIRM_PASSWORD,
  PASSWORD_MISMATCH,
  INVALID_EMPLOYMENT_STATUS,
  INVALID_OCCUPATION,
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
  EMPTY_RESIDENT_COUNTRY,
  EMPTY_HOME_ADDRESS,
  EMPTY_STREET_ADDRESS,
  EMPTY_BUILDING_NAME_OR_NUMBER,

  INVALID_TAX_COUNTRY,
  INVALID_TIN_NUMBER,
  INVALID_REASON_OF_UNAVAILABILITY,
  INVALID_EXPLANATION_FOR_UNAVAILABILITY,

  //purpose of account opening error
  INVALID_PURPOSE_OF_ACCOUNT_OPENING,
  INVALID_TYPES_OF_TRANSACTION,
  INVALID_EXPECTED_MONTHLY_TRANSACTION,
  INVALID_EXPECTED_ANNUAL_TRANSACTION,

  // Scanner Error
  NO_DOCUMENT_FOUND,

  //profile
  INVALID_NAME,
  INVALID_NATURE,
  INVALID_RELATIONSHIP,
  INVALID_PERSON_ROLE,
  INVALID_PERSON_NAME,
  INVALID_DECLARATION_SELECTION,

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

  //additional requester details
  INVALID_REQUESTER_NAME,
  INVALID_REQUESTER_ADDRESS,
  INVALID_REQUESTER_STATE,
  INVALID_REQUESTER_CITY,
  INVALID_REQUESTER_POSTCODE,

  //upload
  EMPTY_INCOME_PROOF,
  EMPTY_ADDRESS_PROOF,
}

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
  INVALID_EMPLOYMENT_STATUS,
  INVALID_OCCUPATION,
  INVALID_SOURCE_INCOME,
  INVALID_MONTHLY_INCOME,
  INVALID_ANNUAL_INCOME,
  INVALID_PURPOSE_OF_ACCOUNT_OPENING,
  INVALID_EMPLOYER_NAME,
  INVALID_EMPLOYER_COUNTRY,
  INVALID_EMPLOYER_CITY,
  INVALID_EMPLOYER_CONTACT,
  INVALID_ADDITIONAL_SOURCE_INCOME,
  INVALID_TOTAL_ADDITIONAL_INCOME,

  // Scanner Error
  NO_DOCUMENT_FOUND,
}

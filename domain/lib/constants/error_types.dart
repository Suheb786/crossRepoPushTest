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

  // Scanner Error
  NO_DOCUMENT_FOUND,

  //profile
  INVALID_NAME,
  INVALID_NATURE,
  INVALID_RELATIONSHIP,
  INVALID_PERSON_ROLE,
  INVALID_PERSON_NAME,

}

enum ErrorType {
  IOEXCEPTION,
  UI,

  //Network Error
  NETWORK,
  NET_SERVER_MESSAGE,
  UNAUTHORIZED_USER,
  NET_NO_INTERNET_CONNECTION,
  CONNECTION_FAILED,
  INVALID_BENEFICIARY,
  REQUEST_TIMEOUT,

  //DB ERROR
  DATABASE,
  DATABASE_NOT_SUPPORTED,
  DB_ERROR1,
  DB_USER_NOT_FOUND,
  FAILED_TO_INIT_SDK,
  FAILED_TO_LOG_EVENT,

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
  INVALID_ANNUAL_INCOME_VALUE,
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
  INVALID_ADDITIONAL_SOURCE_INCOME_VALUE,
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
  CONFIRM_PASSWORD_NOT_MATCH_WITH_NEW_PASSWORD,
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
  INVALID_EXPECTED_MONTHLY_TRANSACTION_VALUE,
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
  INVALID_REQUESTER_COUNTRY,
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
  CHECK_PASSWORD_CRED_ERROR,
  ID_CARD_EXPIRED,
  DEVICE_NOT_COMPATIBLE,
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
  ACCOUNT_INQUIRY_WENT_WRONG_61,
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
  ATM_WITHDRAWAL_VALUE_EXCEEDED,
  MERCHANT_PAYMENT_EXCEEDED,
  ONLINE_PURCHASE_VALUE_EXCEEDED,
  EMPTY_NICKNAME_VALUE,
  ZERO_AMOUNT,
  AMOUNT_GREATER_THAN_ZERO,

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
  ESTABLISH_CALL_ERROR,

//forget password
  EMPTY_VERIFY_EMAIL,
  EMPTY_VERIFY_EXPIRY_DATE,
  EMPTY_VERIFY_NATIONAL_ID,

//credit card issuance
  ERROR_PROCESS_WHILE_LOAN_REQUEST,
  ERROR_WHILE_GETTING_ACCOUNT_CLOSE_OTP,
  INVALID_DOCUMENT,
  ID_CARD_NOT_FOUND,
  CHANGE_CARD_PIN_ERROR,
  ERROR_WHILE_LINKING_DEBIT_CARD,
  SELECT_ADDITIONAL_INCOME,
  ERROR_WHILE_GET_STATUS,
  USER_NOT_ELIGIBLE,
  NO_DUE_AMOUNT,
  INVALID_ACCOUNT_BALANCE,

  ///error codes
  MODEL_NOT_CORRECT,
  UNAUTHORIZE,
  YOU_LOCKED,
  ENTER_VALID_USERNAME,
  INVALID_ACCOUNT_ID,
  ERROR_GETTING_RETAIL_CIF,
  INVALID_PRODUCT_ID,
  RESIDENT_INFO_NOT_FOUND,
  INVALID_PRODUCT_SHORT_CODE,
  MAXIMUM_ACCOUNT_OPENING_EXCEED,
  MAXIMUM_AGE_OF_USER,
  CANNOT_PROCEED_FOR_PRODUCT,
  RESIDENT_COUNTRY_RESTRICTED,
  NATIONALITY_RESTRICTED,
  ID_NO_BLACKLISTED,
  ERROR_WHILE_CHECKING_ID_NO_BLACKLISTED,
  NOT_ALLOWED_TO_OPEN_ACCOUNT,
  ID_CARD_SCANNING_ERROR,
  INVALID_ISSUER_COUNTRY,
  INVALID_ID_CARD_CANNOT_PROCEED,
  BUSINESS_RULES_NOT_IMPLEMENTED_AGAINST_COMPANY_ID,
  USE_VALID_ID,
  GUARDIAN_AGE_VALIDATION,
  PROFILE_STATUS_NOT_FOUND,
  RESPONSE_1_REQUIRED,
  RESPONSE_2_REQUIRED,
  RESPONSE_3_REQUIRED,
  RESPONSE_4_REQUIRED,
  RESPONSE_5_REQUIRED,
  RESIDENCE_COUNTRY_NOT_FOUND,
  NO_SIGNATURE_FOUND,
  FATCA_DETAILS_NOT_FOUND,
  INVALID_MOBILE_CODE,
  INVALID_LIVELINESS_SCORE,
  INVALID_FACE_MATCH_SCORE,
  FINGERPRINT_ALREADY_EXIST_FOR_DEVICE,
  FINGERPRINT_NOT_FOUND,
  JOB_DETAILS_NOT_FOUND,
  ACCOUNT_PURPOSE_NOT_FOUND,
  ID_CARD_DATA_NOT_FOUND,
  CUSTOMER_PREFERENCE_NOT_FOUND,
  INVALID_MINIMUM_AGE,
  INVALID_MAXIMUM_AGE,
  INVALID_ACCOUNT_LIMIT,
  APPLICATION_UNDER_REVIEW,
  RIMNO_TAKEN_BY_OTHER_USER,
  ERROR_CREATING_WORKSPACE,
  ERROR_CREATING_DOCUMENTS,
  ERROR_UPDATING_CATEGORY_CIF,
  ERROR_UPDATING_CATEGORY,
  NOT_REGISTERED_BANK,
  PROVIDED_COUNTRY_NOT_ALLOWED,
  INVALID_OTP_NETWORK,
  INVALID_OTP_CODE_NETWORK,
  OTP_REQUESTED_MANY_TIME,
  NOT_ALLOWED_TO_LOGIN,
  OTP_EXPIRED_NETWORK,
  IP_ADDRESS_CALL_INTERNAL_SERVER_ERROR,
  APPLICATION_IN_PROCESS,
  NO_ACCOUNT_FOUND,
  ERROR_UPDATING_ACCOUNT,
  INVALID_SIGNATURE_NETWORK,
  NO_ATM_DATA,
  NOT_VERIFIED,
  OTP_LIMIT_EXCEED,
  INVALID_OTP_REQ,
  IMAGE_NOT_FOUND,
  DOCUMENTS_NOT_FOUND,
  INVALID_EMAIL_NETWORK,
  INVALID_MOBILE_NO,
  INVALID_CURRENT_PASS,
  NO_REQUEST_FOUND_RTP,
  ISO_NATIONALITY_NOT_FOUND,
  ERROR_WHILE_ISSUE_CARD,
  ERROR_WHILE_GETTING_XCS_CUSTOMER_DETAILS,
  NO_DEBIT_CARD_RECORD_FOUND,
  ERROR_EURONET_CUSTOMER_CARD_DETAILS,
  ERROR_SETTING_PIN_EURONET,
  INVALID_CARD_ID,
  INVALID_FOUR_DIGIT,
  CONTACTLESS_ERROR,
  CARD_INFO_ERROR,
  ERROR_GETTING_CARD_INFO,
  LOAN_ACCOUNT_LIST_NOT_FOUND,
  PRIMARY_LOAN_ACC_LIST_NOT_FOUND,
  PRIMARY_CARD_NOT_ACTIVE,
  RELATIVE_ID_ERROR,
  INVALID_NATIONAL_ID_CARD,
  ID_CARD_IS_EXPIRED,
  LESS_THAN_PRIMARY,
  INVALID_NATIONALITY,
  WS_CHILD_ERROR,
  CREATE_CARD_ERROR,
  PRIMARY_NOT_COMPLETE,
  INVALID_SUPPLEMENTARY_CARD_ID,
  SET_CONTACTLESS_ZERO_ERROR,
  ERROR_CREATE_CREDIT_CARD,
  SETTING_CONTACTLESS_ERROR,
  CONTACTLESS_ALREADY_DONE,
  STEP_2_NOT_DONE_CREDIT_CARD,
  ERROR_GETTING_CARD_INFO_NET,
  PROCESS_LOAN_STEP_NOT_DONE,
  CREATING_SHIPMENT_ERROR,
  PLATFORM_NOT_FOUND,
  TRANSACTION_NOT_ALLOWED,
  UNABLE_TO_PROCEED_TRANSACTION,
  UNABLE_TO_COMPLETE_TRANSACTION,
  GET_LOAN_PAYMENT_ERROR,
  PROCESS_LOAN_ERROR,
  CUSTOMER_NOT_ELIGIBLE,
  LOAN_NOT_ACTIVE,
  RETRIEVE_INSTRUCTION_DETAILS,
  EDRAW_API_GOT_WRONG,
  ESETTLEMENT_WENT_WRONG,
  AMOUNT_LIMIT_ERROR,
  AMOUNT_GREATER_THAN_OUTSTANDING,
  ERROR_UPDATING_LIMITS,
  ERROR_UPDATING_CARD_STATUS_RULEENGINE,
  NO_DEBIT_CARD_FOUND,
  ERROR_WHILE_UPDATING_PIN_STATUS_RE,
  ERROR_WHILE_UPDATING_CARD_STATUS_NI,
  ERROR_WHILE_UNBLOCK_PIN_NI,
  ERROR_WHILE_GETTING_ACCOUNT_DETAILS_A2A,
  PURPOSE_DETAILS_NOT_FOUND,
  ERROR_CUSTOMER_BY_ACCOUNT_A2A,
  ERROR_WHILE_RTP_A2A,
  INVALID_ACCOUNT,
  ERROR_WHILE_GETTING_ACCOUNT_BS,
  INVALID_AMOUNT,
  ERROR_MULTIBRANCH_API_BS,
  TRANSFER_TYPE_NF,
  TRANSFER_TYPE_NF_RTP,
  INVALID_ID_NO,
  INVALID_EXPIRY_DATE,
  ERROR_ADDING_USERNAME,
  REGISTRATION_PROCESS_ERROR,
  AHWAL_ERROR,
  KYC_STATUS_ERROR,
  SAVING_ID_CARD_ERROR,
  SAVING_COUNTRY_RESIDENCE_ERROR,
  SAVING_PROFILE_STATUS_ERROR,
  SAVING_JOB_DETAILS_ERROR,
  ADD_ACCOUNT_PURPOSE_ERROR,
  FATCA_CRS_ERROR,
  UPLOAD_FATCA_SIGNATURE_ERROR,
  SAVING_FATCA_DETAILS_ERROR,
  SAVING_W8_FORM_ERROR,
  SAVING_W9_FORM_ERROR,
  SELFIE_CHECK_ERROR,
  ENABLE_FINGERPRINT_ERROR,
  DISABLE_FINGERPRINT_ERROR,
  GET_COMBO_VALUES_ERROR,
  GET_ADDITIONAL_DOCUMENTATION_ERROR,
  SAVE_ADDITIONAL_DOCUMENTATION_ERROR,
  GET_ACCOUNT_DETAILS_ERROR,
  CREATING_ACCOUNT_ERROR,
  CHECK_VIDEO_CALL_STATUS_ERROR,
  CHECK_OTHER_NATIONALITY_STATUS_ERROR,
  UPLOAD_DOCUMENTS_ERROR,
  LOGOUT_ERROR,
  REGISTER_INTEREST_ERROR,
  VERIFY_OTP_ERROR,
  IPHONE_LOGIN_ERROR,
  CHECK_DOCUMENT_STATUS_ERROR,
  CHECK_AGENT_STATUS,
  CHANGE_CALL_STATUS_ERROR,
  SAVE_CUSTOMER_TIME_STATUS_ERROR,
  GET_ALLOWED_COUNTRIES_ERROR,
  GET_COUNTRIES_ERROR,
  REMOVE_DEBIT_LOCK_ERROR,
  ENABLE_BIOMETRIC_ERROR,
  GET_CIPHER_ERROR,
  GENERATE_KEY_PAIR_ERROR,
  ANDROID_LOGIN_ERROR,
  CHECK_CUSTOMER_STATUS_ERROR,
  GET_BENEFICIARIES_ERROR,
  GET_ATM_ERROR,
  CHECK_ISSUER,
  GET_STATES_ERROR,
  GET_CITIES_ERROR,
  GET_CITIES_BY_COUNTRY_ERROR,
  GET_CONTACTS_ERROR,
  ADD_BENEFICIARY_ERROR,
  UPDATE_BENEFICIARY_ERROR,
  DELETE_BENEFICIARY_ERROR,
  VERIFY_BENEFICIARY_OTP_ERROR,
  UPLOAD_BENEFICIARY_ERROR,
  GET_PROFILE_INFO_ERROR,
  DELETE_PROFILE_IMAGE_ERROR,
  Get_CUSTOMER_DOCUMENT_ERROR,
  Get_CUSTOMER_DOCUMENT_ID_ERROR,
  CHANGE_PROFILE_IMAGE_ERROR,
  CHANGE_EMAIL_ERROR,
  VERIFY_CHANGE_EMAIL_ERROR,
  CHANGE_MOBILE_NO_ERROR,
  VERIFY_CHANGE_MOBILE_NO_ERROR,
  CHANGE_PASSWORD_ERROR,
  VERIFY_OTP_PASSWORD_ERROR,
  REQUEST_TO_PAY_STATUS_ERROR,
  CARD_ISSUANCE_ERROR,
  SET_CARD_PIN_ERROR,
  CONFIRM_DELIVERY_ERROR,
  GET_DASHBOARD_DATA_ERROR,
  MONEY_THOR_ERROR,
  DEBIT_CARD_TRANSACTION_LIST_ERROR,
  ACCOUNT_ACTIVITY_ERROR,
  CONFIRM_CREDIT_CARD_DELIVERY_ERROR,
  CREDIT_DASHBOARD_DATA_ERROR,
  CREDIT_CARD_REQ_ERROR,
  CREDIT_CARD_TRANSACTION_LIST_ERROR,
  GET_CREDIT_YEARS_ERROR,
  CREDIT_CARD_STATEMENT_ERROR,
  GET_DEBIT_YEARS_ERROR,
  DEBIT_CARD_STATEMENT_ERROR,
  UPDATE_LIMIT_ERROR,
  FREEZE_DEBIT_CARD_ERROR,
  UNFREEZE_DEBIT_CARD_ERROR,
  CANCEL_DEBIT_CARD_ERROR,
  VERIFY_CHANGE_PIN_ERROR,
  CHANGE_PIN_ERROR,
  UNBLOCK_DEBIT_CARD_PIN_ERROR,
  GET_DEBIT_CARD_LIMIT_ERROR,
  REQUEST_SUPPLEMENTARY_DEBIT_CARD_ERROR,
  FREEZE_CREDIT_CARD_ERROR,
  UNFREEZE_CREDIT_CARD_ERROR,
  UNBLOCK_CREDIT_CARD_PIN_ERROR,
  GET_ACCOUNT_BY_ALIAS_ERROR,
  REQUEST_TO_PAY_ERROR,
  CHECK_SEND_MONEY_ERROR,
  VERIFY_TRANSFER_API_ERROR,
  VERIFY_TRANSFER_API_V2_ERROR,
  GET_TRANSFER_PURPOSE_ERROR,
  PAYMENT_ACTIVITY_API_ERROR,
  CHECK_CREDENTIALS_FOR_FORGET_PASSWORD_ERROR,
  FORGET_PASSWORD_ERROR,
  VERIFY_FORGET_PASSWORD_ERROR,
  SEND_OTP_TOKEN_ERROR,
  VERIFY_DEIVICE_CHANGE_OTP_ERROR,
  RESEND_OTP_ERROR,
  CHECK_EXISTING_CALL_ERROR,
  REQUEST_CALL_ERROR,
  GET_GENDER_STATUS_ERROR,
  GET_TIME_SLOTS_ERROR,
  ADD_CALL_ERROR,
  CHECK_CALL_STATUS,
  GET_CARD_APPLICATION_ERROR,
  GET_LOAN_VALUES_ERROR,
  PROCESS_LOAN_VALUES_ERROR,
  PAYBACK_CREDIT_CARD_ERROR,
  SUPPLEMENTARY_CARD_APPLICATION_ERROR,
  REQUEST_SUPPLEMENTARY_CARD_ERROR,
  SUPPLEMENTARY_CARD_STEP_2_ERROR,
  SUPPLEMENTARY_CARD_STEP_3_ERROR,
  RELATIONSHIP_LIST_ERROR,
  GET_CURRENT_VALUES_ERROR,
  EXPIRY_DATE_ERROR,
  PASSWORD_MISMATCH_ERROR,
  SENDING_DEVICE_OTP_ERROR,
  SELECT_FUTURE_DATE,
  INVALID_GENDER_VALUE,
  INVALID_SCHEDULE_TIME,
  FIREBASE_CONNECTION_ISSUE,
  CALL_RECORD_NOT_FOUND,
  INVALID_PRIMARY_ID,
  NI_HANDLER_ERROR,
  LOAN_VALUES_ERROR,
  INVALID_LOAN_VALUE_ID,
  INVALID_CREDIT_LIMIT,
  LOAN_VALUE_PROCESS_ERROR,
  LOAN_VALUE_REQUEST_PROCESSING_ERROR,
  INVALID_CUSTOMER_ID,
  INVALID_CREDIT_CARD_ID,
  STEP_2_INCOMPLETE,
  LOAN_STEP_NOT_DONE,
  LOAN_VALUES_NOT_FOUND,
  ERROR_IN_MESSAGE,
  CRIF_UPDATE_ERROR,
  ARMEX_API_ERROR,
  INVALID_PAYBACK_AMOUNT,
  CREDIT_CARD_DATA_NOT_FOUND,
  ACCOUNT_CLAIM_NOT_FOUND,
  CARD_LOAN_ACC_NOT_FOUND,
  PAYMENT_CASHBACK_ERROR,
  REGISTERING_USER_TO_VKEY_ERROR,
  NULL_ID,
  ASSIGN_TOKEN_ERROR,
  TOKEN_SERIAL_APN_EMPTY,
  PIN_REQUIRED,
  INVALID_MESSAGE_ID,
  VKEY_TRANSACTION_FAILED,
  VKEY_MESSAGE_ID_REQUIRED,
  LOGIN_NOT_ALLOWED,
  ENTER_DETAILS,
  IMAGE_NULL,
  PROOF_REQUIRED,
  OTP_NULL,
  DEVICE_IS_REQUIRED,
  EMPTY_CARD_NO,
  FORCE_UPDATE,
  MINOR_NOT_ALLOWED,
  INVALID_ID_VERIFICATION_177,
  INVALID_ID_VERIFICATION_178,
  AGENT_NOT_AVAILABLE,
  NO_PLACEHOLDER_FOUND,
  PLACEHOLDER_ID_NULL,
  RELATION_NULL,
  AHWAL_FAILED,
  INVALID_RELATION,
  PRIMARY_ID_NOT_MATCH_GROOM,
  SEC_ID_NOT_MATCH_FATHER_MOTHER,
  PRIMARY_DEBIT_CARD_NOT_MATCH_WITH_FATHER_MOTHER,
  RELATIONSHIP_NULL,
  INVALID_RELATIONSHIP_API,
  PRIM_CREDIT_CARD_ID_NOT_MATCH_GROOM,
  SUPP_CREDIT_HOLDER_ID_NOT_MATCH_FATHER_MOTHER,
  PRIM_DEBIT_CREDIT_CARD_ID_NOT_MATCH_MOTHER_FATHER,
  NO_DATA_FOUND_IN_FINANCIAL_INSTITUTION,
  NO_SUPP_USER_DETAILS_FOUND,
  CANNOT_APPLY_CC_INSUFFICIENT_FUNDS,
  CANNOT_PROCEED_NO_AHWAL_DATA_FOUND,
  ID_ALREADY_EXISTS,
  AHWAL_SERVICE_NOT_AVAILABLE,
  LOCATION_RESTRICTED,
  ERROR_PHYSICAL_DC_XCS,
  ERROR_FOR_PIN_TRANSLATION_XCS,
  ERROR_FOR_PIN_CHANGE_NI,
  ERROR_CC_UNBLOCK_NI,
  LOGIN_REGISTER_DISABLED,
  ID_VERIFICATION_FAILED,
  QR_EXPIRED,
  QR_INVALID,
  PAYMENT_NOT_DONE,
  NO_TICKETS_FOUND,
  DATE_COMPARISON,

  ///manage cliq
  EMPTY_CLIQ_ID_TYPE,
  EMPTY_ALIAS,

  ///EVouchers
  SELECT_REGION,
  SELECT_AMOUNT,
  SELECT_ACCOUNT
}

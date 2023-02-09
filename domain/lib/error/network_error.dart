import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';

class NetworkError extends BaseError {
  NetworkError(
      {required int httpError,
      String errorCode: "",
      String message: "",
      required Exception cause,
      String description: ""})
      : super(error: ErrorInfo(code: httpError, message: errorCode, description: description), cause: cause);

  @override
  String getFriendlyMessage() {
    return "${this.error.message}";
  }

  @override
  AppError transform() {
    switch (error.code) {
      case 101:
        return AppError(error: error, cause: cause, type: ErrorType.CONNECTION_FAILED);

      case 503:
        return AppError(error: error, cause: cause, type: ErrorType.NET_NO_INTERNET_CONNECTION);

      case 504:
        return AppError(cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      case 502:
        return AppError(cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      case 404:
        return AppError(cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      case 401:
        return AppError(cause: cause, error: error, type: ErrorType.UNAUTHORIZED_USER);

      case 408:
        return AppError(cause: cause, error: error, type: ErrorType.REQUEST_TIMEOUT);

      case 1500:
        return AppError(cause: cause, error: error, type: ErrorType.CALL_HANGUP_ERROR);

      case 1501:
        return AppError(cause: cause, error: error, type: ErrorType.INIT_INFOBIP_PLUGIN_ERROR);

      case 1502:
        return AppError(cause: cause, error: error, type: ErrorType.GET_CALL_TOKEN_ERROR);

      case 1503:
        return AppError(cause: cause, error: error, type: ErrorType.ESTABLISH_CALL_ERROR);
      case 1504:
        return AppError(cause: cause, error: error, type: ErrorType.GET_CALL_DURATION_ERROR);

      default:
        print("I AM EXECUTED with error code ${error.message}");
        switch (error.message) {
          case "Err-SN1":
            return AppError(cause: cause, error: error, type: ErrorType.MOBILE_ALREADY_EXIST);

          case "err-329":
            return AppError(cause: cause, error: error, type: ErrorType.USER_NOT_ELIGIBLE);

          case "err-Model":
            return AppError(cause: cause, error: error, type: ErrorType.MODEL_NOT_CORRECT);

          case "err-U":
            return AppError(cause: cause, error: error, type: ErrorType.UNAUTHORIZE);

          case "err-001":
            return AppError(cause: cause, error: error, type: ErrorType.EMAIL_ALREADY_EXIST);

          case "err-002":
            return AppError(cause: cause, error: error, type: ErrorType.MOBILE_ALREADY_EXIST);

          case "err-003":
            return AppError(cause: cause, error: error, type: ErrorType.USER_NOT_REGISTER);

          case "err-004":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_USERNAME_PASSWORD);

          case "err-005":
            return AppError(cause: cause, error: error, type: ErrorType.YOU_LOCKED);

          case "err-006":
            return AppError(cause: cause, error: error, type: ErrorType.ACCOUNT_LOCKED);

          case "err-007":
            return AppError(cause: cause, error: error, type: ErrorType.ENTER_VALID_USERNAME);

          case "err-008":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ACCOUNT_ID);

          case "err-009":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_GETTING_RETAIL_CIF);

          case "err-010":
            return AppError(cause: cause, error: error, type: ErrorType.ACCOUNT_INQUIRY_WENT_WRONG);

          case "err-011":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_PRODUCT_ID);

          case "err-012":
            return AppError(cause: cause, error: error, type: ErrorType.RESIDENT_INFO_NOT_FOUND);

          case "err-013":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_USER);

          case "err-014":
            return AppError(cause: cause, error: error, type: ErrorType.WENT_WRONG_WHILE_LOGIN);

          case "err-015":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_PRODUCT_SHORT_CODE);

          case "err-016":
            return AppError(cause: cause, error: error, type: ErrorType.MAXIMUM_ACCOUNT_OPENING_EXCEED);

          case "err-017":
            return AppError(cause: cause, error: error, type: ErrorType.MAXIMUM_ACCOUNT_OPENING_EXCEED);

          case "err-017.1":
            return AppError(cause: cause, error: error, type: ErrorType.MAXIMUM_AGE_OF_USER);

          case "err-017.2":
            return AppError(cause: cause, error: error, type: ErrorType.CANNOT_PROCEED_FOR_PRODUCT);

          case "err-018":
            return AppError(cause: cause, error: error, type: ErrorType.RESIDENT_COUNTRY_RESTRICTED);

          case "err-019":
            return AppError(cause: cause, error: error, type: ErrorType.NATIONALITY_RESTRICTED);

          case "err-020":
            return AppError(cause: cause, error: error, type: ErrorType.ID_NO_BLACKLISTED);

          case "err-021":
            return AppError(
                cause: cause, error: error, type: ErrorType.ERROR_WHILE_CHECKING_ID_NO_BLACKLISTED);

          case "err-022":
            return AppError(cause: cause, error: error, type: ErrorType.NOT_ALLOWED_TO_OPEN_ACCOUNT);

          case "err-023":
            return AppError(cause: cause, error: error, type: ErrorType.ID_CARD_SCANNING_ERROR);

          case "err-024":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ISSUER_COUNTRY);

          case "err-025":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_DOCUMENT);

          case "err-026":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ID_CARD_CANNOT_PROCEED);

          case "err-027":
            return AppError(cause: cause, error: error, type: ErrorType.ID_CARD_EXPIRED);

          case "err-028":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.BUSINESS_RULES_NOT_IMPLEMENTED_AGAINST_COMPANY_ID);

          case "err-029":
            return AppError(cause: cause, error: error, type: ErrorType.USE_VALID_ID);

          case "err-030":
            return AppError(cause: cause, error: error, type: ErrorType.GUARDIAN_AGE_VALIDATION);

          case "err-031":
            return AppError(cause: cause, error: error, type: ErrorType.PROFILE_STATUS_NOT_FOUND);

          case "err-032":
            return AppError(cause: cause, error: error, type: ErrorType.RESPONSE_1_REQUIRED);

          case "err-033":
            return AppError(cause: cause, error: error, type: ErrorType.RESPONSE_2_REQUIRED);

          case "err-034":
            return AppError(cause: cause, error: error, type: ErrorType.RESPONSE_3_REQUIRED);

          case "err-035":
            return AppError(cause: cause, error: error, type: ErrorType.RESPONSE_4_REQUIRED);

          case "err-036":
            return AppError(cause: cause, error: error, type: ErrorType.RESPONSE_5_REQUIRED);

          case "err-037":
            return AppError(cause: cause, error: error, type: ErrorType.RESIDENCE_COUNTRY_NOT_FOUND);

          case "err-038":
            return AppError(cause: cause, error: error, type: ErrorType.NO_SIGNATURE_FOUND);

          case "err-039":
            return AppError(cause: cause, error: error, type: ErrorType.FATCA_DETAILS_NOT_FOUND);

          case "err-040":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_MOBILE_CODE);

          case "err-041":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_LIVELINESS_SCORE);

          case "err-042":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_FACE_MATCH_SCORE);

          case "err-043":
            return AppError(cause: cause, error: error, type: ErrorType.FINGERPRINT_ALREADY_EXIST_FOR_DEVICE);

          case "err-044":
            return AppError(cause: cause, error: error, type: ErrorType.FINGERPRINT_NOT_FOUND);

          case "err-045":
            return AppError(cause: cause, error: error, type: ErrorType.JOB_DETAILS_NOT_FOUND);

          case "err-046":
            return AppError(cause: cause, error: error, type: ErrorType.ACCOUNT_PURPOSE_NOT_FOUND);

          case "err-047":
            return AppError(cause: cause, error: error, type: ErrorType.ID_CARD_DATA_NOT_FOUND);

          case "err-048":
            return AppError(cause: cause, error: error, type: ErrorType.CUSTOMER_PREFERENCE_NOT_FOUND);

          case "err-049":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_MINIMUM_AGE);

          case "err-050":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_MAXIMUM_AGE);

          case "err-051":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ACCOUNT_LIMIT);

          case "err-052":
            return AppError(cause: cause, error: error, type: ErrorType.APPLICATION_UNDER_REVIEW);

          case "err-053":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_CREATING_ACCOUNT);

          case "err-054":
            return AppError(cause: cause, error: error, type: ErrorType.RIMNO_TAKEN_BY_OTHER_USER);

          case "err-055":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_CREATING_WORKSPACE);

          case "err-056":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_CREATING_DOCUMENTS);

          case "err-057":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_UPDATING_CATEGORY_CIF);

          case "err-058":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_UPDATING_CATEGORY);

          case "err-059":
            return AppError(cause: cause, error: error, type: ErrorType.NOT_REGISTERED_BANK);

          case "err-060":
            return AppError(cause: cause, error: error, type: ErrorType.PROVIDED_COUNTRY_NOT_ALLOWED);

          case "err-061":
            return AppError(cause: cause, error: error, type: ErrorType.ACCOUNT_INQUIRY_WENT_WRONG_61);

          case "err-062":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ACCOUNT_ID);

          case "err-063":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_WHILE_BALANCE_INQUIRY);

          case "err-064":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_OTP_NETWORK);

          case "err-065":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_OTP_CODE_NETWORK);

          case "err-066":
            return AppError(cause: cause, error: error, type: ErrorType.OTP_REQUESTED_MANY_TIME);

          case "err-067":
            return AppError(cause: cause, error: error, type: ErrorType.OTP_EXPIRED_NETWORK);

          case "err-068":
            return AppError(cause: cause, error: error, type: ErrorType.NOT_ALLOWED_TO_LOGIN);

          case "err-069":
            return AppError(
                cause: cause, error: error, type: ErrorType.IP_ADDRESS_CALL_INTERNAL_SERVER_ERROR);

          case "err-070":
            return AppError(cause: cause, error: error, type: ErrorType.APPLICATION_IN_PROCESS);

          case "err-071":
            return AppError(cause: cause, error: error, type: ErrorType.NO_ACCOUNT_FOUND);

          case "err-072":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_GET_ACCOUNT_DETAILS);

          case "err-073":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_UPDATING_ACCOUNT);

          case "err-074":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_SIGNATURE_NETWORK);

          case "err-075":
            return AppError(cause: cause, error: error, type: ErrorType.NO_ATM_DATA);

          case "err-076":
            return AppError(cause: cause, error: error, type: ErrorType.NOT_VERIFIED);

          case "err-077":
            return AppError(cause: cause, error: error, type: ErrorType.OTP_LIMIT_EXCEED);

          case "err-078":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_OTP_REQ);

          case "err-079":
            return AppError(cause: cause, error: error, type: ErrorType.BENEFICIARY_NOT_FOUND);

          case "err-080":
            return AppError(cause: cause, error: error, type: ErrorType.IMAGE_NOT_FOUND);

          case "err-081":
            return AppError(cause: cause, error: error, type: ErrorType.DOCUMENTS_NOT_FOUND);

          case "err-082":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_EMAIL_NETWORK);

          case "err-083":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_MOBILE_NO);

          case "err-084":
            return AppError(
                cause: cause, error: error, type: ErrorType.DO_NOT_RECOMMEND_TO_USE_PREVIOUS_TENPASS);

          case "err-085":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_CURRENT_PASS);

          case "err-086":
            return AppError(cause: cause, error: error, type: ErrorType.NO_REQUEST_FOUND_RTP);

          case "err-087":
            return AppError(cause: cause, error: error, type: ErrorType.ISO_NATIONALITY_NOT_FOUND);

          case "err-088":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_WHILE_ISSUE_CARD);

          case "err-089":
            return AppError(
                cause: cause, error: error, type: ErrorType.ERROR_WHILE_GETTING_XCS_CUSTOMER_DETAILS);

          case "err-090":
            return AppError(cause: cause, error: error, type: ErrorType.NO_DEBIT_CARD_RECORD_FOUND);

          case "err-091":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_EURONET_CUSTOMER_CARD_DETAILS);

          case "err-092":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_SETTING_PIN_EURONET);

          case "err-093":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_CARD_ID);

          case "err-094":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_FOUR_DIGIT);

          case "err-095":
            return AppError(cause: cause, error: error, type: ErrorType.CONTACTLESS_ERROR);

          case "err-096":
            return AppError(cause: cause, error: error, type: ErrorType.CARD_INFO_ERROR);

          case "err-097":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_GETTING_CARD_INFO);

          case "err-098":
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_ACCOUNT_LIST_NOT_FOUND);

          case "err-099":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_CREATE_CREDIT_CARD);

          case "err-100":
            return AppError(cause: cause, error: error, type: ErrorType.SETTING_CONTACTLESS_ERROR);

          case "err-101":
          case "err-102":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_GETTING_CARD_INFO_NET);

          case "err-103":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_UPDATING_LIMITS);

          case "err-104":
            return AppError(
                cause: cause, error: error, type: ErrorType.ERROR_UPDATING_CARD_STATUS_RULEENGINE);

          case "err-105":
            return AppError(cause: cause, error: error, type: ErrorType.NO_DEBIT_CARD_FOUND);

          case "err-106":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_WHILE_UPDATING_PIN_STATUS_RE);

          case "err-107":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_WHILE_UPDATING_CARD_STATUS_NI);

          case "err-108":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_WHILE_UNBLOCK_PIN_NI);

          case "err-109":
            return AppError(
                cause: cause, error: error, type: ErrorType.ERROR_WHILE_GETTING_ACCOUNT_DETAILS_A2A);

          case "err-110":
            return AppError(cause: cause, error: error, type: ErrorType.PURPOSE_DETAILS_NOT_FOUND);

          case "err-111":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_CUSTOMER_BY_ACCOUNT_A2A);

          case "err-112":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_WHILE_RTP_A2A);

          case "err-113":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ACCOUNT);

          case "err-114":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_WHILE_GETTING_ACCOUNT_BS);

          case "err-115":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_AMOUNT);

          case "err-116":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_MULTIBRANCH_API_BS);

          case "err-117":
            return AppError(cause: cause, error: error, type: ErrorType.TRANSFER_TYPE_NF);

          case "err-118":
            return AppError(cause: cause, error: error, type: ErrorType.TRANSFER_TYPE_NF_RTP);

          case "err-119":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ID_NO);

          case "err-120":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_EXPIRY_DATE);

          case "err-121":
            return AppError(cause: cause, error: error, type: ErrorType.PASSWORD_MISMATCH_ERROR);

          case "err-122":
            return AppError(cause: cause, error: error, type: ErrorType.SENDING_DEVICE_OTP_ERROR);

          case "err-123":
            return AppError(cause: cause, error: error, type: ErrorType.SELECT_FUTURE_DATE);

          case "err-124":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_GENDER_VALUE);

          case "err-125":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_SCHEDULE_TIME);

          case "err-126":
            return AppError(cause: cause, error: error, type: ErrorType.FIREBASE_CONNECTION_ISSUE);

          case "err-127":
            return AppError(cause: cause, error: error, type: ErrorType.CALL_RECORD_NOT_FOUND);

          // case "err-128":
          //   return AppError(
          //       cause: cause, error: error, type: ErrorType.NI_HANDLER_ERROR);

          case "err-128":
            return AppError(cause: cause, error: error, type: ErrorType.USER_NOT_ELIGIBLE);

          case "err-129":
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_VALUES_ERROR);

          case "err-130":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_LOAN_VALUE_ID);

          case "err-131":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_CREDIT_LIMIT);

          case "err-132":
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_VALUE_PROCESS_ERROR);

          case "err-133":
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_VALUE_REQUEST_PROCESSING_ERROR);

          case "err-134":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_CUSTOMER_ID);

          case "err-135":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_CREDIT_CARD_ID);

          case "err-136":
            return AppError(cause: cause, error: error, type: ErrorType.STEP_2_INCOMPLETE);

          case "err-137":
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_STEP_NOT_DONE);

          case "err-138":
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_VALUES_NOT_FOUND);

          case "err-139":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_IN_MESSAGE);

          case "err-140":
            return AppError(cause: cause, error: error, type: ErrorType.CRIF_UPDATE_ERROR);

          case "err-141":
            return AppError(cause: cause, error: error, type: ErrorType.ARMEX_API_ERROR);

          case "err-142":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_PAYBACK_AMOUNT);

          case "err-143":
            return AppError(cause: cause, error: error, type: ErrorType.CREDIT_CARD_DATA_NOT_FOUND);

          case "err-144":
            return AppError(cause: cause, error: error, type: ErrorType.ACCOUNT_CLAIM_NOT_FOUND);

          case "err-145":
            return AppError(cause: cause, error: error, type: ErrorType.CARD_LOAN_ACC_NOT_FOUND);

          case "err-146":
            return AppError(cause: cause, error: error, type: ErrorType.PAYMENT_CASHBACK_ERROR);

          case "err-147":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_PRIMARY_ID);

          case "err-148":
            return AppError(cause: cause, error: error, type: ErrorType.PRIMARY_LOAN_ACC_LIST_NOT_FOUND);

          case "err-149":
            return AppError(cause: cause, error: error, type: ErrorType.PRIMARY_CARD_NOT_ACTIVE);

          case "err-151":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_NATIONAL_ID_CARD);

          case "err-152":
            return AppError(cause: cause, error: error, type: ErrorType.ID_CARD_IS_EXPIRED);

          case "err-153":
            return AppError(cause: cause, error: error, type: ErrorType.LESS_THAN_PRIMARY);

          case "err-154":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_NATIONALITY);

          case "err-155":
            return AppError(cause: cause, error: error, type: ErrorType.WS_CHILD_ERROR);

          case "err-156":
            return AppError(cause: cause, error: error, type: ErrorType.CREATE_CARD_ERROR);

          case "err-157":
            return AppError(cause: cause, error: error, type: ErrorType.PRIMARY_NOT_COMPLETE);

          case "err-158":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_SUPPLEMENTARY_CARD_ID);

          case "err-159":
            return AppError(cause: cause, error: error, type: ErrorType.SET_CONTACTLESS_ZERO_ERROR);

          case "err-160":
            return AppError(cause: cause, error: error, type: ErrorType.CONTACTLESS_ALREADY_DONE);

          case "err-161":
            return AppError(cause: cause, error: error, type: ErrorType.STEP_2_NOT_DONE_CREDIT_CARD);

          case "err-162":
            return AppError(cause: cause, error: error, type: ErrorType.PROCESS_LOAN_STEP_NOT_DONE);

          case "err-163":
            return AppError(cause: cause, error: error, type: ErrorType.CREATING_SHIPMENT_ERROR);

          case "err-164":
            return AppError(cause: cause, error: error, type: ErrorType.PLATFORM_NOT_FOUND);

          case "err-165":
            return AppError(cause: cause, error: error, type: ErrorType.TRANSACTION_NOT_ALLOWED);

          case "err-166":
            return AppError(cause: cause, error: error, type: ErrorType.UNABLE_TO_PROCEED_TRANSACTION);

          case "err-167":
            return AppError(cause: cause, error: error, type: ErrorType.UNABLE_TO_COMPLETE_TRANSACTION);

          case "err-168":
            return AppError(cause: cause, error: error, type: ErrorType.GET_LOAN_PAYMENT_ERROR);

          case "err-169":
            return AppError(cause: cause, error: error, type: ErrorType.PROCESS_LOAN_ERROR);

          case "err-170":
            return AppError(cause: cause, error: error, type: ErrorType.CUSTOMER_NOT_ELIGIBLE);

          case "err-171":
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_NOT_ACTIVE);

          case "err-172":
            return AppError(cause: cause, error: error, type: ErrorType.RETRIEVE_INSTRUCTION_DETAILS);

          case "err-173":
            return AppError(cause: cause, error: error, type: ErrorType.EDRAW_API_GOT_WRONG);

          case "err-174":
            return AppError(cause: cause, error: error, type: ErrorType.ESETTLEMENT_WENT_WRONG);

          case "err-175":
            return AppError(cause: cause, error: error, type: ErrorType.AMOUNT_LIMIT_ERROR);

          case "err-176":
            return AppError(cause: cause, error: error, type: ErrorType.AMOUNT_GREATER_THAN_OUTSTANDING);

          case "err-177":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ID_VERIFICATION_177);

          case "err-178":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ID_VERIFICATION_178);

          case "err-300":
            return AppError(cause: cause, error: error, type: ErrorType.NO_PLACEHOLDER_FOUND);

          case "err-301":
            return AppError(cause: cause, error: error, type: ErrorType.AHWAL_FAILED);

          case "err-302":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_RELATION);

          case "err-303":
            return AppError(cause: cause, error: error, type: ErrorType.PRIMARY_ID_NOT_MATCH_GROOM);

          case "err-304":
            return AppError(cause: cause, error: error, type: ErrorType.SEC_ID_NOT_MATCH_FATHER_MOTHER);

          case "err-305":
            return AppError(
                cause: cause, error: error, type: ErrorType.PRIMARY_DEBIT_CARD_NOT_MATCH_WITH_FATHER_MOTHER);

          case "err-306":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_RELATIONSHIP_API);

          case "err-307":
            return AppError(cause: cause, error: error, type: ErrorType.PRIM_CREDIT_CARD_ID_NOT_MATCH_GROOM);

          case "err-308":
            return AppError(
                cause: cause, error: error, type: ErrorType.SUPP_CREDIT_HOLDER_ID_NOT_MATCH_FATHER_MOTHER);

          case "err-309":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.PRIM_DEBIT_CREDIT_CARD_ID_NOT_MATCH_MOTHER_FATHER);

          case "err-311":
            return AppError(
                cause: cause, error: error, type: ErrorType.NO_DATA_FOUND_IN_FINANCIAL_INSTITUTION);

          case "err-312":
            return AppError(cause: cause, error: error, type: ErrorType.NO_SUPP_USER_DETAILS_FOUND);

          case "err-322":
            return AppError(cause: cause, error: error, type: ErrorType.CANNOT_APPLY_CC_INSUFFICIENT_FUNDS);

          case "err-323":
            return AppError(cause: cause, error: error, type: ErrorType.CANNOT_PROCEED_NO_AHWAL_DATA_FOUND);

          case "err-324":
            return AppError(cause: cause, error: error, type: ErrorType.ID_ALREADY_EXISTS);

          case "err-325":
            return AppError(cause: cause, error: error, type: ErrorType.AHWAL_SERVICE_NOT_AVAILABLE);

          case "err-326":
            return AppError(cause: cause, error: error, type: ErrorType.LOCATION_RESTRICTED);

          case "err-327":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_PHYSICAL_DC_XCS);

          case "err-328":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_FOR_PIN_TRANSLATION_XCS);

          case "err-330":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_CC_UNBLOCK_NI);

          case "err-331":
            return AppError(cause: cause, error: error, type: ErrorType.LOGIN_REGISTER_DISABLED);

          case "err-332":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_FOR_PIN_CHANGE_NI);

          case "err-333":
            return AppError(cause: cause, error: error, type: ErrorType.ID_VERIFICATION_FAILED);

          case "err-337":
            return AppError(cause: cause, error: error, type: ErrorType.PAYMENT_NOT_DONE);

          case "err-338":
            return AppError(cause: cause, error: error, type: ErrorType.NO_TICKETS_FOUND);

          case "err-358":
            return AppError(cause: cause, error: error, type: ErrorType.NO_BILLER_FOUND);

          case "err-359":
            return AppError(cause: cause, error: error, type: ErrorType.NO_PREPAID_CATEGORY_FOUND);

          case "err-360":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_ON_BILL_ENQUIRY);

          case "err-361":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_WHILE_ADDING_CUSTOMER);

          case "err-362":
            return AppError(
                cause: cause, error: error, type: ErrorType.INSUFFICIENT_FUNDS_BILL_CANNOT_BE_PAYED);

          case "err-363":
            return AppError(cause: cause, error: error, type: ErrorType.QR_EXPIRED);

          case "err-364":
            return AppError(cause: cause, error: error, type: ErrorType.QR_NOT_SCANNED);

          case "err-365":
            return AppError(cause: cause, error: error, type: ErrorType.QR_INVALID);

          case "err-375":
            return AppError(
                cause: cause,
                error: error,
                type: ErrorType.BILLER_IS_ALREADY_EXIST_WITHIN_THE_SAME_BILLING_NO);

          case "err-376":
            return AppError(cause: cause, error: error, type: ErrorType.SERVICE_NOT_AVAILABLE);

          case "err-377":
            return AppError(cause: cause, error: error, type: ErrorType.BILL_PAYMENT_SORRY_MESSAGE);

          case "err-150":
            return AppError(cause: cause, error: error, type: ErrorType.RELATIVE_ID_ERROR);

          // case "err-164":
          //   return AppError(
          //       cause: cause, error: error, type: ErrorType.FORCE_UPDATE);

          case "ex-001":
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_ADDING_USERNAME);

          case "ex-002":
            return AppError(cause: cause, error: error, type: ErrorType.REGISTRATION_PROCESS_ERROR);

          case "ex-003":
            return AppError(cause: cause, error: error, type: ErrorType.AHWAL_ERROR);

          case "ex-004":
            return AppError(cause: cause, error: error, type: ErrorType.KYC_STATUS_ERROR);

          case "ex-005":
            return AppError(cause: cause, error: error, type: ErrorType.SAVING_ID_CARD_ERROR);

          case "ex-006":
            return AppError(cause: cause, error: error, type: ErrorType.SAVING_COUNTRY_RESIDENCE_ERROR);

          case "ex-007":
            return AppError(cause: cause, error: error, type: ErrorType.SAVING_PROFILE_STATUS_ERROR);

          case "ex-008":
            return AppError(cause: cause, error: error, type: ErrorType.SAVING_JOB_DETAILS_ERROR);

          case "ex-009":
            return AppError(cause: cause, error: error, type: ErrorType.ADD_ACCOUNT_PURPOSE_ERROR);

          case "ex-010":
            return AppError(cause: cause, error: error, type: ErrorType.FATCA_CRS_ERROR);

          case "ex-011":
            return AppError(cause: cause, error: error, type: ErrorType.UPLOAD_FATCA_SIGNATURE_ERROR);

          case "ex-012":
            return AppError(cause: cause, error: error, type: ErrorType.SAVING_FATCA_DETAILS_ERROR);

          case "ex-013":
            return AppError(cause: cause, error: error, type: ErrorType.SAVING_W8_FORM_ERROR);

          case "ex-014":
            return AppError(cause: cause, error: error, type: ErrorType.SAVING_W9_FORM_ERROR);

          case "ex-015":
            return AppError(cause: cause, error: error, type: ErrorType.SELFIE_CHECK_ERROR);

          case "ex-016":
            return AppError(cause: cause, error: error, type: ErrorType.ENABLE_FINGERPRINT_ERROR);

          case "ex-017":
            return AppError(cause: cause, error: error, type: ErrorType.DISABLE_FINGERPRINT_ERROR);

          case "ex-018":
            return AppError(cause: cause, error: error, type: ErrorType.GET_COMBO_VALUES_ERROR);

          case "ex-019":
            return AppError(cause: cause, error: error, type: ErrorType.GET_ADDITIONAL_DOCUMENTATION_ERROR);

          case "ex-020":
            return AppError(cause: cause, error: error, type: ErrorType.SAVE_ADDITIONAL_DOCUMENTATION_ERROR);

          case "ex-021":
            return AppError(cause: cause, error: error, type: ErrorType.GET_ACCOUNT_DETAILS_ERROR);

          case "ex-022":
            return AppError(cause: cause, error: error, type: ErrorType.CREATING_ACCOUNT_ERROR);

          case "ex-023":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_VIDEO_CALL_STATUS_ERROR);

          case "ex-024":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_OTHER_NATIONALITY_STATUS_ERROR);

          case "ex-025":
            return AppError(cause: cause, error: error, type: ErrorType.UPLOAD_DOCUMENTS_ERROR);

          case "ex-026":
            return AppError(cause: cause, error: error, type: ErrorType.LOGOUT_ERROR);

          case "ex-027":
            return AppError(cause: cause, error: error, type: ErrorType.REGISTER_INTEREST_ERROR);

          case "ex-028":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_OTP_ERROR);

          case "ex-029":
            return AppError(cause: cause, error: error, type: ErrorType.IPHONE_LOGIN_ERROR);

          case "ex-030":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_DOCUMENT_STATUS_ERROR);

          case "ex-031":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_AGENT_STATUS);

          case "ex-032":
            return AppError(cause: cause, error: error, type: ErrorType.CHANGE_CALL_STATUS_ERROR);

          case "ex-033":
            return AppError(cause: cause, error: error, type: ErrorType.SAVE_CUSTOMER_TIME_STATUS_ERROR);

          case "ex-034":
            return AppError(cause: cause, error: error, type: ErrorType.GET_ALLOWED_COUNTRIES_ERROR);

          case "ex-035":
            return AppError(cause: cause, error: error, type: ErrorType.GET_COUNTRIES_ERROR);

          case "ex-036":
            return AppError(cause: cause, error: error, type: ErrorType.REMOVE_DEBIT_LOCK_ERROR);

          case "ex-037":
            return AppError(cause: cause, error: error, type: ErrorType.ENABLE_BIOMETRIC_ERROR);

          case "ex-038":
            return AppError(cause: cause, error: error, type: ErrorType.GET_CIPHER_ERROR);

          case "ex-039":
            return AppError(cause: cause, error: error, type: ErrorType.GENERATE_KEY_PAIR_ERROR);

          case "ex-040":
            return AppError(cause: cause, error: error, type: ErrorType.ANDROID_LOGIN_ERROR);

          case "ex-041":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_CUSTOMER_STATUS_ERROR);

          case "ex-042":
            return AppError(cause: cause, error: error, type: ErrorType.GET_BENEFICIARIES_ERROR);

          case "ex-043":
            return AppError(cause: cause, error: error, type: ErrorType.GET_ATM_ERROR);

          case "ex-044":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_ISSUER);

          case "ex-045":
            return AppError(cause: cause, error: error, type: ErrorType.GET_STATES_ERROR);

          case "ex-046":
            return AppError(cause: cause, error: error, type: ErrorType.GET_CITIES_ERROR);

          case "ex-047":
            return AppError(cause: cause, error: error, type: ErrorType.GET_CITIES_BY_COUNTRY_ERROR);

          case "ex-048":
            return AppError(cause: cause, error: error, type: ErrorType.GET_CONTACTS_ERROR);

          case "ex-049":
            return AppError(cause: cause, error: error, type: ErrorType.ADD_BENEFICIARY_ERROR);

          case "ex-050":
            return AppError(cause: cause, error: error, type: ErrorType.UPDATE_BENEFICIARY_ERROR);

          case "ex-051":
            return AppError(cause: cause, error: error, type: ErrorType.DELETE_BENEFICIARY_ERROR);

          case "ex-052":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_BENEFICIARY_OTP_ERROR);

          case "ex-053":
            return AppError(cause: cause, error: error, type: ErrorType.UPLOAD_BENEFICIARY_ERROR);

          case "ex-054":
            return AppError(cause: cause, error: error, type: ErrorType.GET_PROFILE_INFO_ERROR);

          case "ex-055":
            return AppError(cause: cause, error: error, type: ErrorType.DELETE_PROFILE_IMAGE_ERROR);

          case "ex-056":
            return AppError(cause: cause, error: error, type: ErrorType.Get_CUSTOMER_DOCUMENT_ERROR);

          case "ex-057":
            return AppError(cause: cause, error: error, type: ErrorType.Get_CUSTOMER_DOCUMENT_ID_ERROR);

          case "ex-058":
            return AppError(cause: cause, error: error, type: ErrorType.CHANGE_PROFILE_IMAGE_ERROR);

          case "ex-059":
            return AppError(cause: cause, error: error, type: ErrorType.CHANGE_EMAIL_ERROR);

          case "ex-060":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_CHANGE_EMAIL_ERROR);

          case "ex-061":
            return AppError(cause: cause, error: error, type: ErrorType.CHANGE_MOBILE_NO_ERROR);

          case "ex-062":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_CHANGE_MOBILE_NO_ERROR);

          case "ex-063":
            return AppError(cause: cause, error: error, type: ErrorType.CHANGE_PASSWORD_ERROR);

          case "ex-064":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_OTP_PASSWORD_ERROR);

          case "ex-065":
            return AppError(cause: cause, error: error, type: ErrorType.REQUEST_TO_PAY_STATUS_ERROR);

          case "ex-066":
            return AppError(cause: cause, error: error, type: ErrorType.CARD_ISSUANCE_ERROR);

          case "ex-067":
            return AppError(cause: cause, error: error, type: ErrorType.SET_CARD_PIN_ERROR);

          case "ex-068":
            return AppError(cause: cause, error: error, type: ErrorType.CONFIRM_DELIVERY_ERROR);

          case "ex-069":
            return AppError(cause: cause, error: error, type: ErrorType.GET_DASHBOARD_DATA_ERROR);

          case "ex-070":
            return AppError(cause: cause, error: error, type: ErrorType.MONEY_THOR_ERROR);

          case "ex-071":
            return AppError(cause: cause, error: error, type: ErrorType.DEBIT_CARD_TRANSACTION_LIST_ERROR);

          case "ex-072":
            return AppError(cause: cause, error: error, type: ErrorType.ACCOUNT_ACTIVITY_ERROR);

          case "ex-073":
            return AppError(cause: cause, error: error, type: ErrorType.CONFIRM_CREDIT_CARD_DELIVERY_ERROR);

          case "ex-074":
            return AppError(cause: cause, error: error, type: ErrorType.CREDIT_DASHBOARD_DATA_ERROR);

          case "ex-075":
            return AppError(cause: cause, error: error, type: ErrorType.CREDIT_CARD_REQ_ERROR);

          case "ex-076":
            return AppError(cause: cause, error: error, type: ErrorType.CREDIT_CARD_TRANSACTION_LIST_ERROR);

          case "ex-077":
            return AppError(cause: cause, error: error, type: ErrorType.GET_CREDIT_YEARS_ERROR);

          case "ex-078":
            return AppError(cause: cause, error: error, type: ErrorType.CREDIT_CARD_STATEMENT_ERROR);

          case "ex-079":
            return AppError(cause: cause, error: error, type: ErrorType.GET_DEBIT_YEARS_ERROR);

          case "ex-080":
            return AppError(cause: cause, error: error, type: ErrorType.DEBIT_CARD_STATEMENT_ERROR);

          case "ex-081":
            return AppError(cause: cause, error: error, type: ErrorType.UPDATE_LIMIT_ERROR);

          case "ex-082":
            return AppError(cause: cause, error: error, type: ErrorType.FREEZE_DEBIT_CARD_ERROR);

          case "ex-083":
            return AppError(cause: cause, error: error, type: ErrorType.UNFREEZE_DEBIT_CARD_ERROR);

          case "ex-084":
            return AppError(cause: cause, error: error, type: ErrorType.CANCEL_DEBIT_CARD_ERROR);

          case "ex-085":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_CHANGE_PIN_ERROR);

          case "ex-086":
            return AppError(cause: cause, error: error, type: ErrorType.CHANGE_PIN_ERROR);

          case "ex-087":
            return AppError(cause: cause, error: error, type: ErrorType.UNBLOCK_DEBIT_CARD_PIN_ERROR);

          case "ex-088":
            return AppError(cause: cause, error: error, type: ErrorType.GET_DEBIT_CARD_LIMIT_ERROR);

          case "ex-089":
            return AppError(
                cause: cause, error: error, type: ErrorType.REQUEST_SUPPLEMENTARY_DEBIT_CARD_ERROR);

          case "ex-090":
            return AppError(cause: cause, error: error, type: ErrorType.FREEZE_CREDIT_CARD_ERROR);

          case "ex-091":
            return AppError(cause: cause, error: error, type: ErrorType.UNFREEZE_CREDIT_CARD_ERROR);

          case "ex-092":
            return AppError(cause: cause, error: error, type: ErrorType.UNBLOCK_CREDIT_CARD_PIN_ERROR);

          case "ex-093":
            return AppError(cause: cause, error: error, type: ErrorType.GET_ACCOUNT_BY_ALIAS_ERROR);

          case "ex-094":
            return AppError(cause: cause, error: error, type: ErrorType.REQUEST_TO_PAY_ERROR);

          case "ex-095":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_SEND_MONEY_ERROR);

          case "ex-096":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_TRANSFER_API_ERROR);

          case "ex-097":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_TRANSFER_API_V2_ERROR);

          case "ex-098":
            return AppError(cause: cause, error: error, type: ErrorType.GET_TRANSFER_PURPOSE_ERROR);

          case "ex-099":
            return AppError(cause: cause, error: error, type: ErrorType.PAYMENT_ACTIVITY_API_ERROR);

          case "ex-100":
            return AppError(
                cause: cause, error: error, type: ErrorType.CHECK_CREDENTIALS_FOR_FORGET_PASSWORD_ERROR);

          case "ex-101":
            return AppError(cause: cause, error: error, type: ErrorType.FORGET_PASSWORD_ERROR);

          case "ex-102":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_FORGET_PASSWORD_ERROR);

          case "ex-103":
            return AppError(cause: cause, error: error, type: ErrorType.SEND_OTP_TOKEN_ERROR);

          case "ex-104":
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_DEIVICE_CHANGE_OTP_ERROR);

          case "ex-105":
            return AppError(cause: cause, error: error, type: ErrorType.RESEND_OTP_ERROR);

          case "ex-106":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_EXISTING_CALL_ERROR);

          case "ex-107":
            return AppError(cause: cause, error: error, type: ErrorType.REQUEST_CALL_ERROR);

          case "ex-108":
            return AppError(cause: cause, error: error, type: ErrorType.GET_GENDER_STATUS_ERROR);

          case "ex-109":
            return AppError(cause: cause, error: error, type: ErrorType.GET_TIME_SLOTS_ERROR);

          case "ex-110":
            return AppError(cause: cause, error: error, type: ErrorType.ADD_CALL_ERROR);

          case "ex-111":
            return AppError(cause: cause, error: error, type: ErrorType.CHECK_CALL_STATUS);

          case "ex-112":
            return AppError(cause: cause, error: error, type: ErrorType.GET_CARD_APPLICATION_ERROR);

          case "ex-113":
            return AppError(cause: cause, error: error, type: ErrorType.GET_LOAN_VALUES_ERROR);

          case "ex-114":
            return AppError(cause: cause, error: error, type: ErrorType.PROCESS_LOAN_VALUES_ERROR);

          case "ex-115":
            return AppError(cause: cause, error: error, type: ErrorType.PAYBACK_CREDIT_CARD_ERROR);

          case "ex-116":
            return AppError(cause: cause, error: error, type: ErrorType.SUPPLEMENTARY_CARD_APPLICATION_ERROR);

          case "ex-117":
            return AppError(cause: cause, error: error, type: ErrorType.REQUEST_SUPPLEMENTARY_CARD_ERROR);

          case "ex-118":
            return AppError(cause: cause, error: error, type: ErrorType.SUPPLEMENTARY_CARD_STEP_2_ERROR);

          case "ex-119":
            return AppError(cause: cause, error: error, type: ErrorType.SUPPLEMENTARY_CARD_STEP_3_ERROR);

          case "ex-120":
            return AppError(cause: cause, error: error, type: ErrorType.RELATIONSHIP_LIST_ERROR);

          case "ex-121":
            return AppError(cause: cause, error: error, type: ErrorType.GET_CURRENT_VALUES_ERROR);

          case "err-vkey-1":
            return AppError(cause: cause, error: error, type: ErrorType.REGISTERING_USER_TO_VKEY_ERROR);

          case "err-vkey-2":
            return AppError(cause: cause, error: error, type: ErrorType.NULL_ID);

          case "err-vkey-3":
            return AppError(cause: cause, error: error, type: ErrorType.ASSIGN_TOKEN_ERROR);

          case "err-vkey-4":
            return AppError(cause: cause, error: error, type: ErrorType.TOKEN_SERIAL_APN_EMPTY);

          case "err-vkey-5":
            return AppError(cause: cause, error: error, type: ErrorType.PIN_REQUIRED);

          case "err-vkey-6":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_MESSAGE_ID);

          case "err-vkey-7":
            return AppError(cause: cause, error: error, type: ErrorType.VKEY_TRANSACTION_FAILED);

          case "err-vkey-8":
            return AppError(cause: cause, error: error, type: ErrorType.VKEY_MESSAGE_ID_REQUIRED);

          case "err-vkey-9":
            return AppError(cause: cause, error: error, type: ErrorType.LOGIN_NOT_ALLOWED);

          case "err-0001":
            return AppError(cause: cause, error: error, type: ErrorType.ENTER_DETAILS);

          case "err-0002":
            return AppError(cause: cause, error: error, type: ErrorType.IMAGE_NULL);

          case "err-0003":
            return AppError(cause: cause, error: error, type: ErrorType.PROOF_REQUIRED);

          case "err-0004":
            return AppError(cause: cause, error: error, type: ErrorType.OTP_NULL);

          case "err-0005":
            return AppError(cause: cause, error: error, type: ErrorType.DEVICE_IS_REQUIRED);

          case "err-0007":
            return AppError(cause: cause, error: error, type: ErrorType.PLACEHOLDER_ID_NULL);

          case "err-0008":
            return AppError(cause: cause, error: error, type: ErrorType.RELATION_NULL);

          case "err-0009":
            return AppError(cause: cause, error: error, type: ErrorType.RELATIONSHIP_NULL);
          case "Invalid OTP":
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_OTP_NETWORK);
          case "err-382":
            return AppError(cause: cause, error: error, type: ErrorType.DAILY_LIMIT_EXCEDED);
          default:
            return AppError(cause: cause, error: error, type: ErrorType.NETWORK);
        }
    }
  }
}

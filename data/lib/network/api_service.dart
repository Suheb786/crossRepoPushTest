import 'package:data/entity/remote/account/check_agent_status_request_entity.dart';
import 'package:data/entity/remote/account/check_agent_status_response_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_request_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_response_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_request_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:data/entity/remote/account/doc_status_request_entity.dart';
import 'package:data/entity/remote/account/doc_status_response_entity.dart';
import 'package:data/entity/remote/ahwal/get_ahwal_details_request.dart';
import 'package:data/entity/remote/bank_smart/add_account_purpose_request.dart';
import 'package:data/entity/remote/bank_smart/create_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/create_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_response_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/purpose_of_account_opening_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/save_fatca_information_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/kyc/check_kyc_status_response_entity.dart';
import 'package:data/entity/remote/kyc/kyc_status_request.dart';
import 'package:data/entity/remote/upload_document/save_upload_document_request_entity.dart';
import 'package:data/entity/remote/upload_document/save_upload_document_response_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_request_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_response_entity.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/check_user_name_mobile_request.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/confirm_application_data_get_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/get_confirm_application_data_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_response_entity.dart';
import 'package:data/entity/remote/user/disable_finger_print/disable_finger_print_request_entity.dart';
import 'package:data/entity/remote/user/enable_finger_print/enable_finger_print_request_entity.dart';
import 'package:data/entity/remote/user/fetch_countrylist_request.dart';
import 'package:data/entity/remote/user/get_token_response_entity.dart';
import 'package:data/entity/remote/user/login_response_entity.dart';
import 'package:data/entity/remote/user/login_user_request.dart';
import 'package:data/entity/remote/user/logout/logout_request_entity.dart';
import 'package:data/entity/remote/user/logout/logout_response_entity.dart';
import 'package:data/entity/remote/user/register_interest/register_interest_request_entity.dart';
import 'package:data/entity/remote/user/register_interest/register_interest_response_entity.dart';
import 'package:data/entity/remote/user/register_prospect_user_request.dart';
import 'package:data/entity/remote/user/register_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/entity/remote/user/save_country_residence_info_response_entity.dart';
import 'package:data/entity/remote/user/save_id_info_request.dart';
import 'package:data/entity/remote/user/save_id_info_response_entity.dart';
import 'package:data/entity/remote/user/save_job_details_response_entity.dart';
import 'package:data/entity/remote/user/save_job_info_request.dart';
import 'package:data/entity/remote/user/save_profile_information_request.dart';
import 'package:data/entity/remote/user/save_profile_status_response_entity.dart';
import 'package:data/entity/remote/user/save_residence_information_request.dart';
import 'package:data/entity/remote/user/save_selfie_image_request.dart';
import 'package:data/entity/remote/user/verify_mobile_otp_request.dart';
import 'package:data/entity/remote/user/verify_otp_response_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'network_properties.dart';

part 'api_service.g.dart';

//flutter pub run build_runner build
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST("${NetworkProperties.BASE_ROUTER_URL}/auth/CheckUserName")
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserName(
      @Body() CheckUserEmailRequest request);

  @POST("${NetworkProperties.BASE_ROUTER_URL}/auth/CheckUserNameMobile")
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserNameMobile(
      @Body() CheckUserNameMobileRequest checkUserNameMobileRequest);

  @POST("/auth/login")
  Future<HttpResponse<LoginResponseEntity>> loginUser(
      @Body() LoginUserRequest loginUserRequest);

  @POST("/auth/RegisterV2")
  Future<HttpResponse<RegisterResponseEntity>> registerProspectUser(
      @Body() RegisterProspectUserRequest registerProspectUserRequest);

  @POST("/auth/VerifyMobileOtp")
  Future<HttpResponse<VerifyOtpResponseEntity>> verifyMobileOtp(
      @Body() VerifyMobileOtpRequest verifyMobileOtpRequest);

  @POST("/transfer/GetCountries")
  Future<String> fetchCountryList(
      @Body() FetchCountryListRequest fetchCountryListRequest);

  @POST("/IdCard/set")
  Future<HttpResponse<SaveIdInfoResponseEntity>> saveIdInfo(
      @Body() SaveIdInfoRequest saveIdInfoRequest);

  @POST("/Account/SelfeeCheck")
  Future<HttpResponse<ResponseEntity>> uploadSelfieImage(
      @Body() SaveSelfieImageRequest saveSelfieImageRequest);

  @POST("/AddFeilds/SaveJobDetails")
  Future<HttpResponse<SaveJobDetailsResponseEntity>> saveJobInformation(
      @Body() SaveJobInfoRequest saveJobInfoRequest);

  @POST("/AddFeilds/SaveProfileStatus")
  Future<HttpResponse<SaveProfileStatusResponseEntity>> saveProfileInformation(
      @Body() SaveProfileInformationRequest saveProfileInformationRequest);

  @POST("/AddFeilds/SaveCountryResidenceInfo")
  Future<HttpResponse<SaveCountryResidenceInfoResponseEntity>>
      saveResidenceInformation(
          @Body()
              SaveResidenceInformationRequest saveResidenceInformationRequest);

  @POST("/kyc/getstatus")
  Future<HttpResponse<CheckKycStatusResponseEntity>> checkKYCStatus(
      @Body() KYCStatusRequest kycStatusRequest);

  @POST("/idcard/CheckAhwal")
  Future<String> getAhwalDetails(
      @Body() GetAhwalDetailsRequest getAhwalDetailsRequest);

  @POST("/Banksmart/AddAccountPurpose")
  Future<HttpResponse<PurposeOfAccountOpeningResponseEntity>> addAccountPurpose(
      @Body() AddAccountPurposeRequest addAccountPurposeRequest);

  @POST("/FatcaCrs/get")
  Future<HttpResponse<GetFatcaQuestionsResponseEntity>> getFatcaQuestions(
      @Body() GetFatcaQuestionsRequestEntity getFatcaQuestionsRequestEntity);

  @POST("/FatcaCrs/set")
  Future<HttpResponse<SetFatcaQuestionsResponseEntity>> saveFatcaInformation(
      @Body()
          SaveFatcaInformationRequestEntity saveFatcaInformationRequestEntity);

  @POST("/BankSmart/GetAccount")
  Future<HttpResponse<GetAccountResponseEntity>> getAccount(
      @Body() GetAccountRequestEntity getAccountRequestEntity);

  @POST("/BankSmart/CreateAccount")
  Future<HttpResponse<CreateAccountResponseEntity>> createAccount(
      @Body() CreateAccountRequestEntity createAccountRequestEntity);

  @POST("/BankSmart/GetAccountDetails")
  Future<HttpResponse<GetAccountDetailsResponseEntity>> getAccountDetails(
      @Body() GetAccountDetailsRequestEntity getAccountDetailsRequestEntity);

  ///get token
  @GET("/auth/verifyToken")
  Future<HttpResponse<GetTokenResponseEntity>> getToken();

  ///check video call status
  @POST("/Account/CheckVideoCallStatus")
  Future<HttpResponse<CheckVideoCallStatusResponseEntity>> checkVideoCallStatus(
      @Body()
          CheckVideoCallStatusRequestEntity checkVideoCallStatusRequestEntity);

  ///check other nationality status
  @POST("/Account/CheckOtherNationalityStatus")
  Future<HttpResponse<CheckOtherNationalityStatusResponseEntity>>
      checkOtherNationalityStatus(
          @Body()
              CheckOtherNationalityStatusRequestEntity
                  checkOtherNationalityStatusRequestEntity);

  ///upload document
  @POST("/FileUpload/UploadDocuments")
  Future<HttpResponse<UploadDocumentResponseEntity>> uploadDocument(
      @Body() UploadDocumentRequestEntity uploadDocumentRequestEntity);

  ///save upload document
  @POST("/FileUpload/SaveUploadDocumentsDocs")
  Future<HttpResponse<SaveUploadDocumentResponseEntity>> saveUploadDocument(
      @Body() SaveUploadDocumentRequestEntity saveUploadDocumentRequestEntity);

  ///get confirm application data
  @POST("/AdditionalDoc/ConfirmApplicationDataGet")
  Future<HttpResponse<GetConfirmApplicationDataResponseEntity>>
      confirmApplicationDataGet(
          @Body()
              ConfirmApplicationDataGetRequestEntity
                  confirmApplicationDataGetRequestEntity);

  ///doc status
  @POST("/account/DocsStatus")
  Future<HttpResponse<DocStatusResponseEntity>> docStatus(
      @Body() DocStatusRequestEntity docStatusRequestEntity);

  ///register interest
  @POST("/auth/RegisterInterest")
  Future<HttpResponse<RegisterInterestResponseEntity>> registerInterest(
      @Body() RegisterInterestRequestEntity registerInterestRequestEntity);

  ///logout
  @POST("/auth/logout")
  Future<HttpResponse<LogoutResponseEntity>> logout(
      @Body() LogoutRequestEntity logoutRequestEntity);

  ///confirm application data set
  @POST("/AdditionalDoc/ConfirmApplicationDataSave")
  Future<HttpResponse<ConfirmApplicationDataSetResponseEntity>>
      confirmApplicationDataSet(
          @Body()
              ConfirmApplicationDataSetRequestEntity
                  confirmApplicationDataSetRequestEntity);

  ///enable fingerprint
  @POST("/auth/enableFingerPrint")
  Future<bool> enableFingerPrint(
      @Body() EnableFingerPrintRequestEntity enableFingerPrintRequestEntity);

  ///disable fingerprint
  @POST("/auth/DisableFingerPrint")
  Future<bool> disableFingerPrint(
      @Body() DisableFingerPrintRequestEntity disableFingerPrintRequestEntity);

  ///check agent status
  @POST("/Account/CheckAgentStatus")
  Future<HttpResponse<CheckAgentStatusResponseEntity>> checkAgentStatus(
      @Body() CheckAgentStatusRequestEntity checkAgentStatusRequestEntity);
}

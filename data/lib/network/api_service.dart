import 'package:data/entity/remote/account/check_agent_status_request_entity.dart';
import 'package:data/entity/remote/account/check_agent_status_response_entity.dart';
import 'package:data/entity/remote/account/check_existing_call_response_entity.dart';
import 'package:data/entity/remote/account/check_existing_video_call_request.dart';
import 'package:data/entity/remote/account/check_gender_status_response_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_request_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_response_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_request_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:data/entity/remote/account/doc_status_request_entity.dart';
import 'package:data/entity/remote/account/doc_status_response_entity.dart';
import 'package:data/entity/remote/account/get_call_status_request.dart';
import 'package:data/entity/remote/account/get_time_slots_request.dart';
import 'package:data/entity/remote/account/get_time_slots_response_entity.dart';
import 'package:data/entity/remote/account/request_call_response_entity.dart';
import 'package:data/entity/remote/account/request_video_call_request.dart';
import 'package:data/entity/remote/account/save_customer_schedule_time_request_entity.dart';
import 'package:data/entity/remote/account/video_call_status_response_entity.dart';
import 'package:data/entity/remote/accountsettings/change_email_request.dart';
import 'package:data/entity/remote/accountsettings/change_mobile_request.dart';
import 'package:data/entity/remote/accountsettings/change_password_request.dart';
import 'package:data/entity/remote/accountsettings/get_customer_doc_id_response_entity.dart';
import 'package:data/entity/remote/accountsettings/get_customer_document_request_entity.dart';
import 'package:data/entity/remote/accountsettings/get_customer_document_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_changed_success_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_details_response_entity.dart';
import 'package:data/entity/remote/accountsettings/update_profile_image_request.dart';
import 'package:data/entity/remote/accountsettings/verify_change_email_request.dart';
import 'package:data/entity/remote/accountsettings/verify_change_mobile_request_entity.dart';
import 'package:data/entity/remote/activity/activity_request_entity.dart';
import 'package:data/entity/remote/activity/activity_response_entity.dart';
import 'package:data/entity/remote/ahwal/ahwal_detail_response_entity.dart';
import 'package:data/entity/remote/ahwal/get_ahwal_details_request.dart';
import 'package:data/entity/remote/bank_smart/add_account_purpose_request.dart';
import 'package:data/entity/remote/bank_smart/create_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/create_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_response_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/purpose_of_account_opening_response_entity.dart';
import 'package:data/entity/remote/bank_smart/remove_debit_lock_request_entity.dart';
import 'package:data/entity/remote/bank_smart/remove_debit_lock_response_entity.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/card/account_card_statement_response_entity.dart';
import 'package:data/entity/remote/card/cancel_credit_card_request.dart';
import 'package:data/entity/remote/card/cancel_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/card/card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_transaction_response_entity.dart';
import 'package:data/entity/remote/card/cc_change_linked_mobile_number/cc_change_mobile_number_request_entity.dart';
import 'package:data/entity/remote/card/cc_change_linked_mobile_number/cc_change_mobile_number_verify_request_entity.dart';
import 'package:data/entity/remote/card/cc_new_settlement/cc_update_settlement_request_entity.dart';
import 'package:data/entity/remote/card/change_debit_card_pin_request.dart';
import 'package:data/entity/remote/card/confirm_creditcard_delivery_request.dart';
import 'package:data/entity/remote/card/credit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/credit_card_relationship/credit_card_relationship_response_entity.dart';
import 'package:data/entity/remote/card/credit_card_statement_request.dart';
import 'package:data/entity/remote/card/credit_card_video_call/credit_card_call_status_update_request.dart';
import 'package:data/entity/remote/card/credit_supplementary/get_credit_card_relationship_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/get_supplementary_credit_card_application_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_application_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_request_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_step_three_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_step_two_request_entity.dart';
import 'package:data/entity/remote/card/dc_change_linked_mobile_number/dc_change_mobile_number_request_entity.dart';
import 'package:data/entity/remote/card/dc_change_linked_mobile_number/dc_change_mobile_number_verify_request_entity.dart';
import 'package:data/entity/remote/card/debit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/debit_card_statement_request.dart';
import 'package:data/entity/remote/card/debit_supplementary/apply_debit_supplementary_card_request.dart';
import 'package:data/entity/remote/card/debit_supplementary/remove_or_reapply_supplementary_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/debit_years_response_entity.dart';
import 'package:data/entity/remote/card/freeze_credit_card_request_entity.dart';
import 'package:data/entity/remote/card/freeze_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/get_card_application/get_card_application_response_entity.dart';
import 'package:data/entity/remote/card/get_credit_card_transaction_list_request_entity.dart';
import 'package:data/entity/remote/card/get_debit_card_transaction_request.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_request_entity.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_response_entity.dart';
import 'package:data/entity/remote/card/link_card_step/link_card_step_request_entity.dart';
import 'package:data/entity/remote/card/process_loan_request/process_loan_request_entity.dart';
import 'package:data/entity/remote/card/process_loan_request/process_loan_response_entity.dart';
import 'package:data/entity/remote/card/report_stolen_cc/report_stolen_cc_request_entity.dart';
import 'package:data/entity/remote/card/request_card_request.dart';
import 'package:data/entity/remote/card/set_card_pin_request.dart';
import 'package:data/entity/remote/card/unblock_debit_card_pin_request.dart';
import 'package:data/entity/remote/contact/add_beneficiary_request.dart';
import 'package:data/entity/remote/contact/delete_beneficiary_request.dart';
import 'package:data/entity/remote/contact/get_beneficiary_response_entity.dart';
import 'package:data/entity/remote/contact/update_beneficiary_request.dart';
import 'package:data/entity/remote/contact/upload_beneficiary_image_request.dart';
import 'package:data/entity/remote/contact/verify_beneficiary_otp_request.dart';
import 'package:data/entity/remote/country/city_list/city_list_request_entity.dart';
import 'package:data/entity/remote/country/city_list/city_list_response_entity.dart';
import 'package:data/entity/remote/country/country_list/country_list_request_entity.dart';
import 'package:data/entity/remote/country/country_list/country_list_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_request_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_issuer/get_allowed_issuer_response_entity.dart';
import 'package:data/entity/remote/country/state_list/state_list_request_entity.dart';
import 'package:data/entity/remote/country/state_list/state_list_response_entity.dart';
import 'package:data/entity/remote/credit_card_limit/get_credit_card_limit_request_entity.dart';
import 'package:data/entity/remote/credit_card_limit/get_credit_card_limit_response_entity.dart';
import 'package:data/entity/remote/dashboard/atms_response_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_data_request.dart';
import 'package:data/entity/remote/dashboard/dashboard_data_response_entity.dart';
import 'package:data/entity/remote/dashboard/placeholder/get_placeholder_request_entity.dart';
import 'package:data/entity/remote/dashboard/placeholder/placeholder_response_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_request_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_response_entity.dart';
import 'package:data/entity/remote/device_change/resend_otp_device_change_request_entity.dart';
import 'package:data/entity/remote/device_change/send_otp_token_device_change_request_entity.dart';
import 'package:data/entity/remote/device_change/send_otp_token_email_request_entity.dart';
import 'package:data/entity/remote/device_change/verify_device_change_otp_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/save_fatca_information_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_w8_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_w9_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_response_entity.dart';
import 'package:data/entity/remote/forget_password/check_forget_password_request_entity.dart';
import 'package:data/entity/remote/forget_password/check_forget_password_response_entity.dart';
import 'package:data/entity/remote/forget_password/forget_password_request_entity.dart';
import 'package:data/entity/remote/forget_password/forget_password_response_entity.dart';
import 'package:data/entity/remote/forget_password/verify_forget_password_otp_request_entity.dart';
import 'package:data/entity/remote/forget_password/verify_forget_password_otp_response_entity.dart';
import 'package:data/entity/remote/kyc/check_kyc_status_response_entity.dart';
import 'package:data/entity/remote/kyc/kyc_status_request.dart';
import 'package:data/entity/remote/payment/check_send_money_request_entity.dart';
import 'package:data/entity/remote/payment/check_send_money_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_content_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_request_entity.dart';
import 'package:data/entity/remote/payment/pay_back_credit_card_request_entity.dart';
import 'package:data/entity/remote/payment/payment_activity_request_entity.dart';
import 'package:data/entity/remote/payment/payment_activity_response_entity.dart';
import 'package:data/entity/remote/payment/request_to_pay_content_response_entity.dart';
import 'package:data/entity/remote/payment/request_to_pay_request_entity.dart';
import 'package:data/entity/remote/payment/transfer_request_entity.dart';
import 'package:data/entity/remote/payment/transfer_success_response_entity.dart';
import 'package:data/entity/remote/purpose/purpose_request_entity.dart';
import 'package:data/entity/remote/purpose/purpose_response_entity.dart';
import 'package:data/entity/remote/upload_document/save_upload_document_request_entity.dart';
import 'package:data/entity/remote/upload_document/save_upload_document_response_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_request_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_response_entity.dart';
import 'package:data/entity/remote/user/biometric_login/get_cipher_response_entity.dart';
import 'package:data/entity/remote/user/change_my_number/change_my_number_request_entity.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/check_user_name_mobile_request.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/check_version_update_request.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/confirm_application_data_get_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/get_confirm_application_data_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_response_entity.dart';
import 'package:data/entity/remote/user/current_version/current_version_response_entity.dart';
import 'package:data/entity/remote/user/disable_finger_print/disable_finger_print_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/android_login_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/enable_biometric_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/get_cipher_request_entity.dart';
import 'package:data/entity/remote/user/enable_finger_print/enable_finger_print_request_entity.dart';
import 'package:data/entity/remote/user/fetch_countrylist_request.dart';
import 'package:data/entity/remote/user/generate_key_pair/generate_key_pair_request_entity.dart';
import 'package:data/entity/remote/user/generate_key_pair/generate_key_pair_response_entity.dart';
import 'package:data/entity/remote/user/get_combo_values/get_combo_values_request_entity.dart';
import 'package:data/entity/remote/user/get_combo_values/get_combo_values_response_entity.dart';
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
import 'package:data/entity/remote/user/status/customer_status_response_entity.dart';
import 'package:data/entity/remote/user/verify_mobile_otp_request.dart';
import 'package:data/entity/remote/user/verify_otp_response_entity.dart';
import 'package:data/network/network_properties.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

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

  @POST("/auth/RegisterV3")
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
  Future<HttpResponse<AhwalDetailResponseEntity>> getAhwalDetails(
      @Body() GetAhwalDetailsRequest getAhwalDetailsRequest);

  @POST("/Banksmart/AddAccountPurpose")
  Future<HttpResponse<PurposeOfAccountOpeningResponseEntity>> addAccountPurpose(
      @Body() AddAccountPurposeRequest addAccountPurposeRequest);

  @POST("/FatcaCrs/get")
  Future<HttpResponse<GetFatcaQuestionsResponseEntity>> getFatcaQuestions(
      @Body() GetFatcaQuestionsRequestEntity getFatcaQuestionsRequestEntity);

  @POST("/FatcaCrs/setFatcaV1")
  Future<HttpResponse<SetFatcaQuestionsResponseEntity>> saveFatcaInformation(
      @Body()
          SaveFatcaInformationRequestEntity saveFatcaInformationRequestEntity);

  @POST("/BankSmart/GetAccountV1")
  Future<HttpResponse<GetAccountResponseEntity>> getAccount(
      @Body() GetAccountRequestEntity getAccountRequestEntity);

  @POST("/BankSmart/CreateAccountV1")
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
  Future<HttpResponse<ResponseEntity>> disableFingerPrint(
      @Body() DisableFingerPrintRequestEntity disableFingerPrintRequestEntity);

  ///check agent status
  @POST("/Account/CheckAgentStatus")
  Future<HttpResponse<CheckAgentStatusResponseEntity>> checkAgentStatus(
      @Body() CheckAgentStatusRequestEntity checkAgentStatusRequestEntity);

  ///get country list
  @POST("/transfer/GetCountriesV1")
  Future<HttpResponse<CountryListResponseEntity>> getCountryList(
      @Body() CountryListRequestEntity countryListRequestEntity);

  ///get allowed country code list
  @POST("${NetworkProperties.BASE_ROUTER_URL}/Country/GetAllowedCode")
  Future<HttpResponse<GetAllowedCountryResponseEntity>>
      getAllowedCodeCountryList(
          @Body()
              GetAllowedCountryRequestEntity getAllowedCountryRequestEntity);

  ///generate key pair
  @POST("/auth/GenerateKeyPair")
  Future<HttpResponse<GenerateKeyPairResponseEntity>> generateKeyPair(
      @Body() GenerateKeyPairRequestEntity generateKeyPairRequestEntity);

  ///enable biometric
  @POST("/auth/EnableBioMetric")
  Future<HttpResponse<ResponseEntity>> enableBiometric(
      @Body() EnableBiometricRequestEntity enableBiometricRequestEntity);

  ///upload Signature
  @POST("/FatcaCrs/UploadSignatureFatca")
  Future<HttpResponse<UploadSignatureResponseEntity>> uploadSignature(
      @Body() UploadSignatureRequestEntity uploadSignatureRequestEntity);

  ///remove debit lock
  @POST("/BankSmart/RemoveDebitLock")
  Future<HttpResponse<RemoveDebitLockResponseEntity>> removeDebitLock(
      @Body() RemoveDebitLockRequestEntity removeDebitLockRequestEntity);

  ///get combo values
  @POST("/AdditionalFieldsResp/getcombovalues")
  Future<HttpResponse<GetComboValuesResponseEntity>> getComboValues(
      @Body() GetComboValuesRequestEntity getComboValuesRequestEntity);

  @POST("/CardTracking/CardIssuance")
  Future<HttpResponse<CardIssuanceResponseEntity>> getCardIssuanceDetails(
      @Body() BaseRequest request);

  @POST("/CardTracking/SetCardPin")
  Future<HttpResponse<ResponseEntity>> setCardPin(
      @Body() SetCardPinRequest setCardPinRequest);

  @POST("/CardTracking/ConfirmDelivery")
  Future<HttpResponse<ResponseEntity>> confirmCardDelivery(
      @Body() BaseRequest cardIssuanceRequest);

  @POST("/CardTracking/ConfirmCreditCardDelivery")
  Future<HttpResponse<ResponseEntity>> confirmCreditCardDelivery(
      @Body() ConfirmCreditCardDeliveryRequest cardIssuanceRequest);

  @POST("/auth/ChangeEmail")
  Future<HttpResponse<ResponseEntity>> changeEmail(
      @Body() ChangeEmailRequest changeEmailRequest);

  @POST("/auth/ChangeMobile")
  Future<HttpResponse<ResponseEntity>> changeMobile(
      @Body() ChangeMobileRequest changeMobileRequest);

  @POST("/CustomerDetails/GetProfileInfo")
  Future<HttpResponse<ProfileDetailsResponseEntity>> getProfileDetails(
      @Body() BaseRequest baseRequest);

  @POST("/auth/ChangePassword")
  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> changePassword(
      @Body() ChangePasswordRequest changePasswordRequest);

  @POST("/CustomerDetails/ChangeProfileImage")
  Future<HttpResponse<ResponseEntity>> updateProfileImage(
      @Body() UpdateProfileImageRequest updateProfileImageRequest);

  @POST("/auth/VerifyChangeEmail")
  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeEmail(
      @Body() VerifyChangeEmailRequest verifyChangeEmailRequest);

  @POST("/auth/VerifyChangeMobile")
  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeMobile(
      @Body() VerifyChangeMobileRequestEntity verifyChangeMobileRequestEntity);

  @POST("/beneficiary/GetBeneficiaries")
  Future<HttpResponse<GetBeneficiaryResponseEntity>> getBeneficiaries(
      @Body() BaseRequest baseRequest);

  @POST("/beneficiary/AddBeneficiary")
  Future<HttpResponse<ResponseEntity>> addBeneficiary(
      @Body() AddBeneficiaryRequest addBeneficiaryRequest);

  @POST("/beneficiary/UpdateBeneficiary")
  Future<HttpResponse<ResponseEntity>> updateBeneficiary(
      @Body() UpdateBeneficiaryRequest updateBeneficiaryRequest);

  @POST("/beneficiary/DeleteBeneficiary")
  Future<HttpResponse<ResponseEntity>> deleteBeneficiary(
      @Body() DeleteBeneficiaryRequest deleteBeneficiaryRequest);

  @POST("/beneficiary/VerifyBeneficiaryOTP")
  Future<HttpResponse<ResponseEntity>> verifyBeneficiaryOtp(
      @Body() VerifyBeneficiaryOtpRequest verifyBeneficiaryOtpRequest);

  @POST("/beneficiary/UploadBeneficiaryImage")
  Future<HttpResponse<ResponseEntity>> uploadBeneficiaryImage(
      @Body() UploadBeneficiaryImageRequest uploadBeneficiaryImageRequest);

  @POST("/Dashboard/GetDashboardDataV3")
  Future<HttpResponse<DashboardDataResponseEntity>> getDashboardData(
      @Body() DashboardDataRequest dashboardDataRequest);

  @POST("/MoneyThor/GetDebitCardTransactionsList")
  Future<HttpResponse<CardTransactionResponseEntity>> getDebitCardTransactions(
      @Body() GetDebitCardTransactionRequest debitCardTransactionRequest);

  @POST("/MoneyThor/GetCreditCardTransactionsList")
  Future<HttpResponse<CardTransactionResponseEntity>> getCreditCardTransactions(
      @Body()
          GetCreditCardTransactionListRequestEntity
              getCreditCardTransactionListRequestEntity);

  @POST("/BankSmart/GetAtms")
  Future<HttpResponse<AtmsResponseEntity>> getAtms(
      @Body() BaseRequest baseRequest);

  @POST("/CardTracking/CreditCardReqV1")
  Future<HttpResponse<ResponseEntity>> requestCreditCard(
      @Body() RequestCardRequest requestCardRequest);

  @POST("/CardTracking/GetCreditCardStatementV1")
  Future<HttpResponse<CardStatementResponseEntity>> getCreditCardStatement(
      @Body() CreditCardStatementRequest cardStatementRequest);

  @POST("/CardTracking/GetDebitCardStatement")
  Future<HttpResponse<AccountCardStatementResponseEntity>>
      getDebitCardStatement(
          @Body() DebitCardStatementRequest cardStatementRequest);

  @POST("/CardTracking/GetCreditYears")
  Future<HttpResponse<DebitYearsResponseEntity>> getCreditYears(
      @Body() BaseRequest baseRequest);

  @POST("/CardTracking/GetDebitYears")
  Future<HttpResponse<DebitYearsResponseEntity>> getDebitYears(
      @Body() BaseRequest baseRequest);

  @POST("/DebitCard/DebitCardLimit")
  Future<HttpResponse<DebitCardLimitResponseEntity>> getDebitCardLimit(
      @Body() DebitCardLimitRequestEntity baseRequest);

  @POST("/RuleEngine/CancelCreditCard")
  Future<HttpResponse<ResponseEntity>> cancelCreditCard(
      @Body() CancelCreditCardRequest cancelCreditCardRequest);

  @POST("/RuleEngine/PinUnblock")
  Future<HttpResponse<ResponseEntity>> creditCardPinUnBlock(
      @Body() BaseRequest baseRequest);

  @POST("/RuleEngine/FreezeCreditCard")
  Future<HttpResponse<ResponseEntity>> freezeCreditCard(
      @Body() FreezeCreditCardRequestEntity freezeCreditCardRequestEntity);

  @POST("/RuleEngine/UnfreezeCreditCard")
  Future<HttpResponse<ResponseEntity>> unFreezeCreditCard(
      @Body() FreezeCreditCardRequestEntity unFreezeCreditCardRequestEntity);

  @POST("/DebitCard/CancelCardV2")
  Future<HttpResponse<ResponseEntity>> cancelDebitCard(
      @Body() CancelDebitCardRequestEntity cancelDebitCardRequest);

  @POST("/DebitCard/FreezeCard")
  Future<HttpResponse<ResponseEntity>> freezeDebitCard(
      @Body() FreezeDebitCardRequestEntity freezeDebitCardRequestEntity);

  @POST("/DebitCard/unFreezeCard")
  Future<HttpResponse<ResponseEntity>> unFreezeDebitCard(
      @Body() FreezeDebitCardRequestEntity unfreezeDebitCardRequestEntity);

  @POST("/DebitCard/ChangePin")
  Future<HttpResponse<ResponseEntity>> changeDebitCardPin(
      @Body() ChangeDebitCardPinRequest changeDebitCardPinRequest);

  @POST("/DebitCard/UnblockPin")
  Future<HttpResponse<ResponseEntity>> unblockDebitCardPin(
      @Body() UnblockDebitCardPinRequest unblockDebitCardPinRequest);

  @POST("/transfer/GetAccountByAlisas")
  Future<HttpResponse<GetAccountByAliasContentResponseEntity>>
      getAccountByAlias(
          @Body()
              GetAccountByAliasRequestEntity getAccountByAliasRequestEntity);

  @POST("/transfer/CheckSendMoney")
  Future<HttpResponse<CheckSendMoneyResponseEntity>> checkSendMoney(
      @Body() CheckSendMoneyRequestEntity checkSendMoneyRequestEntity);

  @POST("/transfer/TransferAPIV2")
  Future<HttpResponse<TransferSuccessResponseEntity>> transfer(
      @Body() TransferRequestEntity transferRequestEntity);

  @POST("/transfer/RequestToPayV1")
  Future<HttpResponse<RequestToPayContentResponseEntity>> requestToPay(
      @Body() RequestToPayRequestEntity requestToPayRequestEntity);

  @POST("/transfer/TransferAPIVerify")
  Future<HttpResponse<ResponseEntity>> transferVerify(
      @Body() BaseRequest baseRequest);

  @POST("/DebitCard/UpdateLimit")
  Future<HttpResponse<ResponseEntity>> updateDebitCardLimits(
      @Body()
          DebitCardSLimitsUpdateRequestEntity
              debitCardSLimitsUpdateRequestEntity);

  @POST("/CardTracking/UpdateLimit")
  Future<HttpResponse<ResponseEntity>> updateCreditCardLimits(
      @Body()
          CreditCardSLimitsUpdateRequestEntity
              creditCardSLimitsUpdateRequestEntity);

  @POST("/transfer/TransferPurpose")
  Future<HttpResponse<PurposeResponseEntity>> getPurpose(
      @Body() PurposeRequestEntity purposeRequestEntity);

  ///get states
  @POST("/Auth/GetStates")
  Future<HttpResponse<StateListResponseEntity>> getStateList(
      @Body() StateListRequestEntity stateListRequestEntity);

  ///get cities
  @POST("/Auth/GetCities")
  Future<HttpResponse<CityListResponseEntity>> getCityList(
      @Body() CityListRequestEntity cityListRequestEntity);

  ///get cities by country
  @POST("/Auth/GetCitiesByCountry")
  Future<HttpResponse<CityListResponseEntity>> getCitiesByCountry(
      @Body() CityListRequestEntity cityListRequestEntity);

  ///set fatca w8
  @POST("/FatcaCrs/SetW8V1")
  Future<HttpResponse<ResponseEntity>> saveFatcaW8(
      @Body() SetFatcaW8RequestEntity setFatcaW8RequestEntity);

  ///set fatca w9
  @POST("/FatcaCrs/SetW9")
  Future<HttpResponse<ResponseEntity>> saveFatcaW9(
      @Body() SetFatcaW9RequestEntity setFatcaW9RequestEntity);

  @POST("/Auth/CheckIssuer")
  Future<HttpResponse<GetAllowedIssuerResponseEntity>> fetchAllowedIssuers(
      @Body() BaseRequest baseRequest);

  @POST("/Account/CheckCustomerStatus")
  Future<HttpResponse<CustomerStatusResponseEntity>> checkCustomerStatus(
      @Body() BaseRequest baseRequest);

  @POST("/CardTracking/GetCardApplications")
  Future<HttpResponse<GetCardApplicationResponseEntity>> getCardApplication(
      @Body() BaseRequest baseRequest);

  @POST("/CardTracking/GetLoanValues")
  Future<HttpResponse<GetLoanValuesResponseEntity>> getLoanValues(
      @Body() GetLoanValuesRequestEntity getLoanValuesRequestEntity);

  @POST("/CardTracking/ProccessLoanRequest")
  Future<HttpResponse<ProcessLoanResponseEntity>> processLoanRequest(
      @Body() ProcessLoanRequestEntity processLoanRequestEntity);

  @POST("/CardTracking/LinkCardStep")
  Future<HttpResponse<ResponseEntity>> linkCardStep(
      @Body() LinkCardStepRequestEntity linkCardStepRequestEntity);

  @POST("/CustomerDetails/DeleteProfileImage")
  Future<HttpResponse<ResponseEntity>> deleteProfileImage(
      @Body() BaseRequest baseRequest);

  @POST("/CustomerDetails/GetCustomerDocId")
  Future<HttpResponse<GetCustomerDocIdResponseEntity>> getCustomerDocId(
      @Body() BaseRequest baseRequest);

  @POST("/CustomerDetails/GetCusDocs")
  Future<HttpResponse<GetCustomerDocumentResponseEntity>> getCustomerDocument(
      @Body()
          GetCustomerDocumentRequestEntity getCustomerDocumentRequestEntity);

  @POST("/auth/GetCipherV1")
  Future<HttpResponse<GetCipherResponseEntity>> getCipher(
      @Body() GetCipherRequestEntity getCipherRequestEntity);

  @POST("/auth/AndroidLogin")
  Future<HttpResponse<ResponseEntity>> androidLogin(
      @Body() AndroidLoginRequestEntity androidLoginRequestEntity);

  @POST("/Auth/CheckForgetPasswordCred")
  Future<HttpResponse<CheckForgetPasswordResponseEntity>> checkForgetPassword(
      @Body()
          CheckForgetPasswordRequestEntity checkForgetPasswordRequestEntity);

  @POST("/Auth/ForgetPassword")
  Future<HttpResponse<ForgetPasswordResponseEntity>> resetPassword(
      @Body() ForgetPasswordRequestEntity forgetPasswordRequestEntity);

  @POST("/Auth/VerifyForgetPasswordOtp")
  Future<HttpResponse<VerifyForgetPasswordOtpResponseEntity>>
      verifyForgetPasswordOtp(
          @Body()
              VerifyForgetPasswordOtpRequestEntity
                  verifyForgetPasswordOtpRequestEntity);

  @POST("/transfer/PaymentActivityAPIV2")
  Future<HttpResponse<PaymentActivityResponseEntity>> getPaymentActivity(
      @Body() PaymentActivityRequestEntity paymentActivityRequestActivity);

  @POST("/auth/iphonelogin")
  Future<HttpResponse<LoginResponseEntity>> iphoneLogin(
      @Body() AndroidLoginRequestEntity androidLoginRequestEntity);

  @POST("/Auth/ChangeMobileNumber")
  Future<HttpResponse<ResponseEntity>> changeMyNumber(
      @Body() ChangeMyNumberRequestEntity changeMyNumberRequestEntity);

  @POST("/DebitCard/ChangePinVerify")
  Future<HttpResponse<ResponseEntity>> changePinVerify(
      @Body() BaseRequest baseRequest);

  @POST("/video/checkexistingcall")
  Future<HttpResponse<CheckExistingCallResponseEntity>> checkExistingCall(
      @Body() CheckExistingVideoCallRequest request);

  @POST("/video/genderStatus")
  Future<HttpResponse<CheckGenderResponseEntity>> checkGenderStatus(
      @Body() BaseRequest request);

  @POST("/video/RequestCallV1")
  Future<HttpResponse<RequestCallResponseEntity>> requestCall(
      @Body() RequestVideoCallRequest request);

  @POST("/video/GetTimeSlots")
  Future<HttpResponse<GetTimeSlotsResponseEntity>> getTimeSlots(
      @Body() GetTimeSlotsRequest request);

  ///schedule video call time
  @POST("/video/AddCall")
  Future<HttpResponse<ResponseEntity>> saveCustomerVideoCallScheduleTime(
      @Body()
          SaveCustomerScheduleTimeRequestEntity
              saveCustomerScheduleTimeRequestEntity);

  @POST("/video/GetCallStatus")
  Future<HttpResponse<VideoCallStatusResponseEntity>> getCallStatus(
      @Body() GetCallStatusRequest request);

  @POST("/DebitCard/RequestSuplementaryDebitCard")
  Future<HttpResponse<ResponseEntity>> applyDebitSupplementaryCard(
      @Body()
          ApplyDebitSupplementaryCardRequest
              applyDebitSupplementaryCardRequest);

  @POST("/Account/AccountActivity")
  Future<HttpResponse<ActivityResponseEntity>> getActivity(
      @Body() ActivityRequestEntity activityRequestEntity);

  @POST("/Auth/ResendOTP")
  Future<HttpResponse<ResponseEntity>> resendOtpDeviceChange(
      @Body()
          ResendOtpDeviceChangeRequestEntity
              resendOtpDeviceChangeRequestEntity);

  @POST("/auth/Sendotptoken")
  Future<HttpResponse<ResponseEntity>> sendOtpToken(
      @Body()
          SendOtpTokenDeviceChangeRequestEntity
              sendOtpTokenDeviceChangeRequestEntity);

  @POST("/Auth/SendotptokenEmail")
  Future<HttpResponse<ResponseEntity>> sendOtpTokenEmail(
      @Body() SendOtpTokenEmailRequestEntity sendOtpTokenEmailRequestEntity);

  @POST("/Auth/verifyDeviceChangeOtp")
  Future<HttpResponse<ResponseEntity>> verifyChangeDeviceOtp(
      @Body()
          VerifyDeviceChangeOtpRequestEntity
              verifyDeviceChangeOtpRequestEntity);

  @POST("/CardTracking/PayBackCreditCard")
  Future<HttpResponse<ResponseEntity>> payBackCreditCard(
      @Body() PayBackCreditCardRequestEntity payBackCreditCardRequestEntity);

  @POST("/AppVersion/currentversionPEV1")
  Future<HttpResponse<CurrentVersionResponseEntity>> checkVersionUpdate(
      @Body() CheckVersionUpdateRequest request);

  @POST("/CardTracking/GetSupCardApplications")
  Future<HttpResponse<SupplementaryCreditCardApplicationResponseEntity>>
      getSupplementaryCreditCardApplication(
          @Body() GetSupplementaryCreditCardApplicationRequestEntity request);

  @POST("/CardTracking/CreditSupCardReq")
  Future<HttpResponse<SupplementaryCreditCardRequestResponseEntity>>
      supplementaryCreditCardRequest(
          @Body() SupplementaryCreditCardRequestEntity request);

  @POST("/CardTracking/SuppSteptwo")
  Future<HttpResponse<ResponseEntity>> supplementaryCreditCardStepTwo(
      @Body() SupplementaryCreditCardStepTwoRequestEntity request);

  @POST("/CardTracking/SuppStepthree")
  Future<HttpResponse<ResponseEntity>> supplementaryCreditCardStepThree(
      @Body() SupplementaryCreditCardStepThreeRequestEntity request);

  @POST("/CardTracking/GetRelationShipList")
  Future<HttpResponse<CreditCardRelationshipResponseEntity>>
      getCreditCardRelationShipList(
          @Body() GetCreditCardRelationshipRequestEntity request);

  @POST("/DashBoard/CallStatusUpdate")
  Future<HttpResponse<ResponseEntity>> callStatusUpdate(
      @Body() CreditCardCallStatusUpdateRequest request);

  @POST("/DebitCard/ChangeMobileNumberVerify")
  Future<HttpResponse<ResponseEntity>> dcChangeLinkedMobileNumberVerify(
      @Body() DcChangeMobileNumberVerifyRequestEntity request);

  @POST("/DebitCard/ChangeMobileNumber")
  Future<HttpResponse<ResponseEntity>> dcChangeLinkedMobileNumber(
      @Body() DcChangeMobileNumberRequestEntity request);

  @POST("/CardTracking/ChangeMobileNumberVerify")
  Future<HttpResponse<ResponseEntity>> ccChangeLinkedMobileNumberVerify(
      @Body() CcChangeMobileNumberVerifyRequestEntity request);

  @POST("/CardTracking/ChangeMobileNumber")
  Future<HttpResponse<ResponseEntity>> ccChangeLinkedMobileNumber(
      @Body() CcChangeMobileNumberRequestEntity request);

  @POST("/DashBoard/GetAdPlaceholder")
  Future<HttpResponse<PlaceholderResponseEntity>> getPlaceholder(
      @Body() GetPlaceholderRequestEntity request);

  @POST("/CardTracking/UpdateSettlement")
  Future<HttpResponse<ResponseEntity>> updateSettlement(
      @Body() CcUpdateSettlementRequestEntity request);

  @POST("/CardTracking/GetLimit")
  Future<HttpResponse<GetCreditCardLimitResponseEntity>> getCreditCardLimit(
      @Body() CreditCardLimitRequestEntity request);

  @POST("/CardTracking/ReportLostCC")
  Future<HttpResponse<ResponseEntity>> reportLostStolenCC(
      @Body() ReportStolenCCRequestEntity reportStolenCCRequestEntity);

  @POST("/DebitCard/RemoveOrReApplySuppDebitCard")
  Future<HttpResponse<ResponseEntity>> removeOrReApplySupplementaryDebitCard(
      @Body()
          RemoveOrReApplySupplementaryDebitCardRequestEnity
              removeOrReApplySupplementaryDebitCardRequestEnity);
}

import 'package:data/entity/remote/ahwal/get_ahwal_details_request.dart';
import 'package:data/entity/remote/bank_smart/add_account_purpose_request.dart';
import 'package:data/entity/remote/bank_smart/create_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/save_fatca_information_request_entity.dart';
import 'package:data/entity/remote/kyc/kyc_status_request.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/check_user_name_mobile_request.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/fetch_countrylist_request.dart';
import 'package:data/entity/remote/user/login_user_request.dart';
import 'package:data/entity/remote/user/register_prospect_user_request.dart';
import 'package:data/entity/remote/user/save_country_residence_info_response_entity.dart';
import 'package:data/entity/remote/user/save_id_info_request.dart';
import 'package:data/entity/remote/user/save_id_info_response_entity.dart';
import 'package:data/entity/remote/user/save_job_details_response_entity.dart';
import 'package:data/entity/remote/user/save_job_info_request.dart';
import 'package:data/entity/remote/user/save_profile_information_request.dart';
import 'package:data/entity/remote/user/save_profile_status_response_entity.dart';
import 'package:data/entity/remote/user/save_residence_information_request.dart';
import 'package:data/entity/remote/user/verify_mobile_otp_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

//flutter pub run build_runner build
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST("http://192.168.181.2:2821/api/auth/CheckUserName")
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserName(
      @Body() CheckUserEmailRequest request);

  @POST("http://192.168.181.2:2821/api/auth/CheckUserNameMobile")
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserNameMobile(
      @Body() CheckUserNameMobileRequest checkUserNameMobileRequest);

  @POST("/auth/loginUser")
  Future<String> loginUser(@Body() LoginUserRequest loginUserRequest);

  @POST("/transfer/GetCountries")
  Future<String> fetchCountryList(
      @Body() FetchCountryListRequest fetchCountryListRequest);

  @POST("/auth/RegisterV2")
  Future<String> registerProspectUser(
      @Body() RegisterProspectUserRequest registerProspectUserRequest);

  @POST("/CustomerDetails/SaveIdInfo")
  Future<HttpResponse<SaveIdInfoResponseEntity>> saveIdInfo(
      @Body() SaveIdInfoRequest saveIdInfoRequest);

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

  @POST("/auth/VerifyMobileOtp")
  Future<bool> verifyMobileOtp(
      @Body() VerifyMobileOtpRequest verifyMobileOtpRequest);

  @POST("/kyc/getstatus")
  Future<String> checkKYCStatus(@Body() KYCStatusRequest kycStatusRequest);

  @POST("/idcard/CheckAhwal")
  Future<String> getAhwalDetails(
      @Body() GetAhwalDetailsRequest getAhwalDetailsRequest);

  @POST("/Banksmart/AddAccountPurpose")
  Future<String> addAccountPurpose(
      @Body() AddAccountPurposeRequest addAccountPurposeRequest);

  @POST("/FatcaCrs/get")
  Future<String> getFatcaQuestions(
      @Body() GetFatcaQuestionsRequestEntity getFatcaQuestionsRequestEntity);

  @POST("/FatcaCrs/set")
  Future<String> saveFatcaInformation(
      @Body()
          SaveFatcaInformationRequestEntity saveFatcaInformationRequestEntity);

  @POST("/BankSmart/GetAccount")
  Future<String> getAccount(
      @Body() GetAccountRequestEntity getAccountRequestEntity);

  @POST("/BankSmart/CreateAccount")
  Future<String> createAccount(
      @Body() CreateAccountRequestEntity createAccountRequestEntity);

  @POST("/BankSmart/GetAccountDetails")
  Future<String> getAccountDetails(
      @Body() GetAccountDetailsRequestEntity getAccountDetailsRequestEntity);
}

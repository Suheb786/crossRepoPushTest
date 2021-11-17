import 'package:data/entity/remote/ahwal/get_ahwal_details_request.dart';
import 'package:data/entity/remote/bank_smart/add_account_purpose_request.dart';
import 'package:data/entity/remote/kyc/kyc_status_request.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/check_user_name_mobile_request.dart';
import 'package:data/entity/remote/user/fetch_countrylist_request.dart';
import 'package:data/entity/remote/user/login_user_request.dart';
import 'package:data/entity/remote/user/register_prospect_user_request.dart';
import 'package:data/entity/remote/user/save_id_info_request.dart';
import 'package:data/entity/remote/user/save_job_info_request.dart';
import 'package:data/entity/remote/user/save_profile_information_request.dart';
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

  @POST("/auth/CheckUserName")
  Future<String> checkUserName(@Body() CheckUserEmailRequest request);

  @POST("/auth/loginUser")
  Future<String> loginUser(@Body() LoginUserRequest loginUserRequest);

  @POST("/auth​/CheckUserNameMobile")
  Future<String> checkUserNameMobile(
      @Body() CheckUserNameMobileRequest checkUserNameMobileRequest);

  @POST("/transfer/GetCountries")
  Future<String> fetchCountryList(
      @Body() FetchCountryListRequest fetchCountryListRequest);

  @POST("/auth/RegisterV2")
  Future<String> registerProspectUser(
      @Body() RegisterProspectUserRequest registerProspectUserRequest);

  @POST("/CustomerDetails/SaveIdInfo")
  Future<String> saveIdInfo(@Body() SaveIdInfoRequest saveIdInfoRequest);

  @POST("/AddFeilds/SaveJobDetails")
  Future<String> saveJobInformation(
      @Body() SaveJobInfoRequest saveJobInfoRequest);

  @POST("/AddFeilds/SaveProfileStatus")
  Future<String> saveProfileInformation(
      @Body() SaveProfileInformationRequest saveProfileInformationRequest);

  @POST("/AddFeilds/SaveCountryResidenceInfo")
  Future<String> saveResidenceInformation(
      @Body() SaveResidenceInformationRequest saveResidenceInformationRequest);

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
}

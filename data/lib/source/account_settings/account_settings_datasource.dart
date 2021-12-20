import 'package:data/entity/remote/accountsettings/profile_changed_success_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_details_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class AccountSettingsRemoteDs {
  Future<HttpResponse<ProfileDetailsResponseEntity>> getAccountDetails();

  Future<HttpResponse<ResponseEntity>> updateProfileImage(
      {required String filePath});

  Future<HttpResponse<ResponseEntity>> changeEmail({required String email});

  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeEmail(
      {required String otp});

  Future<HttpResponse<ResponseEntity>> changeMobile({required String mobile});

  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeMobile(
      {required String otp});

  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword});
}

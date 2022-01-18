import 'package:data/entity/remote/forget_password/check_forget_password_response_entity.dart';
import 'package:data/entity/remote/forget_password/forget_password_response_entity.dart';
import 'package:data/entity/remote/forget_password/verify_forget_password_otp_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class ForgetPasswordRemoteDs {
  Future<HttpResponse<CheckForgetPasswordResponseEntity>> checkForgetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId});

  Future<HttpResponse<ForgetPasswordResponseEntity>> resetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId,
      required String? createPassword,
      required String? confirmPassword});

  Future<HttpResponse<VerifyForgetPasswordOtpResponseEntity>>
      verifyForgetPasswordOtp(
          {required String? email,
          required String? expiryDate,
          required String? nationalId,
          required String? createPassword,
          required String? confirmPassword,
          required String? otp});
}

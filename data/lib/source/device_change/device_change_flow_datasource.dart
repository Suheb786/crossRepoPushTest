import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class ChangeDeviceRemoteDS {
  Future<HttpResponse<ResponseEntity>> sendOtpTokenEmail();

  Future<HttpResponse<ResponseEntity>> sendOtpToken();

  Future<HttpResponse<ResponseEntity>> verifyChangeDeviceOtp(
      {required String otp, required String firebaseToken});

  Future<HttpResponse<ResponseEntity>> resendOtpDeviceChange();
}

import 'package:data/entity/remote/forget_password/check_forget_password_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class ForgetPasswordRemoteDs {
  Future<HttpResponse<CheckForgetPasswordResponseEntity>> checkForgetPassword(
      {required String? email,
      required String? expiryDate,
      required String? nationalId});
}

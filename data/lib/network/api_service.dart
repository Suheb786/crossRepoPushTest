import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/login_user_request.dart';
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
}

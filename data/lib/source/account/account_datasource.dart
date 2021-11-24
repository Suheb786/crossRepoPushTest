import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class AccountRemoteDS {
  Future<HttpResponse<CheckVideoCallStatusResponseEntity>> checkVideoCallStatus(
      {bool getToken});
}

abstract class AccountLocalDS {}

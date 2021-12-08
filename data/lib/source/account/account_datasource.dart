import 'package:data/entity/remote/account/check_agent_status_response_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_response_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:data/entity/remote/account/doc_status_response_entity.dart';
import 'package:data/entity/remote/account/save_customer_schedule_time_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class AccountRemoteDS {
  Future<HttpResponse<CheckVideoCallStatusResponseEntity>> checkVideoCallStatus(
      {bool getToken});

  Future<HttpResponse<CheckOtherNationalityStatusResponseEntity>>
      checkOtherNationalityStatus({bool getToken});

  Future<HttpResponse<DocStatusResponseEntity>> docStatus();

  Future<HttpResponse<CheckAgentStatusResponseEntity>> checkAgentStatus();

  Future<HttpResponse<SaveCustomerScheduleTimeResponseEntity>>
      saveCustomerVideoCallScheduleTime(
          {String scheduleDate, String scheduleTime});
}

abstract class AccountLocalDS {}

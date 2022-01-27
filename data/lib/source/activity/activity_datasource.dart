import 'package:data/entity/remote/activity/activity_response_entity.dart';
import 'package:retrofit/dio.dart';

abstract class ActivityRemoteDs {
  Future<HttpResponse<ActivityResponseEntity>> getActivity(
      num noOfDays, String isDebit);
}

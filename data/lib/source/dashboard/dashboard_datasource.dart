import 'package:data/entity/remote/dashboard/atms_response_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_data_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class DashboardRemoteDs {
  Future<HttpResponse<DashboardDataResponseEntity>> getDashboardData();

  Future<HttpResponse<AtmsResponseEntity>> getAtms();
}

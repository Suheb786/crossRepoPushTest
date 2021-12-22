import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/dashboard/get_atms/get_atms_response.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';

abstract class DashboardRepository {
  Future<Either<NetworkError, GetDashboardDataResponse>> getDashboardData();

  Future<Either<NetworkError, GetATMResponse>> getAtms();
}

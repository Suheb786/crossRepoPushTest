import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/dashboard/dashboard_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/dashboard/get_atms/get_atms_response.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/model/dashboard/get_placeholder/get_placeholder_response.dart';
import 'package:domain/repository/dashboard/dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardRemoteDs _remoteDs;

  DashboardRepositoryImpl(this._remoteDs);

  @override
  Future<Either<NetworkError, GetATMResponse>> getAtms() async {
    final result = await safeApiCall(
      _remoteDs.getAtms(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetDashboardDataResponse>>
      getDashboardData() async {
    final result = await safeApiCall(
      _remoteDs.getDashboardData(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetPlaceholderResponse>> getPlaceholder(
      {int? placeholderId}) async {
    final result = await safeApiCall(
      _remoteDs.getPlaceholder(placeholderId: placeholderId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}

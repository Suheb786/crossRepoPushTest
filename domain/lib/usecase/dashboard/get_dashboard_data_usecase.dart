import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/repository/dashboard/dashboard_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetDashboardDataUseCase
    extends BaseUseCase<NetworkError, GetDashboardDataUseCaseParams, GetDashboardDataResponse> {
  final DashboardRepository _repository;

  GetDashboardDataUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetDashboardDataResponse>> execute(
      {required GetDashboardDataUseCaseParams params}) {
    return _repository.getDashboardData();
  }
}

class GetDashboardDataUseCaseParams extends Params {
  GetDashboardDataUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

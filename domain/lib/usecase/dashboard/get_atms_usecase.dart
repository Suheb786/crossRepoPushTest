import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/dashboard/get_atms/get_atms_response.dart';
import 'package:domain/repository/dashboard/dashboard_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAtmsUseCase extends BaseUseCase<NetworkError, GetAtmsUseCaseParams, GetATMResponse> {
  final DashboardRepository _repository;

  GetAtmsUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetATMResponse>> execute({required GetAtmsUseCaseParams params}) {
    return _repository.getAtms();
  }
}

class GetAtmsUseCaseParams extends Params {
  GetAtmsUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

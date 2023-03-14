import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/repository/apple_pay/apple_pay_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAllCardListUseCase
    extends BaseUseCase<NetworkError, GetAllCardListUseCaseParams, GetDashboardDataResponse> {
  final ApplePayRepository _repository;

  GetAllCardListUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetDashboardDataResponse>> execute(
      {required GetAllCardListUseCaseParams params}) {
    return _repository.getAllCardListUseCase();
  }
}

class GetAllCardListUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

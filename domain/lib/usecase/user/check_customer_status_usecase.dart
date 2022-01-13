import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckCustomerStatusUseCase extends BaseUseCase<NetworkError,
    CheckCustomerStatusUseCaseParams, CustomerStatus> {
  final UserRepository _repository;

  CheckCustomerStatusUseCase(this._repository);

  @override
  Future<Either<NetworkError, CustomerStatus>> execute(
      {required CheckCustomerStatusUseCaseParams params}) {
    return _repository.checkCustomerStatus();
  }
}

class CheckCustomerStatusUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

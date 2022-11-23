import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ChangeMyNumberUseCase extends BaseUseCase<NetworkError, ChangeMyNumberUseCaseParams, bool> {
  final UserRepository _repository;

  ChangeMyNumberUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ChangeMyNumberUseCaseParams params}) {
    return _repository.changeMyNumber(params.mobileNumber, params.countryCode);
  }
}

class ChangeMyNumberUseCaseParams extends Params {
  final String mobileNumber;
  final String countryCode;

  ChangeMyNumberUseCaseParams({required this.mobileNumber, required this.countryCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

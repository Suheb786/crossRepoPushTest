import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/check_username_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckUserNameMobileUseCase extends BaseUseCase<NetworkError,
    CheckUserNameMobileUseCaseParams, CheckUsernameResponse> {
  final UserRepository _repository;

  CheckUserNameMobileUseCase(this._repository);

  @override
  Future<Either<NetworkError, CheckUsernameResponse>> execute(
      {required CheckUserNameMobileUseCaseParams params}) {
    return _repository.checkUserNameMobile(
        mobileNumber: params.mobileNumber, countryCode: params.countryCode);
  }
}

class CheckUserNameMobileUseCaseParams extends Params {
  final String mobileNumber;
  final String countryCode;

  CheckUserNameMobileUseCaseParams(
      {required this.mobileNumber, required this.countryCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

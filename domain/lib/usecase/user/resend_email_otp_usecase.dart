import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

import '../../error/network_error.dart';
import '../../repository/user/user_repository.dart';

class ResendEmailOTPUseCase extends BaseUseCase<NetworkError, ResendEmailOTPUseCaseParams, bool> {
  final UserRepository _repository;

  ResendEmailOTPUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ResendEmailOTPUseCaseParams params}) {
    return _repository.sendEmailOTP(email: params.emailAddress ?? '', password: params.password ?? '');
  }
}

class ResendEmailOTPUseCaseParams extends Params {
  final String password;
  final String emailAddress;

  ResendEmailOTPUseCaseParams({required this.password, required this.emailAddress});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

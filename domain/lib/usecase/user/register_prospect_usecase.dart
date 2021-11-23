import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RegisterProspectUseCase
    extends BaseUseCase<NetworkError, RegisterProspectUseCaseParams, String> {
  final UserRepository _repository;

  RegisterProspectUseCase(this._repository);

  @override
  Future<Either<NetworkError, String>> execute(
      {required RegisterProspectUseCaseParams params}) {
    return _repository.registerProspectUser(
        mobileNumber: params.mobileNumber,
        countryName: params.countryName,
        userName: params.userName,
        password: params.password,
        confirmPassword: params.confirmPassword,
        email: params.email);
  }
}

class RegisterProspectUseCaseParams extends Params {
  final String? countryName;
  final String? email;
  final String? mobileNumber;
  final String? password;
  final String? confirmPassword;
  final String? userName;

  RegisterProspectUseCaseParams(
      {this.countryName,
      this.email,
      this.mobileNumber,
      this.password,
      this.confirmPassword,
      this.userName});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

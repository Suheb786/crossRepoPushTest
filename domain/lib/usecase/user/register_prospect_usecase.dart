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
        companyId: params.companyId,
        mobileNumber: params.mobileNumber,
        countryName: params.countryName,
        userName: params.userName,
        password: params.password,
        confirmPassword: params.confirmPassword,
        fireBaseToken: params.fireBaseToken,
        getToken: params.getToken,
        email: params.email,
        uniqueId: params.uniqueId,
        platform: params.platform,
        languageCode: params.languageCode,
        vKeySessionId: params.vKeySessionId);
  }
}

class RegisterProspectUseCaseParams extends Params {
  final String? countryName;
  final String? languageCode;
  final String? uniqueId;
  final int? companyId;
  final String? email;
  final String? mobileNumber;
  final String? password;
  final String? confirmPassword;
  final String? userName;
  final String? fireBaseToken;
  final String? vKeySessionId;
  final String? platform;
  final bool? getToken;

  RegisterProspectUseCaseParams(
      {this.countryName,
      this.languageCode,
      this.uniqueId,
      this.companyId,
      this.email,
      this.mobileNumber,
      this.password,
      this.confirmPassword,
      this.userName,
      this.fireBaseToken,
      this.vKeySessionId,
      this.platform,
      this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

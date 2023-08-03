import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreateCliqIdOtpUseCase extends BaseUseCase<NetworkError, CreateCliqIdOtpParams, CreateCliqOtp> {
  final CliqRepository _cliqRepository;

  CreateCliqIdOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, CreateCliqOtp>> execute({required CreateCliqIdOtpParams params}) {
    return _cliqRepository.createCliqIdOtp(
        accountNumber: params.accountNumber,
        isAlias: params.isAlias,
        aliasValue: params.aliasValue,
        getToken: params.getToken);
  }
}

class CreateCliqIdOtpParams extends Params {
  final String accountNumber;
  final bool isAlias;
  final String aliasValue;
  final bool getToken;

  CreateCliqIdOtpParams(
      {required this.accountNumber, required this.isAlias, required this.aliasValue, required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

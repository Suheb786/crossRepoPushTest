import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EditCliqOtpUseCase extends BaseUseCase<NetworkError, EditCliqOtpUseCaseParams, EditCliqOtp> {
  final CliqRepository _cliqRepository;

  EditCliqOtpUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, EditCliqOtp>> execute({required EditCliqOtpUseCaseParams params}) {
    return _cliqRepository.editCliqIdOtp(
        aliasId: params.aliasId,
        isAlias: params.isAlias,
        aliasValue: params.aliasValue,
        getToken: params.getToken);
  }
}

class EditCliqOtpUseCaseParams extends Params {
  final String aliasId;
  final bool isAlias;
  final String aliasValue;
  final bool getToken;

  EditCliqOtpUseCaseParams(
      {required this.aliasId, required this.isAlias, required this.aliasValue, this.getToken = true});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

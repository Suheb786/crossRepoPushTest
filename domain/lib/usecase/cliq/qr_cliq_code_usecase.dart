import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class QrClipCodeUsecase
    extends BaseUseCase<NetworkError, QrClipCodeUsecaseParams, bool> {
  final CliqRepository _cliqRepository;

  QrClipCodeUsecase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required QrClipCodeUsecaseParams params}) {
    return _cliqRepository.qRCliqCode(
        code: params.code, getToken: params.getToken);
  }
}

class QrClipCodeUsecaseParams extends Params {
  final String code;
  final bool getToken;

  QrClipCodeUsecaseParams({
    required this.code,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

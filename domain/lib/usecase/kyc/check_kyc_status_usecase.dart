import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/repository/kyc/kyc_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckKYCStatusUseCase extends BaseUseCase<NetworkError, CheckKYCStatusUseCaseParams, CheckKycResponse> {
  final KYCRepository _repository;

  CheckKYCStatusUseCase(this._repository);

  @override
  Future<Either<NetworkError, CheckKycResponse>> execute({required CheckKYCStatusUseCaseParams params}) {
    return _repository.checkKYCStatus();
  }
}

class CheckKYCStatusUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

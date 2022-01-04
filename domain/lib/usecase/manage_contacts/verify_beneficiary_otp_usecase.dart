import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class VerifyBeneficiaryOtpUseCase
    extends BaseUseCase<NetworkError, VerifyBeneficiaryOtpUseCaseParams, bool> {
  final ManageContactRepository _repository;

  VerifyBeneficiaryOtpUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required VerifyBeneficiaryOtpUseCaseParams params}) {
    return _repository.verifyBeneficiaryOtp(
        type: params.type, otpCode: params.otpCode);
  }
}

class VerifyBeneficiaryOtpUseCaseParams extends Params {
  final String type;
  final String otpCode;

  VerifyBeneficiaryOtpUseCaseParams(
      {required this.type, required this.otpCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

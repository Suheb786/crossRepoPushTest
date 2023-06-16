import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/manage_contacts/send_otp_add_benificiary_response.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../repository/manage_contact/manage_contact_repository.dart';

class ResendOTPAddBeneficiaryUseCase
    extends BaseUseCase<BaseError, AddBeneficiaryOTPUseCaseParams, SendOtpAddBeneficiaryResponse> {
  final ManageContactRepository _manageContactRepository;

  ResendOTPAddBeneficiaryUseCase(this._manageContactRepository);

  @override
  Future<Either<BaseError, SendOtpAddBeneficiaryResponse>> execute(
      {required AddBeneficiaryOTPUseCaseParams params}) {
    return _manageContactRepository.sendOTPAddBeneficiary();
  }
}

class AddBeneficiaryOTPUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

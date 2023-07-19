import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/manage_contacts/send_otp_add_benificiary_response.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../repository/manage_contact/manage_contact_repository.dart';
import '../../utils/validator.dart';

class AddBeneficiaryOTPUseCase
    extends BaseUseCase<BaseError, AddBeneficiaryOTPUseCaseParams, SendOtpAddBeneficiaryResponse> {
  final ManageContactRepository _manageContactRepository;

  AddBeneficiaryOTPUseCase(this._manageContactRepository);

  @override
  Future<Either<BaseError, SendOtpAddBeneficiaryResponse>> execute(
      {required AddBeneficiaryOTPUseCaseParams params}) {
    return _manageContactRepository.sendOTPAddBeneficiary();
  }
}

class AddBeneficiaryOTPUseCaseParams extends Params {
  final String name;
  final String fullName;
  final String beneficiaryType;
  final String purpose;
  final String purposeDetail;
  final String IBANAccountNoMobileNoAlias;

  AddBeneficiaryOTPUseCaseParams({
    required this.name,
    required this.fullName,
    required this.beneficiaryType,
    required this.purpose,
    required this.purposeDetail,
    required this.IBANAccountNoMobileNoAlias,
  });

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(name.trim())) {
      return Left(
          AppError(cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.EMPTY_NICKNAME_VALUE));
    } else if (name.length > 50) {
      return Left(AppError(
          cause: Exception(),
          error: ErrorInfo(message: ""),
          type: ErrorType.NICKNAME_LENGTH_SHOULD_NOT_BE_GREATER_THAN_50));
    } else if (Validator.isEmpty(IBANAccountNoMobileNoAlias)) {
      return Left(AppError(
          cause: Exception(),
          error: ErrorInfo(message: ""),
          type: ErrorType.PLEASE_ENTER_IBAN_ACCOUNT_MOBILE_ALIAS));
    } else if (Validator.isEmpty(purpose)) {
      return Left(AppError(cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.EMPTY_PURPOSE));
    } else if (Validator.isEmpty(purposeDetail)) {
      return Left(
          AppError(cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.EMPTY_PURPOSE_DETAIL));
    }

    return Right(true);
  }
}

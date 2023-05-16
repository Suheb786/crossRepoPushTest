import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

import '../../repository/manage_contact/manage_contact_repository.dart';

class UpdateContactUseCase extends BaseUseCase<BaseError, UpdateContactUseCaseParams, bool> {
  final ManageContactRepository _manageContactRepository;

  UpdateContactUseCase(this._manageContactRepository);

  @override
  Future<Either<BaseError, bool>> execute({required UpdateContactUseCaseParams params}) {
    return _manageContactRepository.updateContact(
        beneficiaryDetailId: '',
        nickName: params.name,
        fullName: '',
        emailAddress: params.emailAddress,
        userId: '',
        identifier: params.IBANACCOUNTNOMobileNoALIAS,
        isFromMobile: '');
  }
}

class UpdateContactUseCaseParams extends Params {
  final String name;
  final String emailAddress;
  final String IBANACCOUNTNOMobileNoALIAS;

  UpdateContactUseCaseParams({
    required this.name,
    required this.emailAddress,
    required this.IBANACCOUNTNOMobileNoALIAS,
  });

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(name)) {
      return Left(AppError(
          cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.PLEASE_ENTER_CONTACT_NAME));
    } else if (Validator.isEmpty(emailAddress)) {
      return Left(AppError(cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.INVALID_EMAIL));
    } else if (Validator.isEmpty(IBANACCOUNTNOMobileNoALIAS)) {
      return Left(AppError(
          cause: Exception(),
          error: ErrorInfo(message: ""),
          type: ErrorType.PLEASE_ENTER_IBAN_ACCOUNT_MOBILE_ALIAS));
    }

    return Right(true);
  }
}

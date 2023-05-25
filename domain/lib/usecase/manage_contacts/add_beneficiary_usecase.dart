import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

import '../../repository/manage_contact/manage_contact_repository.dart';

class AddBeneficiaryUseCase extends BaseUseCase<BaseError, AddContactIBANuseCaseParams, bool> {
  final ManageContactRepository _manageContactRepository;

  AddBeneficiaryUseCase(this._manageContactRepository);

  @override
  Future<Either<BaseError, bool>> execute({required AddContactIBANuseCaseParams params}) {
    /*return _manageContactRepository.addContact(
        nickName: params.name,
        fullName: '',
        emailAddress: params.emailAddress,
        avatarImage: '',
        isFav: false,
        userId: '',
        identifier: params.IBANACCOUNTNOMobileNoALIAS,
        isFromMobile: '');*/
    return Future.value(Right(true));
  }
}

class AddContactIBANuseCaseParams extends Params {
  final String name;
  final String purpose;
  final String purposeDetail;
  final String IBANAccountNoMobileNoAlias;

  AddContactIBANuseCaseParams({
    required this.name,
    required this.purpose,
    required this.purposeDetail,
    required this.IBANAccountNoMobileNoAlias,
  });

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(name)) {
      return Left(AppError(
          cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.PLEASE_ENTER_CONTACT_NAME));
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

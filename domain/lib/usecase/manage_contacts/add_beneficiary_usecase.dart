import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../repository/manage_contact/manage_contact_repository.dart';

class AddBeneficiaryUseCase extends BaseUseCase<BaseError, AddContactIBANuseCaseParams, bool> {
  final ManageContactRepository _manageContactRepository;

  AddBeneficiaryUseCase(this._manageContactRepository);

  @override
  Future<Either<BaseError, bool>> execute({required AddContactIBANuseCaseParams params}) {
     return _manageContactRepository.addBeneficiary(
        nickName: params.name,
        fullName: params.fullName,
        avatarImage: '',
        beneficiaryType: params.beneficiaryType,
        isFavourite: false,
        userId: '',
        identifier: params.IBANAccountNoMobileNoAlias,
        isFromMobile: true,
        detCustomerType: params.beneficiaryType,
        alias: '',
        addressLine1: '',
        addressLine2: '',
        addressLine3: '',
        addressLine4: '',
        limit: 0,
        IFSCCode: '',
        routingNo: '',
        sortCode: '',
        purposeType: '',
        purpose: params.purposeDetail,
        purposeDetails: '',
        purposeParent: '',
        purposeParentDetails: '',
        OTPCode: params.otp);
  }
}

class AddContactIBANuseCaseParams extends Params {
  final String name;
  final String fullName;
  final String beneficiaryType;
  final String purpose;
  final String purposeDetail;
  final String IBANAccountNoMobileNoAlias;
  final String otp;

  AddContactIBANuseCaseParams({
    required this.name,
    required this.fullName,
    required this.beneficiaryType,
    required this.purpose,
    required this.purposeDetail,
    required this.IBANAccountNoMobileNoAlias,
    required this.otp,
  });

  @override
  Either<AppError, bool> verify() {
    if (otp.isEmpty || otp.length < 6) {
      return Left(AppError(cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.INVALID_OTP));
    }

    return Right(true);
  }
}

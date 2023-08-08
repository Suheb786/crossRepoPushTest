import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class BeneficiaryContactUseCase
    extends BaseUseCase<NetworkError, BeneficiaryContactUseCaseParams, BeneficiaryContact> {
  final ManageContactRepository _repository;

  BeneficiaryContactUseCase(this._repository);

  @override
  Future<Either<NetworkError, BeneficiaryContact>> execute(
      {required BeneficiaryContactUseCaseParams params}) {
    return _repository.beneficiaryContacts(
      isFromMobile: params.isFromMobile,
    );
  }
}

class BeneficiaryContactUseCaseParams extends Params {
  final bool isFromMobile;

  BeneficiaryContactUseCaseParams(
    this.isFromMobile,
  );

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ContactDetailUseCase extends BaseUseCase<NetworkError, ContactDetailUseCaseParams, bool> {
  final ManageContactRepository _repository;

  ContactDetailUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ContactDetailUseCaseParams params}) {
    return _repository.contactDetail(
        beneficiaryDetailId: params.beneficiaryDetailId, isFromMobile: params.isFromMobile);
  }
}

class ContactDetailUseCaseParams extends Params {
  final String beneficiaryDetailId;
  final bool isFromMobile;

  ContactDetailUseCaseParams({required this.beneficiaryDetailId, required this.isFromMobile});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

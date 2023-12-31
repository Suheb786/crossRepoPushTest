import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RemoveBeneficiaryProfileImageUseCase
    extends BaseUseCase<NetworkError, RemoveBeneficiaryProfileImageUseCaseParams, bool> {
  final ManageContactRepository _repository;

  RemoveBeneficiaryProfileImageUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required RemoveBeneficiaryProfileImageUseCaseParams params}) {
    return _repository.removeAvatar(beneficiaryDetailId: params.beneficiaryId, beneType: params.beneType);
  }
}

class RemoveBeneficiaryProfileImageUseCaseParams extends Params {
  final String beneficiaryId;
  final String beneType;

  RemoveBeneficiaryProfileImageUseCaseParams({required this.beneficiaryId, required this.beneType});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

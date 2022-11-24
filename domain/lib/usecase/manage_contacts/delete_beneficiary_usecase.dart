import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DeleteBeneficiaryUseCase extends BaseUseCase<NetworkError, DeleteBeneficiaryUseCaseParams, bool> {
  final ManageContactRepository _repository;

  DeleteBeneficiaryUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required DeleteBeneficiaryUseCaseParams params}) {
    return _repository.deleteBeneficiary(beneficiaryId: params.beneficiaryId);
  }
}

class DeleteBeneficiaryUseCaseParams extends Params {
  final String beneficiaryId;

  DeleteBeneficiaryUseCaseParams({required this.beneficiaryId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

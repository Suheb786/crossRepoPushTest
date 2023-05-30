import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UpdateBeneficiaryUseCase extends BaseUseCase<NetworkError, UpdateBeneficiaryUseCaseParams, bool> {
  final ManageContactRepository _repository;

  UpdateBeneficiaryUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required UpdateBeneficiaryUseCaseParams params}) {
    return _repository.updateBeneficiary(
        beneficiaryId: params.beneficiaryId,
        nickName: params.nickName);
  }
}

class UpdateBeneficiaryUseCaseParams extends Params {
  final String beneficiaryId;
  final String nickName;

  UpdateBeneficiaryUseCaseParams(
      {required this.beneficiaryId,
      required this.nickName});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

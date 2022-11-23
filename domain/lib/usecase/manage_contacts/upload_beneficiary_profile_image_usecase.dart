import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UploadBeneficiaryProfileImageUseCase
    extends BaseUseCase<NetworkError, UploadBeneficiaryProfileImageUseCaseParams, bool> {
  final ManageContactRepository _repository;

  UploadBeneficiaryProfileImageUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required UploadBeneficiaryProfileImageUseCaseParams params}) {
    return _repository.uploadBeneficiaryImage(beneficiaryId: params.beneficiaryId, filePath: params.filePath);
  }
}

class UploadBeneficiaryProfileImageUseCaseParams extends Params {
  final String beneficiaryId;
  final String filePath;

  UploadBeneficiaryProfileImageUseCaseParams({required this.beneficiaryId, required this.filePath});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

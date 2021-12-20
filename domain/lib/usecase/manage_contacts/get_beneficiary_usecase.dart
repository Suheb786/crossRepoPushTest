import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetBeneficiaryUseCase
    extends BaseUseCase<NetworkError, GetBeneficiaryUseCaseParams, bool> {
  final ManageContactRepository _repository;

  GetBeneficiaryUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required GetBeneficiaryUseCaseParams params}) {
    return _repository.getBeneficiaries();
  }
}

class GetBeneficiaryUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

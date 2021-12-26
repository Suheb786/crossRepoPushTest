import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AddRequestMoneyContactUseCase extends BaseUseCase<NetworkError,
    AddRequestMoneyContactUseCaseParams, GetBeneficiaryListResponse> {
  final ManageContactRepository _repository;

  AddRequestMoneyContactUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetBeneficiaryListResponse>> execute(
      {required AddRequestMoneyContactUseCaseParams params}) {
    return _repository.getBeneficiaries();
  }
}

class AddRequestMoneyContactUseCaseParams extends Params {
  AddRequestMoneyContactUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

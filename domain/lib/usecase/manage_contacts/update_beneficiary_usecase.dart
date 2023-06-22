import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../constants/error_types.dart';
import '../../model/base/error_info.dart';
import '../../utils/validator.dart';

class UpdateBeneficiaryUseCase extends BaseUseCase<NetworkError, UpdateBeneficiaryUseCaseParams, bool> {
  final ManageContactRepository _repository;

  UpdateBeneficiaryUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required UpdateBeneficiaryUseCaseParams params}) {
    return _repository.updateBeneficiary(
        beneficiaryId: params.beneficiaryId, nickName: params.nickName.trim(), beneType: params.beneType);
  }
}

class UpdateBeneficiaryUseCaseParams extends Params {
  final String beneficiaryId;
  final String beneType;
  final String nickName;

  UpdateBeneficiaryUseCaseParams(
      {required this.beneficiaryId, required this.beneType, required this.nickName});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(nickName.trim())) {
      return Left(
          AppError(cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.EMPTY_NICKNAME_VALUE));
    } else if (nickName.length > 50) {
      return Left(AppError(
          cause: Exception(),
          error: ErrorInfo(message: ""),
          type: ErrorType.NICKNAME_LENGTH_SHOULD_NOT_BE_GREATER_THAN_50));
    }
    return Right(true);
  }
}

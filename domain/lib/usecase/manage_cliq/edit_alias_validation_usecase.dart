import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import 'package:domain/utils/validator.dart';

class EditAliasValidationUseCase extends BaseUseCase<NetworkError, EditAliasValidationUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required EditAliasValidationUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EditAliasValidationUseCaseParams extends Params {
  final String initialAliasValue;
  final String editAlias;
  final bool isSelected;

  EditAliasValidationUseCaseParams({
    required this.initialAliasValue,
    required this.editAlias,
    required this.isSelected,
  });

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(editAlias)) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_ALIAS, cause: Exception()));
    } else if (editAlias.length < 3) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_ALIAS_LENGTH, cause: Exception()));
    } else if (isSelected == false) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.AGREE_TO_THE_TERM_AND_CONDITION,
          cause: Exception()));
    } else if (initialAliasValue == editAlias) {
      return Left(AppError(
          cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.THIS_ALIAS_ALREADY_EXISTS));
    }
    return Right(true);
  }
}

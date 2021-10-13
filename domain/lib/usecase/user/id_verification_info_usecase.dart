import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/material.dart';

class IdVerificationInfoUseCase extends BaseUseCase<LocalError, IdVerificationInfoUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute({required IdVerificationInfoUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class IdVerificationInfoUseCaseParams extends Params {
  bool? isRetrieveConditionChecked;

  IdVerificationInfoUseCaseParams({required this.isRetrieveConditionChecked});

  @override
  Either<AppError, bool> verify() {
    if(!isRetrieveConditionChecked!) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.CONDITION_NOT_CHECKED,
          cause: Exception()));
    }
    return Right(true);
  }
}
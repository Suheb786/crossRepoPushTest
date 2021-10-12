import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
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
  bool isChecked;

  IdVerificationInfoUseCaseParams({required this.isChecked});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
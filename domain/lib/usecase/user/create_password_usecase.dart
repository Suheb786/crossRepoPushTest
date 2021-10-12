import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/material.dart';

class CreatePasswordUseCase extends BaseUseCase<LocalError, CreatePasswordUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute({required CreatePasswordUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CreatePasswordUseCaseParams extends Params {
  final String createPassword;
  final String confirmPassword;

  CreatePasswordUseCaseParams({required this.createPassword, required this.confirmPassword});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
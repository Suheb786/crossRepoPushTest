import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/material.dart';

class AgentSelectionUseCase
    extends BaseUseCase<LocalError, AgentSelectionUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required AgentSelectionUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class AgentSelectionUseCaseParams extends Params {
  BuildContext? context;

  AgentSelectionUseCaseParams({this.context});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

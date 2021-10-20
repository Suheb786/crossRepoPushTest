import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/cupertino.dart';

class ProductSelectorUseCase
    extends BaseUseCase<LocalError, ProductSelectorUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required ProductSelectorUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class ProductSelectorUseCaseParams extends Params {
  final BuildContext? context;

  ProductSelectorUseCaseParams({this.context});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

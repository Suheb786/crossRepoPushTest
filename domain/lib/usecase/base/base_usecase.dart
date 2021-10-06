import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/widgets.dart';

abstract class BaseUseCase<E extends BaseError, P extends Params, T> {
  Future<Either<E, T>> execute({@required P params});
}

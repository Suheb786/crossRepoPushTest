import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';

abstract class Params {
  Either<AppError, bool> verify();
}

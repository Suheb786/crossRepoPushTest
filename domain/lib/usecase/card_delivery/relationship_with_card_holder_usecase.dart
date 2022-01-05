import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class RelationshipWithCardholderUseCase extends BaseUseCase<NetworkError,
    RelationshipWithCardholderUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required RelationshipWithCardholderUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class RelationshipWithCardholderUseCaseParams extends Params {
  final String relationship;

  RelationshipWithCardholderUseCaseParams({this.relationship: ""});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(relationship)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_RELATIONSHIP,
          cause: Exception()));
    }
    return Right(true);
  }
}

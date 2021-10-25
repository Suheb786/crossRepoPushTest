import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class TaxationDetailsUseCase
    extends BaseUseCase<LocalError, TaxationDetailsUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute(
      {required TaxationDetailsUseCaseParams params}) {
    return Future.value(Right(false));
  }
}

class TaxationDetailsUseCaseParams extends Params {
  final String? relationShipPEP;
  final String? personName;
  final String? personRole;
  final bool isPEP;
  final bool declarationSelected;

  TaxationDetailsUseCaseParams(
      {this.relationShipPEP,
      this.personName,
      this.personRole,
      required this.isPEP,
      required this.declarationSelected});

  @override
  Either<AppError, bool> verify() {
    if (isPEP) {
      if (relationShipPEP!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_RELATIONSHIP,
            cause: Exception()));
      } else if (personName!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PERSON_NAME,
            cause: Exception()));
      } else if (personRole!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PERSON_ROLE,
            cause: Exception()));
      }
    } else if (!declarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_DECLARATION_SELECTION,
          cause: Exception()));
    }
    return Right(true);
  }
}

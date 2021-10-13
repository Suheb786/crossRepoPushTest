import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmDetailUseCase extends BaseUseCase<LocalError, ConfirmDetailUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute({required ConfirmDetailUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class ConfirmDetailUseCaseParams extends Params {
  final String? name;
  final String? idNumber;
  final String? dateOfBirth;
  final String? nationality;
  final String? expiryDate;
  final String? gender;

  ConfirmDetailUseCaseParams(
      {required this.name,
      required this.idNumber,
      required this.dateOfBirth,
      required this.nationality,
      required this.expiryDate,
      required this.gender});

  @override
  Either<AppError, bool> verify() {
    if(name!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_NAME,
          cause: Exception()));
    } else if (idNumber!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_ID_NUMBER,
          cause: Exception()));
    } else if (dateOfBirth!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_DATE_OF_BIRTH,
          cause: Exception()));
    } else if (nationality!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_NATIONALITY,
          cause: Exception()));
    } else if(expiryDate!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_EXPIRY_DATE,
          cause: Exception()));
    } else if(gender!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_GENDER,
          cause: Exception()));
    }
    return Right(true);
  }
}

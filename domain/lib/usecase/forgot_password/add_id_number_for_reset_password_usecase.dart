import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class AddIdNumberForResetPasswordUseCase
    extends BaseUseCase<NetworkError, AddIdNumberForResetPasswordUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required AddIdNumberForResetPasswordUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class AddIdNumberForResetPasswordUseCaseParams extends Params {
  final String emailAddress;
  final String nationalId;
  final String idExpiryDate;

  AddIdNumberForResetPasswordUseCaseParams(
      {required this.emailAddress, required this.nationalId, required this.idExpiryDate});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(emailAddress)) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_EMAIL, cause: Exception()));
    } else if (!Validator.validateEmail(emailAddress)) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_EMAIL, cause: Exception()));
    }
    if (Validator.isEmpty(nationalId)) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_ID_NUMBER, cause: Exception()));
    } else if (Validator.isEmpty(idExpiryDate)) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_EXPIRY_DATE, cause: Exception()));
    }
    return Right(true);
  }
}

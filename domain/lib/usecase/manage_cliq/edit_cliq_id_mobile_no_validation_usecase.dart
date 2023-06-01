import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EditCliqMobileNoValidationUseCase
    extends BaseUseCase<NetworkError, EditCliqMobileNoValidationUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required EditCliqMobileNoValidationUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class EditCliqMobileNoValidationUseCaseParams extends Params {
  final String mobileNo;
  final bool isSelected;
  final String initialAliasValue;

  EditCliqMobileNoValidationUseCaseParams(
      {required this.mobileNo, required this.isSelected, required this.initialAliasValue});

  @override
  Either<AppError, bool> verify() {
    if (mobileNo.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.PLEASE_ENTER_MOBILE_NO, cause: Exception()));
    } else if (mobileNo.length != 14) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_MOBILE, cause: Exception()));
    } else if (mobileNo.substring(0, 5) != '00962') {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_MOBILE, cause: Exception()));
    } else if (isSelected == false) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.AGREE_TO_THE_TERM_AND_CONDITION,
          cause: Exception()));
    } else if (initialAliasValue == mobileNo) {
      return Left(AppError(
          cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.CLIQ_ID_ALREADY_EXISTS));
    }

    return Right(true);
  }
}

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

  EditCliqMobileNoValidationUseCaseParams({
    required this.mobileNo,
    required this.isSelected,
  });

  @override
  Either<AppError, bool> verify() {
    if (mobileNo.isEmpty || mobileNo.length < 8) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_MOBILE, cause: Exception()));
    } else if (isSelected == false) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.AGREE_TO_THE_TERM_AND_CONDITION,
          cause: Exception()));
    }

    return Right(true);
  }
}

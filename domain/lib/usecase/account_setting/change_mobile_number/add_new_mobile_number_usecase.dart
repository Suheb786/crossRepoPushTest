import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AddNewMobileNumberUseCase
    extends BaseUseCase<NetworkError, AddNewMobileNumberUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required AddNewMobileNumberUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class AddNewMobileNumberUseCaseParams extends Params {
  final String mobileNumber;

  AddNewMobileNumberUseCaseParams({required this.mobileNumber});

  @override
  Either<AppError, bool> verify() {
    if (mobileNumber.isEmpty || mobileNumber.length < 8) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_MOBILE,
          cause: Exception()));
    }

    return Right(true);
  }
}

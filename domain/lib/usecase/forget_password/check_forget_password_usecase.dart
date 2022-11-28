import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';
import 'package:domain/repository/forget_password/forget_password_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckForgetPasswordUseCase
    extends BaseUseCase<NetworkError, CheckForgetPasswordUseCaseParams, CheckForgetPasswordResponse> {
  final ForgetPasswordRepository _repository;

  CheckForgetPasswordUseCase(this._repository);

  @override
  Future<Either<NetworkError, CheckForgetPasswordResponse>> execute(
      {required CheckForgetPasswordUseCaseParams params}) {
    return _repository.checkForgetPassword(
        email: params.email!, expiryDate: params.expiryDate!, nationalId: params.nationalId!);
  }
}

class CheckForgetPasswordUseCaseParams extends Params {
  String? email;
  String? nationalId;
  String? expiryDate;

  CheckForgetPasswordUseCaseParams({this.expiryDate, this.email, this.nationalId});

  @override
  Either<AppError, bool> verify() {
    if (email!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_VERIFY_EMAIL, cause: Exception()));
    } else if (expiryDate!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_EXPIRY_DATE, cause: Exception()));
    } else if (nationalId!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.EMPTY_VERIFY_NATIONAL_ID, cause: Exception()));
    }
    return Right(true);
  }
}

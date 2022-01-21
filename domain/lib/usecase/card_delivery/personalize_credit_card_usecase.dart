import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class PersonalizeCreditCardUseCase extends BaseUseCase<NetworkError,
    PersonalizeCreditCardUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required PersonalizeCreditCardUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class PersonalizeCreditCardUseCaseParams extends Params {
  final String creditLimitSettings;
  final String minimumSettlement;
  final String nickname;

  PersonalizeCreditCardUseCaseParams(
      {this.creditLimitSettings: "",
      this.minimumSettlement: "",
      this.nickname: ""});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(creditLimitSettings)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.SELECT_CREDIT_LIMIT_SETTINGS,
          cause: Exception()));
    }
    // else if (Validator.isEmpty(minimumSettlement)) {
    //   return Left(AppError(
    //       error: ErrorInfo(message: ''),
    //       type: ErrorType.SELECT_MINIMUM_SETTLEMENT,
    //       cause: Exception()));
    // }
    return Right(true);
  }
}

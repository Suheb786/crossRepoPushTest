import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SelectAccountUseCase extends BaseUseCase<NetworkError, SelectAccountUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required SelectAccountUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SelectAccountUseCaseParams extends Params {
  String? account;

  SelectAccountUseCaseParams({this.account});

  @override
  Either<AppError, bool> verify() {
    if (account!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_ACCOUNT, cause: Exception()));
    }
    return Right(true);
  }
}

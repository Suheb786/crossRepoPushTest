import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetSettlementValidationUseCase
    extends BaseUseCase<NetworkError, GetSettlementValidationUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required GetSettlementValidationUseCaseParams params}) {
    return Future.delayed(Duration(seconds: 2), () {
      return Right(true);
    });
  }
}

class GetSettlementValidationUseCaseParams extends Params {
  String currentAmmount;
  String availableAmount;

  GetSettlementValidationUseCaseParams({required this.currentAmmount, required this.availableAmount});

  @override
  Either<AppError, bool> verify() {
    if (currentAmmount.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_ACCOUNT, cause: Exception()));
    }
    // if (currentAmmount! > availableAmount!) {
    //   return Left(
    //       AppError(cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.NOTE_ENOUGH_AMOUNT));
    // }

    return Right(true);
  }
}

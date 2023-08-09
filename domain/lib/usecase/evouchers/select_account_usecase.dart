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
  String totalAmountString;
  num itemValueString;
  double totalAmount = 0;
  bool isChecked;

  GetSettlementValidationUseCaseParams(
      {required this.totalAmountString, required this.itemValueString, required this.isChecked}) {
    totalAmount = double.parse(totalAmountString);
  }

  @override
  Either<AppError, bool> verify() {
    if (totalAmount < itemValueString) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.NOTE_ENOUGH_AMOUNT, cause: Exception()));
    }
    if (isChecked == false) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_ACCOUNT, cause: Exception()));
    }

    return Right(true);
  }
}

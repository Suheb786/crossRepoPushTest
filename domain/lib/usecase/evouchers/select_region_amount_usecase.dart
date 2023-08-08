import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SelectRegionAmountUseCase extends BaseUseCase<NetworkError, SelectRegionAmountUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required SelectRegionAmountUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SelectRegionAmountUseCaseParams extends Params {
  String? selectedRegion;
  String? amount;

  SelectRegionAmountUseCaseParams({this.selectedRegion, this.amount});

  @override
  Either<AppError, bool> verify() {
    if (selectedRegion!.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_REGION, cause: Exception()));
    } else if (amount!.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.SELECT_VALUE, cause: Exception()));
    }
    return Right(true);
  }
}

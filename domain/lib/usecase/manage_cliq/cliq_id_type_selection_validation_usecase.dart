import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/cliq_id_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class CliqIdTypeSelectionValidationUseCase extends BaseUseCase<NetworkError, CliqIdTypeSelectionValidationUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required CliqIdTypeSelectionValidationUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CliqIdTypeSelectionValidationUseCaseParams extends Params {
  final String cliqIdType;
  final String alias;
  final String mobileNo;
  final CliqIdTypeEnum cliqIdTypeEnum;

  CliqIdTypeSelectionValidationUseCaseParams({
    required this.cliqIdType,
    required this.alias,
    required this.cliqIdTypeEnum,
    required this.mobileNo,
  });

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(cliqIdType)) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_CLIQ_ID_TYPE, cause: Exception()));
    } else if (cliqIdTypeEnum == CliqIdTypeEnum.ALIAS) {
      if (alias.isEmpty) {
        return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_ALIAS, cause: Exception()));
      }
    } else if (cliqIdTypeEnum == CliqIdTypeEnum.MOBILE_NO) {
      if (mobileNo.isEmpty) {
        return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.PLEASE_ENTER_MOBILE_NO, cause: Exception()));
      } else if (mobileNo.length <= 14) {
        return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_MOBILE, cause: Exception()));
      } else if (mobileNo.substring(0, 5) != '00962') {
        return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_MOBILE, cause: Exception()));
      }
    }

    return Right(true);
  }
}

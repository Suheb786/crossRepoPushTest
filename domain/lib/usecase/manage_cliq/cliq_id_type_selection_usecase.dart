import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/cliq_id_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class CliqIdTypeSelectionUseCase extends BaseUseCase<NetworkError, CliqIdTypeSelectionUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required CliqIdTypeSelectionUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class CliqIdTypeSelectionUseCaseParams extends Params {
  final String cliqIdType;
  final String alias;
  final String mobileNo;
  final CliqIdTypeEnum cliqIdTypeEnum;

  CliqIdTypeSelectionUseCaseParams({
    required this.cliqIdType,
    required this.alias,
    required this.cliqIdTypeEnum,
    required this.mobileNo,
  });

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(cliqIdType)) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_CLIQ_ID_TYPE, cause: Exception()));
    } else if (cliqIdTypeEnum == CliqIdTypeEnum.ALIAS) {
      if (alias.isEmpty) {
        return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_ALIAS, cause: Exception()));
      }
    } else if (cliqIdTypeEnum == CliqIdTypeEnum.MOBILE_NO) {
      if (mobileNo.isEmpty || mobileNo.length < 8) {
        return Left(
            AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_MOBILE, cause: Exception()));
      }
    }

    return Right(true);
  }
}

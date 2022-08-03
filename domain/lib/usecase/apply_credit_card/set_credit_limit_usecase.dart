import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SetCreditLimitUseCase extends BaseUseCase<NetworkError, SetCreditLimitUseCaseParams, bool> {
  final CardRepository _cardRepository;

  SetCreditLimitUseCase(this._cardRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required SetCreditLimitUseCaseParams params}) {
    return _cardRepository.getCardInProcess(
        loanValueId: params.loanValueId!,
        creditLimit: double.parse(params.limit!),
        nickName: params.nickName!,
        minimumSettlement: params.minimumSettlement!);
  }
}

class SetCreditLimitUseCaseParams extends Params {
  String? minimumSettlement;
  String? limit;
  String? nickName;
  num? loanValueId;

  SetCreditLimitUseCaseParams({this.minimumSettlement, this.limit, this.nickName, this.loanValueId});

  @override
  Either<AppError, bool> verify() {
    if (minimumSettlement!.isEmpty || minimumSettlement == null) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.EMPTY_MINIMUM_SETTLEMENT_VALUE, cause: Exception()));
    }
    return Right(true);
  }
}

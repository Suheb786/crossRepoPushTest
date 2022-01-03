import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditCardLimitsUpdateUseCase extends BaseUseCase<NetworkError,
    CreditCardLimitsUpdateUseCaseParams, bool> {
  final CardRepository _repository;

  CreditCardLimitsUpdateUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required CreditCardLimitsUpdateUseCaseParams params}) {
    return _repository.updateCreditCardLimits(
        atmWithdrawal: params.atmWithdrawal!,
        contactLessPayments: params.contactLessPayments!,
        isAtmWithdrawal: params.isAtmWithdrawal!,
        isContactLessPayments: params.isContactLessPayments!,
        isMerchantsPayments: params.isMerchantsPayments!,
        isOnlinePurchase: params.isOnlinePurchase!,
        merchantsPayments: params.merchantsPayments!,
        onlinePurchase: params.onlinePurchase!);
  }
}

class CreditCardLimitsUpdateUseCaseParams extends Params {
  final num? atmWithdrawal;
  final num? merchantsPayments;
  final num? onlinePurchase;
  final num? contactLessPayments;
  final bool? isAtmWithdrawal;
  final bool? isMerchantsPayments;
  final bool? isOnlinePurchase;
  final bool? isContactLessPayments;

  CreditCardLimitsUpdateUseCaseParams(
      {this.atmWithdrawal,
      this.merchantsPayments,
      this.onlinePurchase,
      this.contactLessPayments,
      this.isAtmWithdrawal,
      this.isMerchantsPayments,
      this.isOnlinePurchase,
      this.isContactLessPayments});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

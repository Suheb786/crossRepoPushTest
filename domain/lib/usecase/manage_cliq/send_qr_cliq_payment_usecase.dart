import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendQrCliqPaymentUsecase extends BaseUseCase<NetworkError, SendQrCliqPaymentUsecaseParams, bool> {
  final CliqRepository _cliqRepository;

  SendQrCliqPaymentUsecase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required SendQrCliqPaymentUsecaseParams params}) {
    return _cliqRepository.sendQRCliqPayment(
        referenceLabel: params.referenceLabel,
        merchantCategoryCode: params.merchantCategoryCode,
        countryCode: params.countryCode,
        merchantID: params.merchantID,
        merchantName: params.merchantName,
        transactionAmount: params.transactionAmount,
        city: params.city,
        transactionCurrency: params.transactionCurrency,
        additionalLanguageTemplate: params.additionalLanguageTemplate,
        dateTime: params.dateTime,
        qrCode: params.qrCode,
        crdtrBic: params.crdtrBic,
        fromAccount: params.fromAccount,
        fromAccountHolderName: params.fromAccountHolderName,
        ValueOfConvenienceFixed: params.ValueOfConvenienceFixed,
        TipOrConvenienceIndicator: params.TipOrConvenienceIndicator,
        getToken: params.getToken);
  }
}

class SendQrCliqPaymentUsecaseParams extends Params {
  final String referenceLabel;
  final String merchantCategoryCode;
  final String countryCode;
  final String merchantID;
  final String merchantName;
  final dynamic location;
  final String transactionAmount;
  final String city;
  final String transactionCurrency;
  final String additionalLanguageTemplate;
  final dynamic verificationCode;
  final String dateTime;
  final dynamic billNumber;
  final dynamic mobileNumber;
  final dynamic storeLabel;
  final dynamic loyaltyNumber;
  final dynamic customerLabel;
  final dynamic terminalLabel;
  final String qrCode;
  final String crdtrBic;
  final String fromAccount;
  final String fromAccountHolderName;
  final String ValueOfConvenienceFixed;
  final String TipOrConvenienceIndicator;
  final dynamic valueOfPercentageConvenience;
  final bool getToken;

  SendQrCliqPaymentUsecaseParams(
      {required this.referenceLabel,
      required this.merchantCategoryCode,
      required this.countryCode,
      required this.merchantID,
      required this.merchantName,
      this.location,
      required this.transactionAmount,
      required this.city,
      required this.transactionCurrency,
      required this.additionalLanguageTemplate,
      this.verificationCode,
      required this.dateTime,
      this.billNumber,
      this.mobileNumber,
      this.storeLabel,
      this.loyaltyNumber,
      this.customerLabel,
      this.terminalLabel,
      required this.qrCode,
      required this.crdtrBic,
      required this.fromAccount,
      required this.fromAccountHolderName,
      required this.ValueOfConvenienceFixed,
      required this.TipOrConvenienceIndicator,
      this.valueOfPercentageConvenience,
      required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

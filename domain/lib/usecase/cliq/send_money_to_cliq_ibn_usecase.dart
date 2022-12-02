import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendMoneyToCliqIbnUsecase extends BaseUseCase<NetworkError, SendMoneyToCliqIbnUsecaseParams, bool> {
  final CliqRepository _cliqRepository;

  SendMoneyToCliqIbnUsecase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required SendMoneyToCliqIbnUsecaseParams params}) {
    return _cliqRepository.sendMoneytoCliqIBAN(
        otpCode: params.otpCode,
        transferType: params.transferType,
        cliqType: params.cliqType,
        toIban: params.toIban,
        toAccountNo: params.toAccountNo,
        toAlias: params.toAlias,
        toMobileNo: params.toMobileNo,
        toBankCountry: params.toBankCountry,
        swift: params.swift,
        routingNO: params.routingNO,
        recipientName: params.recipientName,
        fromAccountNo: params.fromAccountNo,
        transferAmount: params.transferAmount,
        fromAccountCurrency: params.fromAccountCurrency,
        toAccountCurrency: params.toAccountCurrency,
        Charges: params.Charges,
        TransferPurposeCode: params.TransferPurposeCode,
        description: params.description,
        whenToSend: params.whenToSend,
        beneficiaryId: params.beneficiaryId,
        fromAccountHolderName: params.fromAccountHolderName,
        recipientAddress: params.recipientAddress,
        flagAmount: params.flagAmount,
        flagCurrency: params.flagCurrency,
        getToken: params.getToken);
  }
}

class SendMoneyToCliqIbnUsecaseParams extends Params {
  final String otpCode;
  final String transferType;
  final String cliqType;
  final String toIban;
  final String toAccountNo;
  final String toAlias;
  final String toMobileNo;
  final String toBankCountry;
  final String swift;
  final String routingNO;
  final String recipientName;
  final String fromAccountNo;
  final String transferAmount;
  final String fromAccountCurrency;
  final String toAccountCurrency;
  final bool Charges;
  final String TransferPurposeCode;
  final String description;
  final String whenToSend;
  final String beneficiaryId;
  final dynamic fromCardId;
  final dynamic fromCardType;
  final dynamic ownAccountTransferType;
  final String fromAccountHolderName;
  final String recipientAddress;
  final String flagAmount;
  final String flagCurrency;
  final bool getToken;

  SendMoneyToCliqIbnUsecaseParams(
      {required this.otpCode,
      required this.transferType,
      required this.cliqType,
      required this.toIban,
      required this.toAccountNo,
      required this.toAlias,
      required this.toMobileNo,
      required this.toBankCountry,
      required this.swift,
      required this.routingNO,
      required this.recipientName,
      required this.fromAccountNo,
      required this.transferAmount,
      required this.fromAccountCurrency,
      required this.toAccountCurrency,
      required this.Charges,
      required this.TransferPurposeCode,
      required this.description,
      required this.whenToSend,
      required this.beneficiaryId,
      this.fromCardId,
      this.fromCardType,
      this.ownAccountTransferType,
      required this.fromAccountHolderName,
      required this.recipientAddress,
      required this.flagAmount,
      required this.flagCurrency,
      required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

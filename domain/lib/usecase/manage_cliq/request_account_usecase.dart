import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestMoneyUseCase
    extends BaseUseCase<NetworkError, RequestMoneyParams, bool> {
  final CliqRepository _cliqRepository;

  RequestMoneyUseCase(this._cliqRepository);
  @override
  Future<Either<NetworkError, bool>> execute(
      {required RequestMoneyParams params}) {
    return _cliqRepository.requestMoney(
        cliqType: params.cliqType,
        iban: params.iban,
        toAccountNo: params.toAccountNo,
        alias: params.alias,
        mobile: params.mobile,
        receipentName: params.receipentName,
        amount: params.amount,
        currency: params.currency,
        rtpPurposeCode: params.rtpPurposeCode,
        description: params.description,
        beneficiaryId: params.beneficiaryId,
        toAccountHolderName: params.toAccountHolderName,
        receipentAddress: params.receipentAddress,
        getToken: params.getToken);
  }
}

class RequestMoneyParams extends Params {
  final String cliqType;
  final String iban;
  final String toAccountNo;
  final String alias;
  final String mobile;
  final String receipentName;
  final String amount;
  final String currency;
  final String rtpPurposeCode;
  final String description;
  final String beneficiaryId;
  final String toAccountHolderName;
  final String receipentAddress;
  final bool getToken;

  RequestMoneyParams(
      {required this.cliqType,
      required this.iban,
      required this.toAccountNo,
      required this.alias,
      required this.mobile,
      required this.receipentName,
      required this.amount,
      required this.currency,
      required this.rtpPurposeCode,
      required this.description,
      required this.beneficiaryId,
      required this.toAccountHolderName,
      required this.receipentAddress,
      required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/payment/payment_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentRemoteDs paymentRemoteDs;

  PaymentRepositoryImpl(this.paymentRemoteDs);

  @override
  Future<Either<NetworkError, GetAccountByAliasContentResponse>>
      getAccountByAlias(String value, String currency) async {
    final result = await safeApiCall(
      paymentRemoteDs.getAccountByAlias(value, currency),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, CheckSendMoneyResponse>> checkSendMoney(
      String toAccount, num toAmount) async {
    final result = await safeApiCall(
      paymentRemoteDs.checkSendMoney(toAccount: toAccount, toAmount: toAmount),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, TransferSuccessResponse>> transfer(
      {String? beneficiaryId,
      String? otpCode,
      String? transferType,
      String? beneficiaryImage,
      bool? isFriend,
      num? toAmount,
      num? localEq,
      String? memo,
      String? toAccount,
      String? nickName,
      String? detCustomerType,
      String? type}) async {
    final result = await safeApiCall(
      paymentRemoteDs.transfer(
          beneficiaryId: beneficiaryId!,
          otpCode: otpCode,
          transferType: transferType!,
          beneficiaryImage: beneficiaryImage!,
          isFriend: isFriend!,
          toAmount: toAmount!,
          localEq: localEq!,
          memo: memo!,
          toAccount: toAccount!,
          nickName: nickName!,
          detCustomerType: detCustomerType!,
          type: type!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, RequestToPayContentResponse>> requestToPay(
      String ctgyPurp,
      num amount,
      String dbtrBic,
      String dbtrAcct,
      String dbtrName,
      String memo,
      bool? isFriend,
      String? image,
      String? nickName,
      String? detCustomerType,
      String? type) async {
    final result = await safeApiCall(
      paymentRemoteDs.requestToPay(ctgyPurp, amount, dbtrBic, dbtrAcct,
          dbtrName, memo, isFriend, image, nickName, detCustomerType, type),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> transferVerify() async {
    final result = await safeApiCall(
      paymentRemoteDs.transferVerify(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, PurposeResponse>> getPurpose(String toAccount,
      String transferType, String detCustomerType, String type) async {
    final result = await safeApiCall(
      paymentRemoteDs.getPurpose(
          toAccount, transferType, detCustomerType, type),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}

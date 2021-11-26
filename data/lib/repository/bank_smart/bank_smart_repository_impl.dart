import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/bank_smart/bank_smart_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/bank_smart/purpose_of_account_opening_response.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';

class BankSmartRepositoryImpl extends BankSmartRepository {
  final BankSmartRemoteDS _bankSmartRemoteDS;

  BankSmartRepositoryImpl(this._bankSmartRemoteDS);

  @override
  Future<Either<NetworkError, PurposeOfAccountOpeningResponse>>
      addAccountPurpose(
          {required bool getToken,
          String? purpose,
          bool? isCashDeposit,
          bool? isTransfer,
          bool? isBillPayment,
          bool? isOther,
          double? monthlyTransaction,
          double? annualTransaction}) async {
    final result = await safeApiCall(
      _bankSmartRemoteDS.addAccountPurpose(
          getToken: getToken,
          purpose: purpose,
          isCashDeposit: isCashDeposit,
          isBillPayment: isBillPayment,
          isOther: isOther,
          isTransfer: isTransfer,
          annualTransaction: annualTransaction,
          monthlyTransaction: monthlyTransaction),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetAccountResponse>> getAccount(
      {required bool getToken}) async {
    final result = await safeApiCall(
      _bankSmartRemoteDS.getAccount(
          getToken: getToken)
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, String>> createAccount(
      {required bool getToken,
      String? cif,
      CustomerInformation? customerInformation,
      CustomerAccountDetails? accountDetails}) async {
    final result = await safeApiCall(
      _bankSmartRemoteDS.createAccount(
          getToken: getToken,
          cif: cif,
          customerInformation: customerInformation,
          accountDetails: accountDetails),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<NetworkError, String>> getAccountDetails(
      {required bool getToken}) async {
    final result = await safeApiCall(
      _bankSmartRemoteDS.getAccountDetails(getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

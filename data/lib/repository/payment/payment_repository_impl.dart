import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/payment/payment_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
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
}

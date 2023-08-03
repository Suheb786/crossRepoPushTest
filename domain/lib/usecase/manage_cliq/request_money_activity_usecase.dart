import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestMoneyActivityUseCase
    extends BaseUseCase<NetworkError, RequestMoneyActivityParams, PaymentActivityResponse> {
  final CliqRepository _cliqRepository;

  RequestMoneyActivityUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, PaymentActivityResponse>> execute(
      {required RequestMoneyActivityParams params}) {
    return _cliqRepository.requestMoneyActivity(
        getToken: params.getToken, FilterDays: params.FilterDays, TransactionType: params.TransactionType);
  }
}

class RequestMoneyActivityParams extends Params {
  final int FilterDays;
  final String TransactionType;
  final bool getToken;

  RequestMoneyActivityParams(
      {required this.getToken, required this.FilterDays, required this.TransactionType});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

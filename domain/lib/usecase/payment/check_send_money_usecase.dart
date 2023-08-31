import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CheckSendMoneyUseCase
    extends BaseUseCase<NetworkError, CheckSendMoneyUseCaseParams, CheckSendMoneyResponse> {
  final PaymentRepository _repository;

  CheckSendMoneyUseCase(this._repository);

  @override
  Future<Either<NetworkError, CheckSendMoneyResponse>> execute(
      {required CheckSendMoneyUseCaseParams params}) {
    return _repository.checkSendMoney(
      params.fromAccount ?? "",
      params.toAccount,
      params.toAmount,
      params.beneficiaryId,
    );
  }
}

class CheckSendMoneyUseCaseParams extends Params {
  final String toAccount;
  final num toAmount;
  final String beneficiaryId;
  final String? fromAccount;

  CheckSendMoneyUseCaseParams(
      {required this.toAccount, this.fromAccount, required this.toAmount, required this.beneficiaryId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

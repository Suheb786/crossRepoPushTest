import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/rj/rj_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class MakeTicketPaymentUseCase extends BaseUseCase<NetworkError, MakeTicketPaymentUseCaseParams, bool> {
  final RJRepository _repository;

  MakeTicketPaymentUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required MakeTicketPaymentUseCaseParams params}) {
    return _repository.makeTicketPayment(
        referenceNumber: params.referenceNumber, amount: '', accountNo: '', otpCode: params.otpCode);
  }
}

class MakeTicketPaymentUseCaseParams extends Params {
  final String referenceNumber;
  final String accountNo;
  final String amount;
  final String otpCode;

  MakeTicketPaymentUseCaseParams(
      {required this.referenceNumber, required this.amount, required this.accountNo, required this.otpCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RemovePrepaidBillerUseCase extends BaseUseCase<NetworkError, RemovePrepaidBillerUseCaseParams, bool> {
  final BillPaymentRepository billPaymentRepository;

  RemovePrepaidBillerUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, bool>> execute({
    required RemovePrepaidBillerUseCaseParams params,
  }) {
    return billPaymentRepository.removePrepaidBiller(params: params);
  }
}

class RemovePrepaidBillerUseCaseParams extends Params {
  final String? registrationID;

  RemovePrepaidBillerUseCaseParams({
    this.registrationID = "",
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RegisterAccountUseCase extends BaseUseCase<NetworkError, RegisterAccountUsecaseParams, bool> {
  final BillPaymentRepository billPaymentRepository;

  RegisterAccountUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required RegisterAccountUsecaseParams params}) {
    return billPaymentRepository.cliqRegisterCustomer();
  }
}

class RegisterAccountUsecaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

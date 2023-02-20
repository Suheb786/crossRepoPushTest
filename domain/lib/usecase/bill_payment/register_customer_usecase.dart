import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RegisterCustomerUseCase extends BaseUseCase<NetworkError, RegisterCustomerUsecaseParams, bool> {
  final BillPaymentRepository billPaymentRepository;

  RegisterCustomerUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required RegisterCustomerUsecaseParams params}) {
    return billPaymentRepository.cliqRegisterCustomer();
  }
}

class RegisterCustomerUsecaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

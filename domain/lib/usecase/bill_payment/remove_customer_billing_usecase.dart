import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RemoveCustomerBillingUseCase
    extends BaseUseCase<NetworkError, RemoveCustomerBillingUseCaseParams, bool> {
  final BillPaymentRepository billPaymentRepository;

  RemoveCustomerBillingUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, bool>> execute({
    required RemoveCustomerBillingUseCaseParams params,
  }) {
    return billPaymentRepository.removeCustomerBilling(params: params);
  }
}

class RemoveCustomerBillingUseCaseParams extends Params {
  final String? billerCode;
  final String? billingNo;
  final String? serviceType;

  RemoveCustomerBillingUseCaseParams({
    this.billerCode = "",
    this.billingNo = "",
    this.serviceType = "",
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

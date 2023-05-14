import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../repository/bill_payment/bill_payment_repository.dart';

class AddNewPrepaidBillerUseCase extends BaseUseCase<NetworkError, AddNewPrepaidBillerUseCaseParams, bool> {
  final BillPaymentRepository billPaymentRepository;

  AddNewPrepaidBillerUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required AddNewPrepaidBillerUseCaseParams params}) {
    return billPaymentRepository.addNewPrepaidBiller(params: params);
  }
}

class AddNewPrepaidBillerUseCaseParams extends Params {
  final String? prepaidCategoryType;
  final String? prepaidCategoryCode;
  final String? serviceType;
  final String? serviceCode;
  final String? billerCode;
  final String? billerName;
  final String? billingNumber;
  final String? nickname;
  final String? amount;
  final bool? billingNumberRequired;

  AddNewPrepaidBillerUseCaseParams(
      {this.prepaidCategoryType = "",
      this.prepaidCategoryCode = "",
      this.serviceType = "",
      this.serviceCode = "",
      this.billerCode = "",
      this.billerName = "",
      this.billingNumber = "",
      this.nickname = "",
      this.amount = "",
      this.billingNumberRequired = false});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../repository/bill_payment/bill_payment_repository.dart';

class AddNewPostpaidBillerUseCase
    extends BaseUseCase<NetworkError, AddNewPostpaidBillerUseCaseParams, bool> {
  final BillPaymentRepository billPaymentRepository;

  AddNewPostpaidBillerUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required AddNewPostpaidBillerUseCaseParams params}) {
    return billPaymentRepository.addNewPostpaidBiller(params: params);
  }
}

class AddNewPostpaidBillerUseCaseParams extends Params {
  final String? serviceType;
  final String? billerCode;
  final String? billingNumber;
  final String? nickname;

  AddNewPostpaidBillerUseCaseParams(
      {this.serviceType: "",
      this.billerCode: "",
      this.billingNumber: "",
      this.nickname: ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PostPaidBillInquiryUseCase
    extends BaseUseCase<NetworkError, PostPaidBillInquiryUseCaseParams, PostPaidBillInquiry> {
  final BillPaymentRepository _repository;

  PostPaidBillInquiryUseCase(this._repository);

  @override
  Future<Either<NetworkError, PostPaidBillInquiry>> execute(
      {required PostPaidBillInquiryUseCaseParams params}) {
    return _repository.postPaidBillInquiry(params: params);
  }
}

class PostPaidBillInquiryUseCaseParams extends Params {
  String? billerCode;
  String? serviceType;
  String? billingNumber;
  dynamic postpaidBillInquiries;
  bool manualBillEnquiry;
  int index;

  PostPaidBillInquiryUseCaseParams(
      {required this.manualBillEnquiry, required this.index, this.postpaidBillInquiries});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

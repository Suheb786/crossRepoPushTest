import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestAmountFromContactUseCase extends BaseUseCase<NetworkError,
    RequestAmountFromContactUseCaseParams, RequestToPayContentResponse> {
  final PaymentRepository _repository;

  RequestAmountFromContactUseCase(this._repository);

  @override
  Future<Either<NetworkError, RequestToPayContentResponse>> execute(
      {required RequestAmountFromContactUseCaseParams params}) {
    return _repository.requestToPay(
        params.purpose!,
        params.amount!,
        params.dbtrBic!,
        params.dbtrAcct!,
        params.dbtrName!,
        params.purposeDetail!);
  }
}

class RequestAmountFromContactUseCaseParams extends Params {
  String? purpose;
  String? purposeDetail;
  num? amount;
  String? dbtrBic;
  String? dbtrAcct;
  String? dbtrName;

  RequestAmountFromContactUseCaseParams(
      {this.purpose,
      this.purposeDetail,
      this.amount,
      this.dbtrBic,
      this.dbtrName,
      this.dbtrAcct});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

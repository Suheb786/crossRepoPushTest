import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
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
        params.purposeDetail!,
        params.isFriend!,
        params.image!,
        params.nickName!);
  }
}

class RequestAmountFromContactUseCaseParams extends Params {
  String? purpose;
  String? purposeDetail;
  num? amount;
  String? dbtrBic;
  String? dbtrAcct;
  String? dbtrName;
  String? image;
  bool? isFriend;
  String? nickName;

  RequestAmountFromContactUseCaseParams(
      {this.purpose,
      this.purposeDetail,
      this.amount,
      this.dbtrBic,
      this.dbtrName,
      this.dbtrAcct,
      this.isFriend: false,
      this.image: "",
      this.nickName: ""});

  @override
  Either<AppError, bool> verify() {
    if (amount! == 0) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_REQUESTED_AMOUNT,
          cause: Exception()));
    }
    return Right(true);
  }
}

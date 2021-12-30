import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestFromNewRecipientUseCase extends BaseUseCase<NetworkError,
    RequestFromNewRecipientUseCaseParams, RequestToPayContentResponse> {
  final PaymentRepository _repository;

  RequestFromNewRecipientUseCase(this._repository);

  @override
  Future<Either<NetworkError, RequestToPayContentResponse>> execute(
      {required RequestFromNewRecipientUseCaseParams params}) {
    return _repository.requestToPay(
        params.purpose!,
        params.amount!,
        params.dbtrBic!,
        params.dbtrAcct!,
        params.dbtrName!,
        params.purposeDetail!,
        params.isFriend!,
        params.image!
    );
  }
}

class RequestFromNewRecipientUseCaseParams extends Params {
  String? ibanOrMobile;
  String? purpose;
  String? purposeDetail;
  num? amount;
  String? dbtrBic;
  String? dbtrAcct;
  String? dbtrName;
  String? image;
  bool? isFriend;

  RequestFromNewRecipientUseCaseParams({
    this.ibanOrMobile,
    this.purpose,
    this.purposeDetail,
    this.amount,
    this.dbtrBic,
    this.dbtrAcct,
    this.dbtrName,
    this.image: "",
    this.isFriend: false
  });

  @override
  Either<AppError, bool> verify() {
    if (ibanOrMobile!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_IBAN_MOBILE,
          cause: Exception()));
    } else if (purpose!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PURPOSE,
          cause: Exception()));
    } else if (purposeDetail!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PURPOSE_DETAIL,
          cause: Exception()));
    }
    return Right(true);
  }
}

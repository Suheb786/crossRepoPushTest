import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestFromNewRecipientUseCase
    extends BaseUseCase<NetworkError, RequestFromNewRecipientUseCaseParams, RequestToPayContentResponse> {
  final PaymentRepository _repository;

  RequestFromNewRecipientUseCase(this._repository);

  @override
  Future<Either<NetworkError, RequestToPayContentResponse>> execute(
      {required RequestFromNewRecipientUseCaseParams params}) {
    return _repository.requestToPay(
        params.fromAccount ?? "",
        params.purposeCode!,
        params.amount!,
        params.dbtrBic!,
        params.dbtrAcct!,
        params.dbtrName!,
        params.purposeDetailCode!,
        params.isFriend!,
        params.image!,
        params.nickName,
        params.detCustomerType!,
        params.type!,
        params.alias!,
        params.dbtrSurname!,
        params.addressCity!,
        params.addressCountry!);
  }
}

class RequestFromNewRecipientUseCaseParams extends Params {
  String? ibanOrMobile;
  String? fromAccount;
  String? purpose;
  String? purposeDetail;
  num? amount;
  String? dbtrBic;
  String? dbtrAcct;
  String? dbtrName;
  String? image;
  bool? isFriend;
  num? limit;
  String? purposeCode;
  String? purposeDetailCode;
  String? nickName;
  String? detCustomerType;
  String? type;
  String? dbtrSurname;
  String? alias;
  String? addressCity;
  String? addressCountry;

  RequestFromNewRecipientUseCaseParams(
      {this.ibanOrMobile,
      this.fromAccount,
      this.purpose,
      this.purposeDetail,
      this.amount,
      this.dbtrBic,
      this.dbtrAcct,
      this.nickName = "",
      this.dbtrName,
      this.image = "",
      this.limit,
      this.isFriend = false,
      this.purposeCode,
      this.purposeDetailCode,
      this.type,
      this.detCustomerType,
      this.alias = "",
      this.addressCity = "",
      this.addressCountry = "",
      this.dbtrSurname = ""});

  @override
  Either<AppError, bool> verify() {
    if (ibanOrMobile!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_IBAN_MOBILE, cause: Exception()));
    } else if (purpose!.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PURPOSE, cause: Exception()));
    } else if (purposeDetail!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PURPOSE_DETAIL, cause: Exception()));
    } else if (limit! < amount!) {
      return Left(AppError(
          error: ErrorInfo(message: 'Limit should not be more that $limit'),
          type: ErrorType.LIMIT_EXCEEDED,
          cause: Exception()));
    } else if (nickName!.isEmpty && isFriend!) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_NICKNAME_VALUE, cause: Exception()));
    } else if (this.isFriend! && ((this.nickName ?? '').length > 50)) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.NICKNAME_VALUE_EXCEEDS, cause: Exception()));
    }
    return Right(true);
  }
}

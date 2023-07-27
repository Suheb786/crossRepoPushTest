import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/check_send_money_message_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class SendToNewRecipientUseCase extends BaseUseCase<NetworkError, SendToNewRecipientUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required SendToNewRecipientUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SendToNewRecipientUseCaseParams extends Params {
  String? ibanOrMobile;
  String? purpose;
  String? purposeDetail;
  num? amount;
  num? limit;
  String? nickName;
  bool? isFriend;
  CheckSendMoneyMessageEnum? messageEnum;
  String? recipientName;
  String? recipientAddress;

  SendToNewRecipientUseCaseParams(
      {this.ibanOrMobile,
      this.purpose,
      this.purposeDetail,
      this.amount,
      this.nickName = "",
      this.isFriend = false,
      this.limit,
      this.messageEnum,
      this.recipientName,
      this.recipientAddress});

  @override
  Either<AppError, bool> verify() {
    if (ibanOrMobile!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_IBAN_MOBILE, cause: Exception()));
    } else if (messageEnum == CheckSendMoneyMessageEnum.IBAN_FROM_CliQ && (recipientName ?? "").isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_RECIPIENT_NAME, cause: Exception()));
    } else if (messageEnum == CheckSendMoneyMessageEnum.IBAN_FROM_CliQ &&
        Validator.recipientNameValidationFailed(recipientName: recipientName ?? '')) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.RECIPIENT_NAME_VALIDATION, cause: Exception()));
    } else if (messageEnum == CheckSendMoneyMessageEnum.IBAN_FROM_CliQ && (recipientAddress ?? "").isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.EMPTY_RECIPIENT_ADDRESS, cause: Exception()));
    } else if (purpose!.isEmpty) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PURPOSE, cause: Exception()));
    } else if (purposeDetail!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_PURPOSE_DETAIL, cause: Exception()));
    } else if (limit! < amount!) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.LIMIT_EXCEEDED, cause: Exception()));
    } else if (this.nickName!.isEmpty && this.isFriend!) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_NICKNAME_VALUE, cause: Exception()));
    } else if (this.isFriend! && ((this.nickName ?? '').length > 50)) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.NICKNAME_VALUE_EXCEEDS, cause: Exception()));
    }
    return Right(true);
  }
}

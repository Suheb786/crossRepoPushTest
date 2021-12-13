import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SendToNewRecipientUseCase
    extends BaseUseCase<NetworkError, SendToNewRecipientUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required SendToNewRecipientUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class SendToNewRecipientUseCaseParams extends Params {
  String? ibanOrMobile;
  String? purpose;
  String? purposeDetail;

  SendToNewRecipientUseCaseParams(
      {this.ibanOrMobile, this.purpose, this.purposeDetail});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DcEnterOtpUseCase extends BaseUseCase<NetworkError, DcEnterOtpUseCaseParams, bool> {
  final CardRepository _cardRepository;

  DcEnterOtpUseCase(this._cardRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required DcEnterOtpUseCaseParams params}) {
    if (params.cardType == CardType.DEBIT) {
      return _cardRepository.dcChangeLinkedMobileNumber(params: params);
    } else {
      return _cardRepository.ccChangeLinkedMobileNumber(params: params);
    }
  }
}

class DcEnterOtpUseCaseParams extends Params {
  final String? mobileCode;
  final String? mobileNumber;
  final String? otpCode;
  final String? tokenizedPan;
  final CardType cardType;

  DcEnterOtpUseCaseParams(
      {this.otpCode, this.tokenizedPan, this.mobileCode, this.mobileNumber, this.cardType: CardType.DEBIT});

  @override
  Either<AppError, bool> verify() {
    if (otpCode!.length < 6) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_OTP, cause: Exception()));
    }
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DcEnterNewMobileNumberUseCase extends BaseUseCase<NetworkError,
    DcEnterNewMobileNumberUseCaseParams, bool> {
  DcEnterNewMobileNumberUseCase(this._cardRepository);

  CardRepository _cardRepository;

  @override
  Future<Either<NetworkError, bool>> execute(
      {required DcEnterNewMobileNumberUseCaseParams params}) {
    if (params.cardType == CardType.DEBIT) {
      return _cardRepository.dcChangeLinkedMobileNumberVerify(params: params);
    } else {
      return _cardRepository.ccChangeLinkedMobileNumberVerify(params: params);
    }
  }
}

class DcEnterNewMobileNumberUseCaseParams extends Params {
  final String? mobileCode;
  final String? mobileNumber;
  final String? tokenizedPan;
  final CardType cardType;

  DcEnterNewMobileNumberUseCaseParams(
      {this.mobileNumber = "",
      this.mobileCode,
      this.cardType: CardType.DEBIT,
      this.tokenizedPan});

  @override
  Either<AppError, bool> verify() {
    if (mobileNumber!.isEmpty || mobileNumber!.length < 8) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_MOBILE,
          cause: Exception()));
    }
    return Right(true);
  }
}

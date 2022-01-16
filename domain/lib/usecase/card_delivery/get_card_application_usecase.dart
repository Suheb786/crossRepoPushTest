import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCardApplicationUseCase extends BaseUseCase<NetworkError,
    GetCardApplicationUseCaseParams, GetCardApplicationResponse> {
  final CardRepository _cardRepository;

  GetCardApplicationUseCase(this._cardRepository);

  @override
  Future<Either<NetworkError, GetCardApplicationResponse>> execute(
      {required GetCardApplicationUseCaseParams params}) {
    return _cardRepository.getCardApplication();
  }
}

class GetCardApplicationUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

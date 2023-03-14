import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/apple_pay/apple_pay_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PushAntelopCardsUseCase extends BaseUseCase<BaseError, PushAntelopCardsUseCaseParams, bool> {
  final ApplePayRepository _applePayRepository;

  PushAntelopCardsUseCase(this._applePayRepository);

  @override
  Future<Either<BaseError, bool>> execute({required params}) async {
    return await _applePayRepository.pushCardAntelop(params.cardId);
  }
}

class PushAntelopCardsUseCaseParams extends Params {
  String cardId;

  PushAntelopCardsUseCaseParams({required this.cardId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

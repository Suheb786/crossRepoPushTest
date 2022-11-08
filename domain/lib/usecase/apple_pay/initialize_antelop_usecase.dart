import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/apple_pay/apple_pay_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class InitializeAntelopUseCase extends BaseUseCase<BaseError, InitializeAntelopUseCaseParams, bool> {
  final ApplePayRepository _applePayRepository;

  InitializeAntelopUseCase(this._applePayRepository);

  @override
  Future<Either<BaseError, bool>> execute({required params}) async {
    return await _applePayRepository.initializeAntelop();
  }
}

class InitializeAntelopUseCaseParams extends Params {
  InitializeAntelopUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

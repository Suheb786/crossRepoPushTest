import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ClearWalletIdUseCase extends BaseUseCase<BaseError, ClearWalletIdUseCaseParams, bool> {
  final UserRepository _userRepository;

  ClearWalletIdUseCase(this._userRepository);

  @override
  Future<Either<BaseError, bool>> execute({required params}) async {
    return await _userRepository.clearWalletId();
  }
}

class ClearWalletIdUseCaseParams extends Params {
  ClearWalletIdUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

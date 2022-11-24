import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RemoveDebitLockUseCase extends BaseUseCase<NetworkError, RemoveDebitLockUseCaseParams, bool> {
  final BankSmartRepository _bankSmartRepository;

  RemoveDebitLockUseCase(this._bankSmartRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required RemoveDebitLockUseCaseParams params}) {
    return _bankSmartRepository.removeDebitLock();
  }
}

class RemoveDebitLockUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

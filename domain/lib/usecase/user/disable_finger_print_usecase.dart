import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DisableFingerPrintUseCase extends BaseUseCase<BaseError, DisableFingerPrintUseCaseParams, bool> {
  final UserRepository _repository;

  DisableFingerPrintUseCase(this._repository);

  @override
  Future<Either<BaseError, bool>> execute({required DisableFingerPrintUseCaseParams params}) async {
    return Future.value(
      (await _repository.disableFingerPrint()).fold((l) => Left(l), (response) async {
        return (await _repository.getCurrentUser()).fold((l) => Left(l), (currentUser) async {
          currentUser.isBiometricEnabled = false;
          return (await _repository.saveUser(currentUser)).fold((l) => Left(l), (user) async {
            print('savedUser--->${user.isBiometricEnabled}');
            return Right(response);
          });
        });
      }),
    );
  }
}

class DisableFingerPrintUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

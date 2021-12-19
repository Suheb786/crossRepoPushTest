import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EnableBiometricUseCase
    extends BaseUseCase<BaseError, EnableBiometricUseCaseParams, bool> {
  final UserRepository _repository;

  EnableBiometricUseCase(this._repository);

  @override
  Future<Either<BaseError, bool>> execute(
      {required EnableBiometricUseCaseParams params}) async {
    return Future.value(
      (await _repository.enableBiometric()).fold((l) => Left(l),
              (isSuccess) async {
            return (await _repository.getCurrentUser()).fold((l) => Left(l),
                    (user) async {
                  user.isBiometricEnabled = true;
                  return (await _repository.saveUser(user)).fold((l) =>
                      Left(l), (r) {
                    print('save user--->${r.isBiometricEnabled}');
                    print('save user--->${r.id}');
                    print('save user--->${r.privatePEM}');
                    return Right(isSuccess);
                  });
                });
          }),
    );
    // return _repository.enableBiometric();
  }
}

class EnableBiometricUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

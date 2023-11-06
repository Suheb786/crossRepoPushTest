import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/user/biometric_login/android_login_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AndroidLoginUseCase extends BaseUseCase<BaseError, AndroidLoginUseCaseParams, AndroidLoginResponse> {
  final UserRepository userRepository;

  AndroidLoginUseCase(this.userRepository);

  @override
  Future<Either<BaseError, AndroidLoginResponse>> execute({required AndroidLoginUseCaseParams params}) async {
    return Future.value(
      (await userRepository.androidLogin(cipher: params.cipher)).fold((l) => Left(l),
          (loginSuccessContent) async {
        return (await userRepository.getCurrentUser()).fold((l) => Left(l), (user) async {
          user.journeyId = loginSuccessContent.androidLoginContent.journeyId;
          user.idWiseRefId = loginSuccessContent.androidLoginContent.journeyRefId;
          return (await userRepository.saveUser(user)).fold((l) => Left(l), (r) {
            return Right(loginSuccessContent);
          });
        });
      }),
    );
  }
}

class AndroidLoginUseCaseParams extends Params {
  final String cipher;

  AndroidLoginUseCaseParams({required this.cipher});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

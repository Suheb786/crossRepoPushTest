import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class IphoneLoginUseCase
    extends BaseUseCase<BaseError, IphoneLoginUseCaseParams, User> {
  final UserRepository userRepository;

  IphoneLoginUseCase(this.userRepository);

  @override
  Future<Either<BaseError, User>> execute(
      {required IphoneLoginUseCaseParams params}) async {
    return userRepository.iphoneLogin(cipher: params.cipher);
    // return Future.value(
    //   (await userRepository.iphoneLogin(cipher: params.cipher))
    //       .fold((l) => Left(l), (user) async {
    //     return userRepository.saveUser(user);
    //   }),
    // );
  }
}

class IphoneLoginUseCaseParams extends Params {
  final String cipher;

  IphoneLoginUseCaseParams({required this.cipher});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

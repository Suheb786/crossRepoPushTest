import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UserDataUseCase
    extends BaseUseCase<BaseError, UserDataUseCaseParams, Stream<User>> {
  final UserRepository _repository;

  UserDataUseCase(this._repository);

  @override
  Future<Either<BaseError, Stream<User>>> execute(
      {required UserDataUseCaseParams params}) async {
    return _repository.listenCurrentUser();
    // return _repository.enableBiometric();
  }
}

class UserDataUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

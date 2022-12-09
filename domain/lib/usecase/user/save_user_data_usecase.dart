import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SaveUserDataUseCase extends BaseUseCase<DatabaseError, SaveUserDataUseCaseParams, User> {
  final UserRepository _repository;

  SaveUserDataUseCase(this._repository);

  @override
  Future<Either<DatabaseError, User>> execute({required SaveUserDataUseCaseParams params}) async {
    return _repository.saveUser(params.user);
  }
}

class SaveUserDataUseCaseParams extends Params {
  final User user;

  SaveUserDataUseCaseParams({
    required this.user,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

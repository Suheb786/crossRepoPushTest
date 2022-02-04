import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class
LoginUseCase extends BaseUseCase<BaseError, LoginUseCaseParams, User> {
  final UserRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<BaseError, User>> execute(
      {required LoginUseCaseParams params}) async {
    // return Future.value(
    //   (await _repository.loginUser(
    //           email: params.email, password: params.password))
    //       .fold((l) => Left(l), (response) async {
    //     return (await _repository.getCurrentUser()).fold((l) => Left(l),
    //         (currentUser) async {
    //       currentUser.email = params.email;
    //       return (await _repository.saveUser(currentUser)).fold((l) => Left(l),
    //           (user) async {
    //         return Right(response);
    //       });
    //     });
    //   }),
    // );

    return Future.value(
      (await _repository.loginUser(
              email: params.email, password: params.password))
          .fold((l) => Left(l), (user) async {
        return _repository.saveUser(user);
      }),
    );
  }
}

class LoginUseCaseParams extends Params {
  final String email;
  final String password;

  LoginUseCaseParams({required this.email, required this.password});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(email)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_EMAIL,
          cause: Exception()));
    } else if (!Validator.validateEmail(email)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EMAIL,
          cause: Exception()));
    }
    if (Validator.isEmpty(password)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_PASSWORD,
          cause: Exception()));
    }
    return Right(true);
  }
}

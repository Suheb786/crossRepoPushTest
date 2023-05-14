import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PersonalizeDebitCardUseCase extends BaseUseCase<NetworkError, PersonalizeDebitCardUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute({required PersonalizeDebitCardUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class PersonalizeDebitCardUseCaseParams extends Params {
  final String nickname;

  PersonalizeDebitCardUseCaseParams({this.nickname = ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

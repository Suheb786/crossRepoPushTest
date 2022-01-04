import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GenerateKeyPairUseCase extends BaseUseCase<BaseError,
    GenerateKeyPairUseCaseParams,
    GenerateKeyPairResponse> {
  final UserRepository _repository;

  GenerateKeyPairUseCase(this._repository);

  @override
  Future<Either<BaseError, GenerateKeyPairResponse>> execute(
      {required GenerateKeyPairUseCaseParams params}) async {
    return Future.value(
      (await _repository.generateKeyPair()).fold((l) => Left(l),
              (response) async {
            return (await _repository.getCurrentUser()).fold((l) => Left(l),
                    (currentUser) async {
                  print('current user--->${currentUser.id}');
                  currentUser.privatePEM = response.content!.privatePEM;
                  currentUser.publicPEM = response.content!.publicPEM;
                  return (await _repository.saveUser(currentUser)).fold((l) =>
                      Left(l),
                          (user) async {
                        print('savedUser--->${user.privatePEM}');
                        return Right(response);
                      });
                });
          }),
    );
    //return _repository.generateKeyPair();
  }
}

class GenerateKeyPairUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/biometric_login/get_cipher_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCipherUseCase extends BaseUseCase<NetworkError, GetCipherUseCaseParams, GetCipherResponse> {
  final UserRepository userRepository;

  GetCipherUseCase(this.userRepository);

  @override
  Future<Either<NetworkError, GetCipherResponse>> execute({required GetCipherUseCaseParams params}) {
    return userRepository.getCipher();
  }
}

class GetCipherUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

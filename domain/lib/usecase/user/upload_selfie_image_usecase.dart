import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UploadSelfieImageUseCase extends BaseUseCase<NetworkError, UploadSelfieImageUseCaseParams, bool> {
  final UserRepository _repository;

  UploadSelfieImageUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required UploadSelfieImageUseCaseParams params}) {
    return _repository.uploadSelfieImage(imagePath: params.imagePath);
  }
}

class UploadSelfieImageUseCaseParams extends Params {
  String? imagePath;

  UploadSelfieImageUseCaseParams({required this.imagePath});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

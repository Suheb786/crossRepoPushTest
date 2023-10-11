import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UploadProfileImageUseCase extends BaseUseCase<BaseError, UploadProfileImageUseCaseParams, bool> {
  final AccountSettingsRepository _accountSettingsRepository;
  final UserRepository _userRepository;

  UploadProfileImageUseCase(this._accountSettingsRepository, this._userRepository);

  @override
  Future<Either<BaseError, bool>> execute({required UploadProfileImageUseCaseParams params}) async {
    return Future.value(
      (await _accountSettingsRepository.updateProfileImage(filePath: params.imagePath)).fold((l) => Left(l),
          (r) async {
        return (await _userRepository.getCurrentUser()).fold((l) => Left(l), (user) async {
          user.profileImage = params.imagePath;

          return (await _userRepository.saveUser(user)).fold((l) => Left(l), (user) async {
            return Right(r);
          });
        });
      }),
    );
  }
}

class UploadProfileImageUseCaseParams extends Params {
  final String imagePath;

  UploadProfileImageUseCaseParams({required this.imagePath});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

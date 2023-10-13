import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetProfileInfoUseCase extends BaseUseCase<BaseError, GetProfileInfoUseCaseParams, ProfileInfoResponse> {
  final AccountSettingsRepository _accountSettingsRepository;
  final UserRepository _userRepository;

  GetProfileInfoUseCase(this._accountSettingsRepository, this._userRepository);

  @override
  Future<Either<BaseError, ProfileInfoResponse>> execute(
      {required GetProfileInfoUseCaseParams params}) async {
    return Future.value(
      (await _accountSettingsRepository.getAccountDetails()).fold((l) => Left(l), (r) async {
        return (await _userRepository.getCurrentUser()).fold((l) => Left(l), (user) async {
          user.isProfileApiCall = true;

          user.localProfileImageDB = r.content?.localProfileImageDB;

          return (await _userRepository.saveUser(user)).fold((l) => Left(l), (user) async {
            return Right(r);
          });
        });
      }),
    );
  }
}

class GetProfileInfoUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

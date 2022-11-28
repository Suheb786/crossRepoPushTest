import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetProfileInfoUseCase
    extends BaseUseCase<NetworkError, GetProfileInfoUseCaseParams, ProfileInfoResponse> {
  final AccountSettingsRepository _accountSettingsRepository;

  GetProfileInfoUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, ProfileInfoResponse>> execute({required GetProfileInfoUseCaseParams params}) {
    return _accountSettingsRepository.getAccountDetails();
  }
}

class GetProfileInfoUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

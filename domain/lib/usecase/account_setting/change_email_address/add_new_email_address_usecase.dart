import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class AddNewEmailAddressUseCase extends BaseUseCase<NetworkError, AddNewEmailAddressUseCaseParams, bool> {
  final AccountSettingsRepository _accountSettingsRepository;

  AddNewEmailAddressUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required AddNewEmailAddressUseCaseParams params}) {
    return _accountSettingsRepository.changeEmail(email: params.email);
  }
}

class AddNewEmailAddressUseCaseParams extends Params {
  final String email;

  AddNewEmailAddressUseCaseParams({required this.email});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(email)) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_EMAIL, cause: Exception()));
    } else if (!Validator.validateEmail(email)) {
      return Left(AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_EMAIL, cause: Exception()));
    }

    return Right(true);
  }
}

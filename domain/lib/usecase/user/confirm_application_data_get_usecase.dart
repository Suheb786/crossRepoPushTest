import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmApplicationDataGetUseCase extends BaseUseCase<NetworkError,
    ConfirmApplicationDataGetUseCaseParams, GetConfirmApplicationDataResponse> {
  final UserRepository _repository;

  ConfirmApplicationDataGetUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetConfirmApplicationDataResponse>> execute(
      {required ConfirmApplicationDataGetUseCaseParams params}) {
    return _repository.confirmApplicationDataGet();
  }
}

class ConfirmApplicationDataGetUseCaseParams extends Params {
  ConfirmApplicationDataGetUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

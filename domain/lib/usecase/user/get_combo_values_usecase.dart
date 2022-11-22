import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetComboValuesUseCase
    extends BaseUseCase<NetworkError, GetComboValuesUseCaseParams, GetComboValuesResponse> {
  final UserRepository _repository;

  GetComboValuesUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetComboValuesResponse>> execute(
      {required GetComboValuesUseCaseParams params}) {
    return _repository.getComboValues();
  }
}

class GetComboValuesUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

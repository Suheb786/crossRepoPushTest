import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/register/register_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAdditionalIncomeSourceUseCase extends BaseUseCase<LocalError,
    GetAdditionalIncomeSourceUseCaseParams, List<String>> {
  final RegisterRepository _registerRepository;

  GetAdditionalIncomeSourceUseCase(this._registerRepository);

  @override
  Future<Either<LocalError, List<String>>> execute(
      {required GetAdditionalIncomeSourceUseCaseParams params}) {
    return _registerRepository.getAdditionalIncomeSourceList();
  }
}

class GetAdditionalIncomeSourceUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

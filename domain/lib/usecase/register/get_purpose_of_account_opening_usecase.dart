import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/register/register_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetPurposeOfAccountOpeningUseCase extends BaseUseCase<LocalError,
    GetPurposeOfAccountOpeningUseCaseParams, List<String>> {
  final RegisterRepository _registerRepository;

  GetPurposeOfAccountOpeningUseCase(this._registerRepository);

  @override
  Future<Either<LocalError, List<String>>> execute(
      {required GetPurposeOfAccountOpeningUseCaseParams params}) {
    return _registerRepository.getPurposeOfAccountOpeningList();
  }
}

class GetPurposeOfAccountOpeningUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

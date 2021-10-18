import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/register/register_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RelationshipWithPEPUseCase extends BaseUseCase<LocalError,
   RelationshipWithPEPUseCaseParams, List<String>> {
  final RegisterRepository _registerRepository;

 RelationshipWithPEPUseCase(this._registerRepository);

  @override
  Future<Either<LocalError, List<String>>> execute(
      {required RelationshipWithPEPUseCaseParams params}) {
    return _registerRepository.getRelationshipWithPEPList();
  }
}

class RelationshipWithPEPUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

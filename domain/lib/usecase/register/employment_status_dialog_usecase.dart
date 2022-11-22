import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/register/register_step_three_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class EmploymentStatusDialogUseCase
    extends BaseUseCase<LocalError, EmploymentStatusDialogUseCaseParams, List<String>> {
  final RegisterStepThreeRepository _registerRepository;

  EmploymentStatusDialogUseCase(this._registerRepository);

  @override
  Future<Either<LocalError, List<String>>> execute({required EmploymentStatusDialogUseCaseParams params}) {
    return _registerRepository.getEmploymentStatusDialogList();
  }
}

class EmploymentStatusDialogUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

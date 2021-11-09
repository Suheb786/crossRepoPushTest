import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/register/register_step_four_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReviewApplicationUseCase extends BaseUseCase<LocalError,
    ReviewApplicationUseCaseParams, List<String>> {
  final RegisterStepFourRepository _registerRepository;

  ReviewApplicationUseCase(this._registerRepository);

  @override
  Future<Either<LocalError, List<String>>> execute(
      {required ReviewApplicationUseCaseParams params}) {
    return _registerRepository.getReviewApplicationDetails();
  }
}

class ReviewApplicationUseCaseParams extends Params {
  final bool declarationSelected;

  ReviewApplicationUseCaseParams({required this.declarationSelected});

  @override
  Either<AppError, bool> verify() {
    if (!declarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_DECLARATION_SELECTION,
          cause: Exception()));
    }
    return Right(true);
  }
}

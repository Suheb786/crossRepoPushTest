import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmDetailUseCase extends BaseUseCase<LocalError, ConfirmDetailUseCaseParams, bool> {
  @override
  Future<Either<LocalError, bool>> execute({required ConfirmDetailUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class ConfirmDetailUseCaseParams extends Params {
  final String name;
  final String idNumber;
  final String dateOfBirth;
  final String nationality;
  final String expiryDate;
  final String gender;

  ConfirmDetailUseCaseParams(
      {required this.name,
      required this.idNumber,
      required this.dateOfBirth,
      required this.nationality,
      required this.expiryDate,
      required this.gender});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

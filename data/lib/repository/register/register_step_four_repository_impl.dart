import 'package:dartz/dartz.dart';
import 'package:data/source/register/register_step_four_datasource.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/register/register_step_four_repository.dart';

class RegisterStepFourRepositoryImpl with RegisterStepFourRepository {
  final RegisterStepFourRemoteDataSource _registerRemoteDS;

  RegisterStepFourRepositoryImpl(this._registerRemoteDS);

  //get review application
  @override
  Future<Either<LocalError, List<String>>> getReviewApplicationDetails() async {
    final result = await _registerRemoteDS.getReviewApplicationDetails();
    return Right(result);
  }
}

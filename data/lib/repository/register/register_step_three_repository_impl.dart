import 'package:dartz/dartz.dart';
import 'package:data/source/register/register_step_three_datasource.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/register/register_step_three_repository.dart';

class RegisterStepThreeRepositoryImpl with RegisterStepThreeRepository {
  final RegisterStepThreeRemoteDataSource _registerRemoteDS;

  RegisterStepThreeRepositoryImpl(this._registerRemoteDS);

  //get nature of special needs list
  @override
  Future<Either<LocalError, List<String>>> getNatureOfSpecialNeedsList() async {
    final result = await _registerRemoteDS.getNatureOfSpecialNeedsList();
    return Right(result);
  }

  //get relationship with pep list
  @override
  Future<Either<LocalError, List<String>>> getRelationshipWithPEPList() async {
    final result = await _registerRemoteDS.getRelationshipWithPEPList();
    return Right(result);
  }

  //get employee status dialog list
  @override
  Future<Either<LocalError, List<String>>> getEmploymentStatusDialogList() async {
    final result = await _registerRemoteDS.getEmploymentStatusDialogList();
    return Right(result);
  }
}

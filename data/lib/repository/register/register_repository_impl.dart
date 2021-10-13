import 'package:dartz/dartz.dart';
import 'package:data/source/register/register_datasource.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/register/register_repository.dart';

class RegisterRepositoryImpl with RegisterRepository {
  final RegisterRemoteDataSource _registerRemoteDS;

  RegisterRepositoryImpl(this._registerRemoteDS);

  @override
  Future<Either<LocalError, List<String>>> getOccupationList() async {
    final result = await _registerRemoteDS.getOccupationList();
    return Right(result);
  }

  @override
  Future<Either<LocalError, List<String>>> getPurposeOfAccountOpeningList() async{
    final result = await _registerRemoteDS.getPurposeOfAccountOpeningList();
    return Right(result);
  }

  @override
  Future<Either<LocalError, List<String>>> getAdditionalIncomeSourceList() async{
    final result = await _registerRemoteDS.getAdditionalIncomeSourceList();
    return Right(result);
  }
}

import 'package:dartz/dartz.dart';
import 'package:data/source/utility/utility_datasource.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/utility/utility_repository.dart';

class UtilityRepositoryImpl extends UtilityRepository {
  final UtilityDataSource _dataSource;

  UtilityRepositoryImpl(this._dataSource);

  @override
  Future<Either<LocalError, bool>> checkDeviceCompatibility() async {
    bool compatible = await _dataSource.checkDeviceCompatibility();

    if (!compatible) {
      return Right(true);
    } else {
      return Left(
          LocalError(cause: Exception(), localError: 1212, message: ''));
    }
  }
}

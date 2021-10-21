import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';

abstract class RegisterRepository {
  Future<Either<LocalError, List<String>>> getOccupationList();

  Future<Either<LocalError, List<String>>> getPurposeOfAccountOpeningList();

  Future<Either<LocalError, List<String>>> getAdditionalIncomeSourceList();

}


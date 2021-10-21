import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/register/additional_income.dart';

abstract class RegisterRepository {
  Future<Either<LocalError, List<String>>> getOccupationList();

  Future<Either<LocalError, List<String>>> getPurposeOfAccountOpeningList();

  Future<Either<LocalError, List<AdditionalIncome>>>
      getAdditionalIncomeSourceList();

  Future<Either<LocalError, List<String>>> getNatureOfSpecialNeedsList();

  Future<Either<LocalError, List<String>>> getRelationshipWithPEPList();
}

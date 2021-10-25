import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';

abstract class RegisterStepThreeRepository {
  Future<Either<LocalError, List<String>>> getNatureOfSpecialNeedsList();

  Future<Either<LocalError, List<String>>> getRelationshipWithPEPList();

  Future<Either<LocalError, List<String>>> getEmploymentStatusDialogList();
}

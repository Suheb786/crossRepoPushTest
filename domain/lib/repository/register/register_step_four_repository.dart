import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';

abstract class RegisterStepFourRepository {
  Future<Either<LocalError, List<String>>> getReviewApplicationDetails();
}

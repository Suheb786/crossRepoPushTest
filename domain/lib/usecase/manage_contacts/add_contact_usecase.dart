import 'package:domain/error/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/usecase/base/params.dart';

class AddContactIBANuseCaseParams extends Params {
  final String name;
  final String emailAddress;
  final String IBANACCOUNTNOMobileNoALIAS;

  AddContactIBANuseCaseParams({
    required this.name,
    required this.emailAddress,
    required this.IBANACCOUNTNOMobileNoALIAS,
  });

  @override
  Either<AppError, bool> verify() {
    return right(true);
  }
}

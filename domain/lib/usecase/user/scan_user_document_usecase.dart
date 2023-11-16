import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ScanUserDocumentUseCase
    extends BaseUseCase<LocalError, ScanUserDocumentUseCaseParams, ScannedDocumentInformation> {
  final UserRepository _userRepository;

  ScanUserDocumentUseCase(this._userRepository);

  @override
  Future<Either<LocalError, ScannedDocumentInformation>> execute(
      {required ScanUserDocumentUseCaseParams params}) {
    ///TODO: Check when feature is enabled
    return Future.value(Right(ScannedDocumentInformation()));
  }
}

class ScanUserDocumentUseCaseParams extends Params {
  ScanUserDocumentUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

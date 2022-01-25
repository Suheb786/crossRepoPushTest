import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ApplySupplementaryDebitCardUseCase extends BaseUseCase<NetworkError,
    ApplySupplementaryDebitCardUseCaseParams, bool> {
  final CardRepository _repository;

  ApplySupplementaryDebitCardUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required ApplySupplementaryDebitCardUseCaseParams params}) {
    return _repository.applyDebitSupplementaryCard(
        nickName: params.nickName,
        relation: params.relationship,
        scannedDocumentInformation: params.scannedDocumentInformation);
  }
}

class ApplySupplementaryDebitCardUseCaseParams extends Params {
  final String nickName;
  final String relationship;
  final ScannedDocumentInformation scannedDocumentInformation;

  ApplySupplementaryDebitCardUseCaseParams(
      {required this.nickName,
      required this.relationship,
      required this.scannedDocumentInformation});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

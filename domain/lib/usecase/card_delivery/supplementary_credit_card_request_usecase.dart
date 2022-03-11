import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/repository/card/card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SupplementaryCreditCardRequestUseCase extends BaseUseCase<NetworkError,
    SupplementaryCreditCardRequestUseCaseParams, bool> {
  final CardRepository _repository;

  SupplementaryCreditCardRequestUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute(
      {required SupplementaryCreditCardRequestUseCaseParams params}) {
    return _repository.supplementaryCreditCardRequest(
      primaryCardId: params.primaryCard,
      relationship: params.relationship,
      doi: params.scannedDocumentInformation.issuingDate,
      type: "C",
      fullName: params.scannedDocumentInformation.fullName ?? '',
      firstName: params.scannedDocumentInformation.firstName ??
          params.scannedDocumentInformation.fullName!.split(' ').first,
      middleName: params.scannedDocumentInformation.middleName ?? '',
      familyName: params.scannedDocumentInformation.familyName ?? '',
      idNumber: params.scannedDocumentInformation.idNumber ?? '',
      dob: params.scannedDocumentInformation.dob.toString(),
      doe: params.scannedDocumentInformation.doe.toString(),
      gender: params.scannedDocumentInformation.gender![0].toUpperCase(),
      documentCode: params.scannedDocumentInformation.documentCode ?? 'I',
      documentNumber: params.scannedDocumentInformation.documentNumber ?? '',
      issuer: params.scannedDocumentInformation.issuingPlaceISo3 ?? '',
      nationality: params.scannedDocumentInformation.issuer ?? '',
      optionalData1: params.scannedDocumentInformation.optionalData1 ?? '',
      optionalData2: params.scannedDocumentInformation.optionalData2 ?? '',
      mrtDraw: params.scannedDocumentInformation.mrtDraw ?? '',
      frontCardImage: params.scannedDocumentInformation.frontCardImage ?? '',
      backCardImage: params.scannedDocumentInformation.backCardImage ?? '',
      nickName: params.nickName,
      sameLimit: params.sameLimit,
      limit: params.limit,
    );
  }
}

class SupplementaryCreditCardRequestUseCaseParams extends Params {
  final String primaryCard;
  final String nickName;
  final bool sameLimit;
  final num limit;
  final String relationship;
  final ScannedDocumentInformation scannedDocumentInformation;

  SupplementaryCreditCardRequestUseCaseParams(
      {required this.primaryCard,
      required this.relationship,
      required this.nickName,
      required this.sameLimit,
      required this.limit,
      required this.scannedDocumentInformation});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

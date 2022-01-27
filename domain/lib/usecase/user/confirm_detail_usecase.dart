import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class ConfirmDetailUseCase extends BaseUseCase<NetworkError,
    ConfirmDetailUseCaseParams, SaveIdInfoResponse> {
  final UserRepository _repository;

  ConfirmDetailUseCase(this._repository);

  @override
  Future<Either<NetworkError, SaveIdInfoResponse>> execute(
      {required ConfirmDetailUseCaseParams params}) {
    return _repository.saveIdInfo(
        type: params.scannedDocumentInformation!.type,
        fullName: params.name,
        firstName: params.scannedDocumentInformation!.firstName ?? '',
        middleName: params.scannedDocumentInformation!.middleName ?? '',
        familyName: params.scannedDocumentInformation!.familyName ?? '',
        idNumber: params.idNumber,
        dob: params.dateOfBirth,
        nationality: params.scannedDocumentInformation!.issuer ?? '',
        doe: params.expiryDate,
        gender: params.gender,
        motherName: params.motherName,
        documentCode: params.scannedDocumentInformation!.documentCode ?? '',
        documentNumber: params.legalDocumentNo,
        frontCardImage: params.scannedDocumentInformation!.frontCardImage ?? '',
        backCardImage: params.scannedDocumentInformation!.backCardImage ?? '',
        personFaceImage:
            params.scannedDocumentInformation!.personFaceImage ?? '',
        //issuer: params.scannedDocumentInformation!.issuer ?? '',
        issuer: params.issuingPlace ?? '',
        placeOfBirth: params.nationality ?? '',
        doi: params.issuingDate,
        scanPercentage:
            params.scannedDocumentInformation!.scanPercentage?.toDouble() ?? 0);
  }
}

class ConfirmDetailUseCaseParams extends Params {
  final String? name;
  final String? idNumber;
  final String? dateOfBirth;
  final String? nationality;
  final String? expiryDate;
  final String? gender;
  final String? motherName;
  final String? legalDocumentNo;
  final String? issuingDate;
  final String? issuingPlace;
  bool declarationSelected;
  final ScannedDocumentInformation? scannedDocumentInformation;
  final bool isMotherNameRequired;
  final bool isPlaceOfBirthRequired;
  final bool isCardIssueDateRequired;

  ConfirmDetailUseCaseParams(
      {required this.name,
      required this.idNumber,
      required this.dateOfBirth,
      required this.nationality,
      required this.expiryDate,
      required this.gender,
      this.issuingPlace,
      this.issuingDate,
      this.legalDocumentNo,
      required this.declarationSelected,
      this.scannedDocumentInformation,
      this.motherName,
      this.isPlaceOfBirthRequired: true,
      this.isCardIssueDateRequired: true,
      this.isMotherNameRequired: true});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(name!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_NAME,
          cause: Exception()));
    } else if (Validator.isEmpty(idNumber!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_ID_NUMBER,
          cause: Exception()));
    } else if (Validator.isEmpty(dateOfBirth!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_DATE_OF_BIRTH,
          cause: Exception()));
    } else if (Validator.isEmpty(nationality!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_NATIONALITY,
          cause: Exception()));
    } else if (Validator.isEmpty(expiryDate!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_EXPIRY_DATE,
          cause: Exception()));
    } else if (Validator.isEmpty(gender!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_GENDER,
          cause: Exception()));
    } else if (isMotherNameRequired && Validator.isEmpty(motherName!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_MOTHER_NAME,
          cause: Exception()));
    } else if (Validator.isEmpty(legalDocumentNo!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_LEGAL_DOCUMENT,
          cause: Exception()));
    } else if (isCardIssueDateRequired && Validator.isEmpty(issuingDate!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_ISSUING_DATE,
          cause: Exception()));
    } else if (Validator.isEmpty(issuingPlace!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_ISSUING_PLACE,
          cause: Exception()));
    } else if (!declarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_DECLARATION_SELECTION,
          cause: Exception()));
    }
    return Right(true);
  }
}

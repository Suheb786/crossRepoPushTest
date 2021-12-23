import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/upload_document/save_upload_document_response.dart';
import 'package:domain/repository/upload_document/upload_document_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:domain/utils/validator.dart';

class SendDocumentsUseCase extends BaseUseCase<NetworkError,
    SendDocumentsUseCaseParams,
    SaveUploadDocumentResponse> {
  final UploadDocumentRepository _repository;

  SendDocumentsUseCase(this._repository);

  @override
  Future<Either<NetworkError, SaveUploadDocumentResponse>> execute(
      {required SendDocumentsUseCaseParams params}) {
    return _repository.saveUploadDocument(
      proofOfAddressId: params.addressProof!,
      proofOfIncomeId: params.incomeProof!,
      proofOfNationalityId: params.nationalityProof!,
    );
  }
}

class SendDocumentsUseCaseParams extends Params {
  final String? incomeProof;
  final String? addressProof;
  final String? nationalityProof;
  final bool isOtherNationality;

  SendDocumentsUseCaseParams({this.incomeProof,
    this.addressProof,
    this.nationalityProof,
    required this.isOtherNationality});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(incomeProof!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_INCOME_DOCUMENT,
          cause: Exception()));
    } else if (Validator.isEmpty(addressProof!)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_ADDRESS_DOCUMENT,
          cause: Exception()));
    } else if (isOtherNationality && nationalityProof!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.EMPTY_NATIONALITY_DOCUMENT,
          cause: Exception()));
    } else {
      return Right(true);
    }
  }
}

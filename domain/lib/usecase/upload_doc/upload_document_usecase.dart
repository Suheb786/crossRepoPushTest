import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/upload_document/upload_document_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UploadDocumentUseCase extends BaseUseCase<BaseError, UploadDocumentUseCaseParams, String> {
  final UploadDocumentRepository _docRepository;

  UploadDocumentUseCase(this._docRepository);

  @override
  Future<Either<BaseError, String>> execute({UploadDocumentUseCaseParams? params}) {
    return _docRepository.pickUploadDocument(
        type: params!.documentType, cameraPhotoFile: params.cameraPhotoFile);
  }
}

class UploadDocumentUseCaseParams extends Params {
  final DocumentTypeEnum documentType;
  final String cameraPhotoFile;

  UploadDocumentUseCaseParams({required this.documentType, this.cameraPhotoFile = ''});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}

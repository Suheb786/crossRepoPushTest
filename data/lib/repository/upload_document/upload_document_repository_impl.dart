import 'package:dartz/dartz.dart';
import 'package:data/source/upload_document/upload_document_datasource.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/upload_document/upload_document_repository.dart';

class UploadDocumentRepositoryImpl extends UploadDocumentRepository {
  final UploadDocumentLocalDS _documentLocalDS;

  UploadDocumentRepositoryImpl(this._documentLocalDS);

  @override
  Future<Either<BaseError, String>> pickUploadDocument(
      {DocumentTypeEnum? type}) async {
    if (type == DocumentTypeEnum.CAMERA) {
      var imageList = await _documentLocalDS.clickDocumentImage();
      return Right(imageList);
    } else if (type == DocumentTypeEnum.GALLERY) {
      var imageList = await _documentLocalDS.pickUploadDocument();
      return Right(imageList);
    }
    return Right("");
  }
}

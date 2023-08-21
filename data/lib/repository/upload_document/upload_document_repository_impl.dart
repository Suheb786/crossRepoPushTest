import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/upload_document/upload_document_datasource.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/upload_document/file_upload_response.dart';
import 'package:domain/model/upload_document/save_upload_document_response.dart';
import 'package:domain/repository/upload_document/upload_document_repository.dart';

class UploadDocumentRepositoryImpl extends UploadDocumentRepository {
  final UploadDocumentLocalDS _documentLocalDS;
  final UploadDocumentRemoteDS _uploadDocumentRemoteDS;

  UploadDocumentRepositoryImpl(this._documentLocalDS, this._uploadDocumentRemoteDS);

  @override
  Future<Either<BaseError, String>> pickUploadDocument(
      {DocumentTypeEnum? type, String cameraPhotoFile = ''}) async {
    if (type == DocumentTypeEnum.CAMERA) {
      var imageList = await _documentLocalDS.clickDocumentImage(cameraPhotoFile);
      return Right(imageList);
    } else if (type == DocumentTypeEnum.GALLERY) {
      var imageList = await _documentLocalDS.pickUploadDocument();
      return Right(imageList);
    } else if (type == DocumentTypeEnum.PICK_IMAGE) {
      var imageList = await _documentLocalDS.pickImage();
      if (imageList.endsWith('.gif')) {
        return Left(LocalError(message: '', localError: 1214, cause: Exception()));
      }
      return Right(imageList);
    }
    return Right("");
  }

  @override
  Future<Either<NetworkError, FileUploadResponse>> uploadDocument({String? path}) async {
    final result = await safeApiCall(
      _uploadDocumentRemoteDS.uploadDocument(path: path!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, SaveUploadDocumentResponse>> saveUploadDocument(
      {String? proofOfIncomeId, String? proofOfAddressId, String? proofOfNationalityId}) async {
    final result = await safeApiCall(
      _uploadDocumentRemoteDS.saveUploadDocument(
          proofOfIncomeId: proofOfIncomeId,
          proofOfAddressId: proofOfAddressId,
          proofOfNationalityId: proofOfNationalityId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}

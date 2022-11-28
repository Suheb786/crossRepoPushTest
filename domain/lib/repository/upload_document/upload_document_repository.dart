import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/upload_document/file_upload_response.dart';
import 'package:domain/model/upload_document/save_upload_document_response.dart';

abstract class UploadDocumentRepository {
  Future<Either<BaseError, String>> pickUploadDocument({DocumentTypeEnum type});

  Future<Either<NetworkError, FileUploadResponse>> uploadDocument({String path});

  Future<Either<NetworkError, SaveUploadDocumentResponse>> saveUploadDocument(
      {String proofOfIncomeId, String proofOfAddressId, String proofOfNationalityId});
}

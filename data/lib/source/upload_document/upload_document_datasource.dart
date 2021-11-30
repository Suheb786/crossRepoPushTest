import 'package:data/entity/remote/upload_document/save_upload_document_response_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_response_entity.dart';
import 'package:retrofit/dio.dart';

abstract class UploadDocumentLocalDS {
  Future<String> pickUploadDocument();

  Future<String> clickDocumentImage();
}

abstract class UploadDocumentRemoteDS {
  Future<HttpResponse<UploadDocumentResponseEntity>> uploadDocument(
      {String path});

  Future<HttpResponse<SaveUploadDocumentResponseEntity>> saveUploadDocument(
      {String? proofOfIncomeId,
      String? proofOfAddressId,
      String? proofOfNationalityId});
}

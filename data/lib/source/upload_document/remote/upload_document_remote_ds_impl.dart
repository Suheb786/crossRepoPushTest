import 'dart:io';

import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/upload_document/save_upload_document_request_entity.dart';
import 'package:data/entity/remote/upload_document/save_upload_document_response_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_request_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/upload_document/upload_document_datasource.dart';
import 'package:retrofit/dio.dart';

class UploadDocumentRemoteDSImpl extends UploadDocumentRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  UploadDocumentRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<UploadDocumentResponseEntity>> uploadDocument(
      {String? path}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.uploadDocument(UploadDocumentRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        documentBase64: ImageUtils.convertToBase64(path!)));
  }

  @override
  Future<HttpResponse<SaveUploadDocumentResponseEntity>> saveUploadDocument(
      {String? proofOfIncomeId,
      String? proofOfAddressId,
      String? proofOfNationalityId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveUploadDocument(SaveUploadDocumentRequestEntity(
        baseData: baseData.toJson(),
        getToken: true,
        proofOfIncomeId: proofOfIncomeId,
        proofOfAddressId: proofOfAddressId,
        proofOfNationalityId: proofOfNationalityId));
  }
}

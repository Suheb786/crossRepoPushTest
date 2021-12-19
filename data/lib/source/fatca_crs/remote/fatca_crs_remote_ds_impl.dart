import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/save_fatca_information_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/fatca_crs/fatca_crs_datasource.dart';
import 'package:retrofit/dio.dart';

class FatcaCrsRemoteDSImpl extends FatcaCrsRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  FatcaCrsRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<GetFatcaQuestionsResponseEntity>> getFatcaQuestions(
      {bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getFatcaQuestions(GetFatcaQuestionsRequestEntity(
        baseData: baseData.toJson(), getToken: true));
  }

  @override
  Future<HttpResponse<SetFatcaQuestionsResponseEntity>> saveFatcaInformation(
      {bool? response1,
        bool? response2,
        bool? response3,
        bool? response4,
        bool? response5,
        String? relationshipWithPep,
        String? personName,
        String? personRole,
        bool? isTinNoRes4,
        String? taxResidenceCountry,
        String? tinNoRes4,
        String? reasonUnavailableRes4,
        String? reasonBRes4,
        bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveFatcaInformation(SaveFatcaInformationRequestEntity(
        response1: response1,
        response2: response2,
        response3: response3,
        response4: response4,
        response5: response5,
        relationshipWithPEP: relationshipWithPep ?? '',
        personName: personName ?? '',
        personRole: personRole ?? '',
        isTinNoRes4: isTinNoRes4,
        taxResidenceCountry: taxResidenceCountry,
        tinNoRes4: tinNoRes4,
        reasonUnavailableRes4: reasonUnavailableRes4,
        reasonBRes4: reasonBRes4,
        baseData: baseData.toJson(),
        getToken: getToken));
  }

  @override
  Future<HttpResponse<UploadSignatureResponseEntity>> uploadSignature(
      {String? image}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.uploadSignature(UploadSignatureRequestEntity(
        baseData: baseData.toJson(),
        image: ImageUtils.convertToBase64(image!)));
  }
}

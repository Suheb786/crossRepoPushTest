import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/save_fatca_information_request_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/fatca_crs/fatca_crs_datasource.dart';

class FatcaCrsRemoteDSImpl extends FatcaCrsRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  FatcaCrsRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<String> getFatcaQuestions({bool? getToken}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.getFatcaQuestions(
        GetFatcaQuestionsRequestEntity(baseData: baseData, getToken: getToken));
  }

  @override
  Future<String> saveFatcaInformation(
      {String? response1,
      String? response2,
      String? response3,
      String? response4,
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
        isTinNoRes4: isTinNoRes4,
        taxResidenceCountry: taxResidenceCountry,
        tinNoRes4: tinNoRes4,
        reasonUnavailableRes4: reasonUnavailableRes4,
        reasonBRes4: reasonBRes4,
        baseData: baseData,
        getToken: getToken));
  }
}

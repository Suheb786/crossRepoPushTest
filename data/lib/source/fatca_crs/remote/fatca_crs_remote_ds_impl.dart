import 'package:data/entity/local/base/device_helper.dart';
import 'package:data/entity/local/base/image_utils.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/save_fatca_information_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_w8_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_w9_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/network/api_service.dart';
import 'package:data/source/fatca_crs/fatca_crs_datasource.dart';
import 'package:retrofit/dio.dart';

class FatcaCrsRemoteDSImpl extends FatcaCrsRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;

  FatcaCrsRemoteDSImpl(this._apiService, this._deviceInfoHelper);

  @override
  Future<HttpResponse<GetFatcaQuestionsResponseEntity>> getFatcaQuestions() async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService
        .getFatcaQuestions(GetFatcaQuestionsRequestEntity(baseData: baseData.toJson(), getToken: true));
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
      String? taxResidenceCountry}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveFatcaInformation(SaveFatcaInformationRequestEntity(
        response1: response1 ?? false,
        response2: response2 ?? false,
        response3: response3 ?? false,
        response4: response4 ?? false,
        response5: response5 ?? false,
        relationshipWithPEP: relationshipWithPep ?? '',
        personName: personName ?? '',
        personRole: personRole ?? '',
        taxResidenceCountry: taxResidenceCountry ?? "",
        baseData: baseData.toJson(),
        getToken: true));
  }

  @override
  Future<HttpResponse<UploadSignatureResponseEntity>> uploadSignature({String? image}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.uploadSignature(
        UploadSignatureRequestEntity(baseData: baseData.toJson(), image: ImageUtils.convertToBase64(image!)));
  }

  @override
  Future<HttpResponse<ResponseEntity>> saveFatcaW8(
      {String? nameIncomeTaxReturn,
      String? dateOfBirth,
      String? citizenShipCountry,
      String? permanentResidenceAddress,
      String? countryIsoCode,
      String? cityId,
      String? stateId,
      String? postCode,
      bool? isDifferentMailingAddress,
      String? mailingAddressLine,
      String? differentMailingCountry,
      String? differentMailingState,
      String? differentMailingCity,
      String? differentMailingPostCode,
      String? taxPayer,
      String? usTaxPayerTin,
      String? foreignTaxPayerTin,
      String? referenceNumber,
      bool? isClaimedTaxTreatBenefits,
      String? beneficialOwnerResident,
      String? provisionOrClaim,
      String? treatyClaimRate,
      String? typeOfIncome,
      String? explanation,
      String? signatureId}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveFatcaW8(SetFatcaW8RequestEntity(
      nameIncomeTAXReturn: nameIncomeTaxReturn,
      dateOfBirth: dateOfBirth,
      citizenShipCountry: citizenShipCountry,
      permanentResidenceAddress: permanentResidenceAddress,
      countryIsoCode: countryIsoCode,
      cityId: cityId,
      stateId: stateId,
      postCode: postCode,
      isDifferentMailingAddress: isDifferentMailingAddress,
      mailingAddressLine: mailingAddressLine,
      differentMailingCountryIsoCode: differentMailingCountry,
      differentMailingStateID: differentMailingState,
      differentMailingCityId: differentMailingCity,
      differentMailingPostCode: differentMailingPostCode,
      taxPayer: taxPayer,
      usTaxPayerTin: usTaxPayerTin,
      foreignTaxPayerTin: foreignTaxPayerTin,
      referenceNumber: referenceNumber,
      isClaimedTaxTreatBenefits: isClaimedTaxTreatBenefits,
      beneficialOwnerResidentIsoCode: beneficialOwnerResident,
      treatyClaimRate: treatyClaimRate,
      explanation: explanation,
      provisionOrClaim: provisionOrClaim,
      typeOfIncome: typeOfIncome,
      signatureId: signatureId,
      getToken: true,
      baseData: baseData.toJson(),
    ));
  }

  @override
  Future<HttpResponse<ResponseEntity>> saveFatcaW9(
      {String? namePerIncomeTaxReturn,
      String? businessName,
      String? usAddress,
      String? city,
      String? state,
      String? postCode,
      String? accountNumberList,
      String? exemptPayeeCode,
      String? exemptFromFatcaReportingCode,
      bool? additionalRequester,
      String? requesterName,
      String? requesterUsAddress,
      String? requesterCity,
      String? requesterState,
      String? requesterPostCode,
      String? taxPayer,
      String? socialSecurityNumber,
      String? employerTin,
      String? signatureId,
      String? countryCode,
      String? requesterCountryCode}) async {
    BaseClassEntity baseData = await _deviceInfoHelper.getDeviceInfo();
    return _apiService.saveFatcaW9(SetFatcaW9RequestEntity(
      namePerIncomeTaxReturn: namePerIncomeTaxReturn,
      businessName: businessName,
      uSAddress: usAddress,
      countryCode: countryCode,
      cityId: city,
      stateId: state,
      postCode: postCode,
      accountNumberList: accountNumberList,
      exemptPayeeCode: exemptPayeeCode,
      exemptFromFatcaReportingCode: exemptFromFatcaReportingCode,
      isAdditionalRequester: additionalRequester,
      requesterName: requesterName,
      requesterUSAddress: requesterUsAddress,
      requesterCountryCode: requesterCountryCode,
      requesterCity: requesterCity,
      requesterState: requesterState,
      requesterPostCode: requesterPostCode,
      taxPayer: taxPayer,
      socialSecurityNumber: socialSecurityNumber,
      employerTIN: employerTin,
      signatureId: signatureId,
      getToken: true,
      baseData: baseData.toJson(),
    ));
  }
}

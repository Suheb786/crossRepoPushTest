import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class FatcaCrsRemoteDS {
  Future<HttpResponse<GetFatcaQuestionsResponseEntity>> getFatcaQuestions();

  Future<HttpResponse<SetFatcaQuestionsResponseEntity>> saveFatcaInformation(
      {bool response1,
      bool response2,
      bool response3,
      bool response4,
      bool response5,
      String? relationshipWithPep,
      String? personName,
      String? personRole,
      String? taxResidenceCountry});

  Future<HttpResponse<UploadSignatureResponseEntity>> uploadSignature({String image});

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
      String? signatureId});

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
      String? requesterCountryCode});
}

abstract class FatcaCrsLocalDS {}

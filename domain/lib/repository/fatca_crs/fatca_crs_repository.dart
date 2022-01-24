import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/set_fatca_response.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';

abstract class FatcaCrsRepository {
  /// retrieve fatca questions
  Future<Either<NetworkError, GetFatcaQuestionsResponse>> getFatcaQuestions();

  /// save fatca information
  Future<Either<NetworkError, SetFatcResponse>> saveFatcaInformation(
      {required bool response1,
      required bool response2,
      required bool response3,
      required bool response4,
      required bool response5,
      String relationshipWithPep,
      String personName,
      String personRole,
      String taxResidenceCountry});

  /// upload signature
  Future<Either<NetworkError, UploadSignatureResponse>> uploadSignature(
      {required String image});

  /// set fatca w8
  Future<Either<NetworkError, bool>> saveFatcaW8({
    String nameIncomeTaxReturn,
    String dateOfBirth,
    String citizenShipCountry,
    String permanentResidenceAddress,
    String countryIsoCode,
    String cityId,
    String stateId,
    String postCode,
    bool isDifferentMailingAddress,
    String mailingAddressLine,
    String differentMailingCountry,
    String differentMailingState,
    String differentMailingCity,
    String differentMailingPostCode,
    String taxPayer,
    String usTaxPayerTin,
    String foreignTaxPayerTin,
    String referenceNumber,
    bool isClaimedTaxTreatBenefits,
    String beneficialOwnerResident,
    String provisionOrClaim,
    String treatyClaimRate,
    String typeOfIncome,
    String explanation,
    String signatureId,
  });

  /// set fatca w9
  Future<Either<NetworkError, bool>> saveFatcaW9({
    String namePerIncomeTaxReturn,
    String businessName,
    String usAddress,
    String city,
    String state,
    String postCode,
    String accountNumberList,
    String exemptPayeeCode,
    String exemptFromFatcaReportingCode,
    bool additionalRequester,
    String requesterName,
    String requesterUsAddress,
    String requesterCity,
    String requesterState,
    String requesterPostCode,
    String taxPayer,
    String socialSecurityNumber,
    String employerTin,
    String signatureId,
  });
}

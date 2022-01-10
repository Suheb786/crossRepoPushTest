import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/fatca_crs/fatca_crs_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/set_fatca_response.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';

class FatcaCrsRepositoryImpl extends FatcaCrsRepository {
  final FatcaCrsRemoteDS _crsRemoteDS;

  FatcaCrsRepositoryImpl(this._crsRemoteDS);

  @override
  Future<Either<NetworkError, GetFatcaQuestionsResponse>> getFatcaQuestions(
      {required bool getToken}) async {
    final result = await safeApiCall(
      _crsRemoteDS.getFatcaQuestions(getToken: getToken),
    );
    return result!.fold(
        (l) => Left(l),
        (r) => Right(
              (r.data.transform()),
            ));
  }

  @override
  Future<Either<NetworkError, SetFatcResponse>> saveFatcaInformation(
      {required bool response1,
      required bool response2,
      required bool response3,
      required bool response4,
      required bool response5,
      String? relationshipWithPep,
      String? personName,
      String? personRole,
      String? taxResidenceCountry,
      required bool getToken}) async {
    final result = await safeApiCall(
      _crsRemoteDS.saveFatcaInformation(
          response1: response1,
          response2: response2,
          response3: response3,
          response4: response4,
          response5: response5,
          relationshipWithPep: relationshipWithPep,
          personRole: personRole,
          personName: personName,
          taxResidenceCountry: taxResidenceCountry,
          getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, UploadSignatureResponse>> uploadSignature(
      {required String image}) async {
    final result = await safeApiCall(
      _crsRemoteDS.uploadSignature(image: image),
    );
    return result!.fold(
        (l) => Left(l),
        (r) => Right(
              (r.data.transform()),
            ));
  }

  @override
  Future<Either<NetworkError, bool>> saveFatcaW8(
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
    final result = await safeApiCall(
      _crsRemoteDS.saveFatcaW8(
          nameIncomeTaxReturn: nameIncomeTaxReturn,
          dateOfBirth: dateOfBirth,
          citizenShipCountry: citizenShipCountry,
          permanentResidenceAddress: permanentResidenceAddress,
          countryIsoCode: countryIsoCode,
          cityId: cityId,
          stateId: stateId,
          postCode: postCode,
          isDifferentMailingAddress: isDifferentMailingAddress,
          mailingAddressLine: mailingAddressLine,
          differentMailingCountry: differentMailingCountry,
          differentMailingState: differentMailingState,
          differentMailingCity: differentMailingCity,
          differentMailingPostCode: differentMailingPostCode,
          taxPayer: taxPayer,
          usTaxPayerTin: usTaxPayerTin,
          foreignTaxPayerTin: foreignTaxPayerTin,
          referenceNumber: referenceNumber,
          isClaimedTaxTreatBenefits: isClaimedTaxTreatBenefits,
          beneficialOwnerResident: beneficialOwnerResident,
          provisionOrClaim: provisionOrClaim,
          treatyClaimRate: treatyClaimRate,
          typeOfIncome: typeOfIncome,
          explanation: explanation,
          signatureId: signatureId),
    );
    return result!.fold(
        (l) => Left(l),
        (r) => Right(
              (r.isSuccessful()),
            ));
  }

  @override
  Future<Either<NetworkError, bool>> saveFatcaW9(
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
      String? signatureId}) async {
    final result = await safeApiCall(
      _crsRemoteDS.saveFatcaW9(
          namePerIncomeTaxReturn: namePerIncomeTaxReturn,
          businessName: businessName,
          usAddress: usAddress,
          city: city,
          state: state,
          postCode: postCode,
          accountNumberList: accountNumberList,
          exemptPayeeCode: exemptPayeeCode,
          exemptFromFatcaReportingCode: exemptFromFatcaReportingCode,
          additionalRequester: additionalRequester,
          requesterName: requesterName,
          requesterUsAddress: requesterUsAddress,
          requesterCity: requesterCity,
          requesterState: requesterState,
          requesterPostCode: requesterPostCode,
          taxPayer: taxPayer,
          socialSecurityNumber: socialSecurityNumber,
          employerTin: employerTin,
          signatureId: signatureId),
    );
    return result!.fold(
        (l) => Left(l),
        (r) => Right(
              (r.isSuccessful()),
            ));
  }
}

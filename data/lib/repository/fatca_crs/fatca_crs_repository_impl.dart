import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/fatca_crs/fatca_crs_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/set_fatca_questions_response.dart';
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
  Future<Either<NetworkError, SetFatcaQuestionsResponse>> saveFatcaInformation(
      {required bool response1,
      required bool response2,
      required bool response3,
      required bool response4,
      bool? isTinNoRes4,
      String? taxResidenceCountry,
      String? tinNoRes4,
      String? reasonUnavailableRes4,
      String? reasonBRes4,
      required bool getToken}) async {
    final result = await safeApiCall(
      _crsRemoteDS.saveFatcaInformation(
          response1: response1,
          response2: response2,
          response3: response3,
          response4: response4,
          isTinNoRes4: isTinNoRes4,
          taxResidenceCountry: taxResidenceCountry,
          tinNoRes4: tinNoRes4,
          reasonUnavailableRes4: reasonUnavailableRes4,
          reasonBRes4: reasonBRes4,
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
}

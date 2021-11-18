import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/fatca_crs/fatca_crs_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';

class FatcaCrsRepositoryImpl extends FatcaCrsRepository {
  final FatcaCrsRemoteDS _crsRemoteDS;

  FatcaCrsRepositoryImpl(this._crsRemoteDS);

  @override
  Future<Either<NetworkError, String>> getFatcaQuestions(
      {required bool getToken}) async {
    final result = await safeApiCall(
      _crsRemoteDS.getFatcaQuestions(getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<NetworkError, String>> saveFatcaInformation(
      {required String response1,
      required String response2,
      required String response3,
      required String response4,
      required bool isTinNoRes4,
      required String taxResidenceCountry,
      required String tinNoRes4,
      required String reasonUnavailableRes4,
      required String reasonBRes4,
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
      (r) => Right(r),
    );
  }
}

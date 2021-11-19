import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class FatcaCrsRepository {
  /// retrieve fatca questions
  Future<Either<NetworkError, String>> getFatcaQuestions(
      {required bool getToken});

  /// save fatca information
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
      required bool getToken});
}

import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/set_fatca_questions_response.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';

abstract class FatcaCrsRepository {
  /// retrieve fatca questions
  Future<Either<NetworkError, GetFatcaQuestionsResponse>> getFatcaQuestions(
      {required bool getToken});

  /// save fatca information
  Future<Either<NetworkError, SetFatcaQuestionsResponse>> saveFatcaInformation(
      {required bool response1,
      required bool response2,
      required bool response3,
      required bool response4,
      bool isTinNoRes4,
      String taxResidenceCountry,
      String tinNoRes4,
      String reasonUnavailableRes4,
      String reasonBRes4,
      required bool getToken});

  /// upload signature
  Future<Either<NetworkError, UploadSignatureResponse>> uploadSignature(
      {required String image});
}

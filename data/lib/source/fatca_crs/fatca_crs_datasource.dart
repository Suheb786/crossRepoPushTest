import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class FatcaCrsRemoteDS {
  Future<HttpResponse<GetFatcaQuestionsResponseEntity>> getFatcaQuestions(
      {bool getToken});

  Future<HttpResponse<SetFatcaQuestionsResponseEntity>> saveFatcaInformation(
      {bool response1,
      bool response2,
      bool response3,
      bool response4,
      bool response5,
      String? relationshipWithPep,
      String? personName,
      String? personRole,
      bool? isTinNoRes4,
      String? taxResidenceCountry,
      String? tinNoRes4,
      String? reasonUnavailableRes4,
      String? reasonBRes4,
      bool getToken});

  Future<HttpResponse<UploadSignatureResponseEntity>> uploadSignature(
      {String image});
}

abstract class FatcaCrsLocalDS {}

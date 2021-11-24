import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class FatcaCrsRemoteDS {
  Future<HttpResponse<GetFatcaQuestionsResponseEntity>> getFatcaQuestions(
      {bool getToken});

  Future<String> saveFatcaInformation(
      {String response1,
      String response2,
      String response3,
      String response4,
      bool isTinNoRes4,
      String taxResidenceCountry,
      String tinNoRes4,
      String reasonUnavailableRes4,
      String reasonBRes4,
      bool getToken});
}

abstract class FatcaCrsLocalDS {}

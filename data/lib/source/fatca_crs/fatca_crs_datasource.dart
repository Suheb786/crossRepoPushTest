abstract class FatcaCrsRemoteDS {
  Future<String> getFatcaQuestions({bool getToken});

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

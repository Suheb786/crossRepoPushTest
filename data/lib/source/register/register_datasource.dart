abstract class RegisterRemoteDataSource {
  Future<List<String>> getOccupationList();

  Future<List<String>> getPurposeOfAccountOpeningList();

  Future<List<String>> getAdditionalIncomeSourceList();
}

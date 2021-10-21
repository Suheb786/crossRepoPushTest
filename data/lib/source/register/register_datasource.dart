import 'package:domain/model/register/additional_income.dart';

abstract class RegisterRemoteDataSource {
  Future<List<String>> getOccupationList();

  Future<List<String>> getPurposeOfAccountOpeningList();

  Future<List<AdditionalIncome>> getAdditionalIncomeSourceList();
}

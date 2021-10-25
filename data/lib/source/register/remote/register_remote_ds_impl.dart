import 'package:data/source/register/register_datasource.dart';
import 'package:domain/model/register/additional_income.dart';

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  @override
  Future<List<String>> getOccupationList() {
    return Future.value([
      'Accountant',
      'Actor',
      'Aerospace Engineer',
      'Agricultural Consultant',
      'Army',
      'Engineer',
      'Technician',
      'Software Developer',
      'Teacher',
      'Pharmacist',
      'Biomedical Engineer',
      'Psychologist',
      'Scientist',
      'Veterinarian',
      'Consultant',
      'Architect',
      'Radiographer'
    ]);
  }

  @override
  Future<List<String>> getPurposeOfAccountOpeningList() {
    return Future.value([
      'Savings',
      'Salary',
      'Investment',
      'Loan Repayment',
    ]);
  }

  @override
  Future<List<AdditionalIncome>> getAdditionalIncomeSourceList() {
    return Future.value([
      AdditionalIncome(type: 'Additional Salary'),
      AdditionalIncome(type: 'Bonus, Incentive & Commission'),
      AdditionalIncome(type: 'Rental Income'),
      AdditionalIncome(type: 'Investments'),
      AdditionalIncome(type: 'Own Business'),
      AdditionalIncome(type: 'Other'),
    ]);
  }
}

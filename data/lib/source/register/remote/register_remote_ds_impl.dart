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
      'Salary Transfer',
      'Normal Daily Banking',
      'Saving',
      'Credit Card',
      'Facilities',
      'Others'
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
      AdditionalIncome(type: 'Family Allowance'),
      AdditionalIncome(type: 'Other'),
    ]);
  }

  @override
  Future<List<String>> getBusinessTypeList() {
    return Future.value([
      'Car Dealership',
      'Jewelery Business',
      'Law Firm',
      'Gas Station',
      'Bakery',
      'Exchange House',
      'Real Estate',
      'Audit & Accounting Firm',
      'Other'
    ]);
  }
}

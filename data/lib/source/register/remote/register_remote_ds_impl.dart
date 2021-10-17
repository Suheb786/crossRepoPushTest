import 'package:data/source/register/register_datasource.dart';

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
      'Agricultural Consultant',
      'Loan Repayment',
    ]);
  }

  @override
  Future<List<String>> getAdditionalIncomeSourceList() {
    return Future.value([
      'Freelance Designer',
      'Investment',
      'Rental Income',
      'Part Time Lecturer'
    ]);
  }

  @override
  Future<List<String>> getNatureOfSpecialNeedsList() {
    return Future.value(["Communication", "Movement", "Self-care"]);
  }

  @override
  Future<List<String>> getRelationshipWithPEPList() {
    return Future.value([
      "Father",
      "Mother",
      "Sister",
      "Brother",
      "Daughter",
      "Son",
      "Father-in-Law",
      "Mother-in-Law"
    ]);
  }
}

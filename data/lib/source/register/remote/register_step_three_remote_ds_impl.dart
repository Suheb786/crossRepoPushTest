import 'package:data/source/register/register_step_three_datasource.dart';

class RegisterStepThreeRemoteDataSourceImpl
    extends RegisterStepThreeRemoteDataSource {
  @override
  Future<List<String>> getNatureOfSpecialNeedsList() {
    return Future.value(["Physical", "Sensory", "Motion"]);
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

  @override
  Future<List<String>> getEmploymentStatusDialogList() {
    return Future.value([
      "Retired",
      "Student",
      "Unemployed",
      "Other",
    ]);
  }
}

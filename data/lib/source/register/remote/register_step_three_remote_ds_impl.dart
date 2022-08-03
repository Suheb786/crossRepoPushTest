import 'package:data/source/register/register_step_three_datasource.dart';
import 'package:intl/intl.dart';

class RegisterStepThreeRemoteDataSourceImpl extends RegisterStepThreeRemoteDataSource {
  @override
  Future<List<String>> getNatureOfSpecialNeedsList() {
    List<String> naturalOfSNEn = ["Physical", "Sensory", "Motion"];
    List<String> naturalOfSNAr = ["جسدي", "حسي", "حركي"];

    return Future.value(Intl.getCurrentLocale() == 'en' ? naturalOfSNEn : naturalOfSNAr);
  }

  @override
  Future<List<String>> getRelationshipWithPEPList() {
    return Future.value(
        ["Father", "Mother", "Sister", "Brother", "Daughter", "Son", "Father-in-Law", "Mother-in-Law"]);
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

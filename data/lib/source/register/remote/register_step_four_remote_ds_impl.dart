import 'package:data/source/register/register_step_four_datasource.dart';

class RegisterStepFourRemoteDataSourceImpl
    extends RegisterStepFourRemoteDataSource {
  @override
  Future<List<String>> getReviewApplicationDetails() {
    return Future.value([
      "Retired",
      "Student",
      "Unemployed",
      "Other",
    ]);
  }
}

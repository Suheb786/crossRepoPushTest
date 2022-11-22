import 'package:domain/model/user/get_combo_values/get_combo_values_data.dart';

class GetComboValuesContentData {
  final List<GetComboValuesData>? employmentStatus;
  final List<GetComboValuesData>? natureOfSpecialNeed;
  final List<GetComboValuesData>? businessType;

  GetComboValuesContentData({this.employmentStatus, this.natureOfSpecialNeed, this.businessType});
}

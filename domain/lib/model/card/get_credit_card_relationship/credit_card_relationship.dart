import 'package:domain/model/user/get_combo_values/get_combo_values_data.dart';

class CreditCardRelationship {
  final List<GetComboValuesData>? relationShip;
  final num? minLimit;
  final num? maxLimit;

  CreditCardRelationship({this.relationShip, this.maxLimit: 0.0, this.minLimit: 0.0});
}

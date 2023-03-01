import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_view_model.dart';

class SelectedBillsToPaidWidgetViewModel extends BaseViewModel {
  final TextEditingController amtController = TextEditingController()
    ..text = '0.0';
}

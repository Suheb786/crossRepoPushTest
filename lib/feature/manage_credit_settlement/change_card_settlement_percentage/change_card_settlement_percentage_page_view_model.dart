import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ChangeCardSettlementPercentagePageViewModel extends BasePageViewModel {
  ///controllers and keys
  final TextEditingController settlementPercentageController =
  TextEditingController();
  final GlobalKey<AppTextFieldState> settlementPercentageKey =
  GlobalKey(debugLabel: "settlementPercentage");

  List<String> percentageList = ["3 %", "5 %", "7 %", "10 %"];

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void validate() {
    if (settlementPercentageController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }
}

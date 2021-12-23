import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';

class EditTransactionPurposeDialogViewModel extends BasePageViewModel {
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();
  final GlobalKey<AppTextFieldState> purposeKey =
      GlobalKey(debugLabel: "purpose");
  final GlobalKey<AppTextFieldState> purposeDetailKey =
      GlobalKey(debugLabel: "purposeDetail");

  EditTransactionPurposeDialogViewModel() {
    this.purposeController.text = "Personal";
    this.purposeDetailController.text = "Transfer to Friend or Family";
  }

  void updatePurposeDetail(String value) {
    purposeDetailController.text = value;
  }

  void updatePurpose(String value) {
    purposeController.text = value;
  }
}

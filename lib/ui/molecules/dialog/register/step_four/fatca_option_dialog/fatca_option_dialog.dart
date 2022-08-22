import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/fatca_option_dialog/fatca_option_dialog_view.dart';

class FatcaOptionDialog {
  FatcaOptionDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(AdditionalDataDropDownData)? onSelected,
      List<AdditionalDataDropDownData>? fatcaOptionData,
      String? title,
      String? titleAr}) {
    AppDialog.show(mContext,
        builder: (context) => FatcaOptionDialogView(
            onDismissed: onDismissed,
            dropDownData: fatcaOptionData!,
            onSelected: onSelected,
            title: title,
            titleAr: titleAr));
  }
}

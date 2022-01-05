import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog_view.dart';

class RelationshipWithCardHolderDialog {
  RelationshipWithCardHolderDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(String)? onSelected,
      required String title,
      required final List<String> relationSHipWithCardHolder}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => RelationshipWithCardHolderDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            relationSHipWithCardHolder: relationSHipWithCardHolder,
            title: title));
  }
}

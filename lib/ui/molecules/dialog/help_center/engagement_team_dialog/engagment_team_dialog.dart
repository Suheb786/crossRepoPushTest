import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagement_team_dialog_view.dart';

class EngagementTeamDialog {
  EngagementTeamDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => EngagementTeamDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/di/debit_card_settings/debit_card_settings_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/report_stolen_debit_card/report_stolen_debit_card_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ReportStolenDebitCardDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function()? onSelected;

  const ReportStolenDebitCardDialogView({this.onDismissed, this.onSelected});

  ProviderBase providerBase() {
    return reportStolenDebitCardDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ReportStolenDebitCardDialogViewModel>(
        builder: (context, model, child) {
          return GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                onDismissed?.call();
              }
            },
            child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                insetPadding:
                    EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 407),
                child: Padding(
                  padding: EdgeInsets.only(top: 35, left: 24, right: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppSvg.asset(AssetUtils.stolenCard),
                        Padding(
                          padding: EdgeInsets.only(top: 19),
                          child: Text(
                            S.of(context).reportCardIssue,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Text(
                            S.of(context).reportStolenCardInfo,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.dark_brown),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: InkWell(
                            onTap: () {
                              onSelected!();
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: 57,
                              width: 57,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .accentTextTheme
                                      .bodyText1!
                                      .color!),
                              child: AppSvg.asset(AssetUtils.tick,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                          child: Center(
                            child: Text(
                              S.of(context).swipeDownToCancel,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.dark_gray_1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
        providerBase: providerBase());
  }
}

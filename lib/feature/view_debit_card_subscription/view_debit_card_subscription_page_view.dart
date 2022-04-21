import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/view_debit_card_subscription/view_debit_card_subscription_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/view_debit_card_subscription/view_debit_card_subscription_widget.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ViewDebitCardSubscriptionPageView
    extends BasePageViewWidget<ViewDebitCardSubscriptionViewModel> {
  ViewDebitCardSubscriptionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsets.only(top: 52),
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            int sensitivity = 8;
            if (details.primaryVelocity! > sensitivity) {
              Navigator.pop(context);
            } else if (details.primaryVelocity! < -sensitivity) {}
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.0),
                child: Center(
                  child: Text(
                    S.of(context).viewCardSubSubscription,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 4,
                              width: 64,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColor.whiteGray),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 44.0, left: 24, right: 38),
                            child: Row(
                              children: [
                                Text(
                                  "6 " + S.of(context).subscription,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "513.23",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2, top: 4),
                                      child: Text(
                                        "JOD/YR",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.gray1),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 24, right: 24),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return ViewDebitCardSubscriptionWidget();
                                },
                                shrinkWrap: true,
                                itemCount: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

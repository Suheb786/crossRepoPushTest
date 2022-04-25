import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/subscription/subscription_dialog_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class SubscriptionDialogView extends StatelessWidget {
  final Function? onSelected;
  final Function? onDismissed;

  const SubscriptionDialogView({this.onSelected, this.onDismissed});

  ProviderBase providerBase() {
    return subscriptionDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SubscriptionDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(top: 116, bottom: 56, left: 23, right: 23),
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      FadingEdgeScrollView.fromSingleChildScrollView(
                        gradientFractionOnEnd: 0.3,
                        child: SingleChildScrollView(
                          controller: model!.scrollController,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 40),
                              Text(
                                S.of(context).cardSubscription,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 26.0),
                                child: Text(
                                  S.of(context).subscriptionPopUpInfo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              SizedBox(height: 32),
                              Container(
                                height: 1,
                                color: AppColor.light_grayish_violet,
                              ),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 24),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                              AssetUtils.viewSubscription),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Netflix US",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "8.51",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 2,
                                                                  top: 4),
                                                          child: Text(
                                                            "JOD",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColor
                                                                    .gray1),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    "Monthly",
                                                    style: TextStyle(
                                                        color: AppColor.gray1,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Divider(
                                            thickness: 4,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: 5,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    height: 1,
                                    color: AppColor.light_grayish_violet,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 36,
                        child: Center(
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
                      )
                    ],
                  )));
        },
        providerBase: providerBase());
  }
}

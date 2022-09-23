import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SendMoneyFailurePageView extends BasePageViewWidget<SendMoneyFailureViewModel> {
  SendMoneyFailurePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 92.h),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AssetUtils.line, color: Theme.of(context).accentColor.withOpacity(0.4)),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).canvasColor,
                            ),
                            child: Center(
                                child: AppSvg.asset(AssetUtils.cancel,
                                    color: Theme.of(context).primaryColorDark)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.only(top: 47.h, start: 24.w, end: 24.w),
                        child: Text(
                          S.of(context).sendMoneyNotSuccessful,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 24.t,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).accentColor),
                        )),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 51.h, start: 24.w, end: 24.w),
                      child: Text(
                        S.of(context).tryAgainLater,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.t,
                            color: Theme.of(context).accentColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    borderColor: Theme.of(context).accentColor,
                    textColor: Theme.of(context).accentColor,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(top: 9.h),
                    child: Text(
                      S.of(context).toDashboard,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.t,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

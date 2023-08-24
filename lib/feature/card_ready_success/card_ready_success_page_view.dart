import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/card_ready_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_secondary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CardReadySuccessPageView extends BasePageViewWidget<CardReadySuccessPageViewModel> {
  CardReadySuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CardReadySuccessPageViewModel model) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 92.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AssetUtils.line),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.vividYellow,
                            ),
                            child: Center(child: AppSvg.asset(AssetUtils.right)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34.7.h,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).yourCardReady,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 24.t,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                          child: Text(
                            S.of(context).youCanAddMoney,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.t,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: AppSecondaryButton(
                    text: S.of(context).done,
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePaths.AppHome);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 32.h,
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).toDashboard,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.t,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

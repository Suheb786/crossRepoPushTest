import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/request_money_failure/request_money_failure_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RequestMoneyFailurePageView extends BasePageViewWidget<RequestMoneyFailureViewModel> {
  RequestMoneyFailurePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 92.0.h),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(AssetUtils.line, color: Theme.of(context).colorScheme.secondary),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 111.37.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                              child: AppSvg.asset(AssetUtils.cancel, color: Theme.of(context).colorScheme.secondary)),
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
                            fontFamily: StringUtils.appFont, fontSize: 24.t, fontWeight: FontWeight.w500),
                      )),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 51.h, start: 24.w, end: 24.w),
                    child: Text(
                      S.of(context).tryAgainLater,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 14),
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
                  borderColor: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorDark,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(top: 9.h),
                  child: Text(
                    S.of(context).toDashboard,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont, fontSize: 12.t, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              )
            ],
          ),
        ],
      ),
    );
  }
}

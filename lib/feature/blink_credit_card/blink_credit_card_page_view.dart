import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/blink_credit_card/blink_credit_card_view_model.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/launch_urls_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BlinkCreditCardPageView extends BasePageViewWidget<BlinkCreditCardViewModel> {
  BlinkCreditCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, BlinkCreditCardViewModel model) {
    return AppStreamBuilder<Resource<GetCardApplicationResponse>>(
        stream: model.getApplicationResponseStream,
        initialData: Resource.none(),
        onData: (data) {
          if (data.status == Status.SUCCESS) {
            if (data.data!.cardApplicationContent!.isEmpty) {
              Navigator.pushNamed(context, RoutePaths.ApplyCreditCardHome);
            } else {
              Navigator.pushReplacementNamed(context, RoutePaths.CreditCardActivationStatus);
            }
          }
        },
        dataBuilder: (context, snapshot) {
          return AppStreamBuilder<Resource<bool>>(
              stream: model.blinkResponseStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  model.getApplication();
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, snapshot) {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity!.isNegative) {
                      model.submit();
                    }
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetUtils.zigzagWhite), alignment: Alignment.topLeft)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 55.h, start: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: AppSvg.asset(AssetUtils.leftArrow,
                                    matchTextDirection: true, height: 24.h, width: 24.w)),
                            SizedBox(
                              height: 16.h,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 62.w, end: 86.w),
                              child: Card(
                                child: Container(
                                  height: 325.h,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12.w)),
                                  padding: EdgeInsetsDirectional.only(top: 29.h, bottom: 16.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(start: 29.w, end: 52.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppSvg.asset(AssetUtils.blinkWhite),
                                            AppSvg.asset(AssetUtils.wifi)
                                          ],
                                        ),
                                      ),
                                      Image.asset(AssetUtils.line_black_white),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(end: 15.0.w),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: AppSvg.asset(AssetUtils.visaWhite),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 28.h,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(end: 24.0.w),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).blinkCreditCardTitle,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 16.t,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(end: 55.0.w, start: 31.w),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).getCardDelivered,
                                  textAlign: TextAlign.center,
                                  // maxLines: 3,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.t),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 48.h,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 25.0.w, end: 49.w),
                              child: Row(
                                children: [
                                  AppStreamBuilder<bool>(
                                      stream: model.isCheckedStream,
                                      initialData: false,
                                      dataBuilder: (context, value) {
                                        return InkWell(
                                          splashColor: Theme.of(context).colorScheme.secondary,
                                          onTap: () {
                                            model.updateCheckBox(!value!);
                                          },
                                          child: Container(
                                            height: 40.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                                color: !value!
                                                    ? Theme.of(context).colorScheme.secondary
                                                    : Theme.of(context).canvasColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color:
                                                        Theme.of(context).textTheme.bodyMedium!.color!)),
                                            child: Center(
                                              child: Visibility(
                                                visible: value,
                                                child: AppSvg.asset(AssetUtils.tick,
                                                    color: Theme.of(context).primaryColorDark),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Expanded(
                                    child: RichText(
                                        //maxLines: 3,
                                        text: TextSpan(
                                            text: S.of(context).authorize,
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColorDark,
                                                fontSize: 12.t,
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w600),
                                            children: [
                                          TextSpan(
                                              text: S.of(context).creditTc,
                                              recognizer: new TapGestureRecognizer()
                                                ..onTap = () => LaunchUrlUtils.launchDigitalService(
                                                    StringUtils.isDirectionRTL(context)
                                                        ? AppConstantsUtils
                                                            .CREDIT_CARD_TERMS_CONDITION_LINK_LIVE_AR
                                                        : AppConstantsUtils
                                                            .CREDIT_CARD_TERMS_CONDITION_LINK_LIVE),
                                              style: TextStyle(
                                                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                                                  fontSize: 12.t,
                                                  fontFamily: StringUtils.appFont,
                                                  fontWeight: FontWeight.w600),
                                              children: [
                                                TextSpan(
                                                    text: S.of(context).agreeData,
                                                    style: TextStyle(
                                                        color: Theme.of(context).primaryColorDark,
                                                        fontSize: 12.t,
                                                        fontFamily: StringUtils.appFont,
                                                        fontWeight: FontWeight.w600),
                                                    children: [
                                                      TextSpan(
                                                          text: S.of(context).creditBureau,
                                                          recognizer: new TapGestureRecognizer()
                                                            ..onTap = () => Navigator.pushNamed(
                                                                context, RoutePaths.TaxTreatyBenefits,
                                                                arguments: ClaimOfTaxTreatyBenefitsArguments(
                                                                    staticRouteContent:
                                                                        StaticRouteContent.CREDIT_BUREAU)),
                                                          style: TextStyle(
                                                              color: Theme.of(context).textTheme.bodyMedium!.color!,
                                                              fontSize: 12.t,
                                                              fontFamily: StringUtils.appFont,
                                                              fontWeight: FontWeight.w600),
                                                          children: [
                                                            TextSpan(
                                                                text: S.of(context).authorization,
                                                                style: TextStyle(
                                                                    color: Theme.of(context).primaryColorDark,
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 12.t,
                                                                    fontWeight: FontWeight.w600)),
                                                          ])
                                                    ])
                                              ])
                                        ])),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            AppStreamBuilder<bool>(
                                stream: model.isCheckedStream,
                                initialData: false,
                                dataBuilder: (context, value) {
                                  return Visibility(
                                    visible: value!,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(end: 24.w, bottom: 28.h),
                                      child: Center(
                                        child: AnimatedButton(
                                          buttonText: S.of(context).swipeToProceed,
                                          borderColor: Theme.of(context).textTheme.bodyLarge!.color!,
                                          textColor: Theme.of(context).textTheme.bodyLarge!.color!,
                                        ),
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}

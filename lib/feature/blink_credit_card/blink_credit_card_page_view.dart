import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/blink_credit_card/blink_credit_card_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/launch_urls_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class BlinkCreditCardPageView
    extends BasePageViewWidget<BlinkCreditCardViewModel> {
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
              Navigator.pushReplacementNamed(
                  context, RoutePaths.CreditCardActivationStatus);
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
                            image: AssetImage(AssetUtils.zigzagWhite),
                            alignment: Alignment.topLeft)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 55, left: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: AppSvg.asset(AssetUtils.leftArrow,
                                    height: 24, width: 24)),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 62, right: 86),
                              child: Card(
                                child: Container(
                                  height: 325,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.only(top: 29, bottom: 16),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 29, right: 52),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppSvg.asset(AssetUtils.blinkWhite),
                                            AppSvg.asset(AssetUtils.wifi)
                                          ],
                                        ),
                                      ),
                                      Image.asset(AssetUtils.line_black_white),
                                      Padding(
                                        padding: EdgeInsets.only(right: 15.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: AppSvg.asset(
                                              AssetUtils.visaWhite),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 24.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).blinkCreditCardTitle,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 55.0, left: 31),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).getCardDelivered,
                                  textAlign: TextAlign.center,
                                  // maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 48,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 49),
                              child: Row(
                                children: [
                                  AppStreamBuilder<bool>(
                                      stream: model.isCheckedStream,
                                      initialData: false,
                                      dataBuilder: (context, value) {
                                        return InkWell(
                                          splashColor:
                                              Theme.of(context).accentColor,
                                          onTap: () {
                                            model.updateCheckBox(!value!);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: !value!
                                                    ? Theme.of(context)
                                                        .accentColor
                                                    : Theme.of(context)
                                                        .canvasColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .accentTextTheme
                                                        .bodyText1!
                                                        .color!)),
                                            child: Center(
                                              child: Visibility(
                                                visible: value,
                                                child: AppSvg.asset(
                                                    AssetUtils.tick,
                                                    color: Theme.of(context)
                                                        .primaryColorDark),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: RichText(
                                        //maxLines: 3,
                                        text: TextSpan(
                                            text: S.of(context).authorize,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                fontSize: 12,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600),
                                            children: [
                                          TextSpan(
                                              text: S.of(context).creditTc,
                                              recognizer: new TapGestureRecognizer()
                                                ..onTap = () => LaunchUrlUtils
                                                    .launchDigitalService(
                                                        AppConstantsUtils
                                                            .CREDIT_CARD_TERMS_CONDITION_LINK_UAT),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentTextTheme
                                                      .bodyText1!
                                                      .color!,
                                                  fontSize: 12,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        S.of(context).agreeData,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    children: [
                                                      TextSpan(
                                                          text: S
                                                              .of(context)
                                                              .creditBureau,
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentTextTheme
                                                                  .bodyText1!
                                                                  .color!,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          children: [
                                                            TextSpan(
                                                                text: S
                                                                    .of(context)
                                                                    .authorization,
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColorDark,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ])
                                                    ])
                                              ])
                                        ])),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            AppStreamBuilder<bool>(
                                stream: model.isCheckedStream,
                                initialData: false,
                                dataBuilder: (context, value) {
                                  return Visibility(
                                    visible: value!,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 24, bottom: 28),
                                      child: Center(
                                        child: AnimatedButton(
                                          buttonText:
                                              S.of(context).swipeToProceed,
                                          borderColor: Theme.of(context)
                                              .accentTextTheme
                                              .bodyText1!
                                              .color!,
                                          textColor: Theme.of(context)
                                              .accentTextTheme
                                              .bodyText1!
                                              .color!,
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

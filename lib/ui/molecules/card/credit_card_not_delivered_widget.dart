import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardNotDeliveredWidget extends StatefulWidget {
  final Key key;
  final CreditCard creditCard;
  final bool isSmallDevice;
  final bool isChangePinEnabled;
  final Function() onSettingsTap;

  CreditCardNotDeliveredWidget(
      {required this.key,
      required this.creditCard,
      this.isSmallDevice = false,
      required this.isChangePinEnabled,
      required this.onSettingsTap});

  FlipCardController? flipCardController = FlipCardController();

  @override
  _CreditCardNotDeliveredWidgetState createState() => _CreditCardNotDeliveredWidgetState();
}

class _CreditCardNotDeliveredWidgetState extends State<CreditCardNotDeliveredWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FlipCard(
        controller: widget.flipCardController,
        flipOnTouch: false,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
            key: ValueKey(true),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    child: topWidget(context),
                    top: 0,
                    left: 0,
                    right: 0,
                  ),
                  PositionedDirectional(
                    child: bottomWidget(context),
                    bottom: 0,
                    end: 0,
                    start: 0,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Image.asset(
                        AssetUtils.line_black_white,
                      ),
                    ),
                  ),
                ],
              )/*SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 30.0.h,
                        right: 23.0.w,
                        left: 23.0.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).myCreditCard,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 12.0.t, color: Colors.white),
                          ),
                          InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: () async {
                              widget.flipCardController!.toggleCard();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsetsDirectional.only(end: 0.0.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                                border: Border.all(color: AppColor.softRed1),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                                ],
                              ),
                              child: AppSvg.asset(AssetUtils.spin, height: 24.w, width: 24.w),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.0.w, vertical: 5.0.h),
                      child: AppSvg.asset(AssetUtils.blink_updated_logo, height: 33.64.h, width: 72.0.w),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.0.w, vertical: 5.0.h),
                      child: Text(
                        widget.creditCard.name ?? "",
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0.t,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30.0.h,
                    ),
                    Image.asset(
                      AssetUtils.line_black_white,
                      // fit: BoxFit.fill,
                      // height: widget.isSmallDevice ? 93 : 118,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 8.0.h, start: 23.0.w),
                      child: Text(
                        S.of(context).cardRequiresActivation,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14.0.t,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 8.0.h, start: 23.0.w, bottom: 40.0.h, end: 23.0.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              S.of(context).cardRequiresActivationDesc,
                              style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.veryLightRed,
                                fontSize: 14.0.t,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25.0.w,
                          ),
                          InkWell(
                              onTap: () async {
                                widget.onSettingsTap();
                                // await Navigator.pushNamed(context, RoutePaths.CreditCardSettings, arguments: CreditCardSettingsArguments(creditCard: widget.creditCard, isChangePinEnabled: widget.isChangePinEnabled));
                              },
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(color: AppColor.strongRed),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                                    ],
                                  ),
                                  child: AppSvg.asset(AssetUtils.settingsRed,
                                      color: AppColor.light_acccent_blue))),
                        ],
                      ),
                    ),
                  ],
                ),
              )*/,
            )),
        back: Container(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            color: Theme.of(context).primaryColor,
            margin: EdgeInsets.zero,
            shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetUtils.creditCardNotDelivered),
                      fit: BoxFit.cover,
                      scale: widget.isSmallDevice ? 1.3 : 1,
                      matchTextDirection: true)),
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 29.0.w, top: 32.0.t, end: 25.0.w, bottom: 30.0.t),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 96.0.h,
                          width: 96.0.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary, shape: BoxShape.circle),
                          child: AppSvg.asset(AssetUtils.card_activation),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 16.0.h),
                          child: Text(
                            S.of(context).flipBackDesc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 14.0.t,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50.0.h,
                          width: 50.0.w,
                        ),
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            widget.flipCardController!.toggleCard();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            margin: EdgeInsetsDirectional.only(end: 0.0.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                              border: Border.all(color: AppColor.softRed1),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                              ],
                            ),
                            child: AppSvg.asset(AssetUtils.spin, height: 24.w, width: 24.w),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  topWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 26.0.h, right: 23.0.w, left: 23.0.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                ),
                child: Text(
                  S.of(context).myCreditCard,
                  textAlign: TextAlign.right,
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0.t,
                      color: Colors.white),
                ),
              ),
              Spacer(),
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () async {
                  widget.flipCardController!.toggleCard();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsetsDirectional.only(end: 0.0.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: AppColor.softRed1),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                    ],
                  ),
                  child: AppSvg.asset(AssetUtils.spin, height: 24.w, width: 24.w),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.0.w, vertical: 5.0.h),
          child: AppSvg.asset(AssetUtils.blink_updated_logo, height: 33.64.h, width: 72.0.w),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 23.0.w, vertical: MediaQuery.of(context).size.height * 0.005),
          child: Text(
            widget.creditCard.name ?? "",
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 14.0.t,
                color: Colors.white),
          ),
        ),
      ],
    );
  }

  bottomWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 23.50.w, top: MediaQuery.of(context).size.height * 0.04, right: 23.50.w),
          child: Text(
            S.of(context).cardRequiresActivation,
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14.0.t,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.019,
            left: 24.0.w,
            right: 23.0.w,
            bottom: 32.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  S.of(context).cardRequiresActivationDesc,
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.veryLightRed,
                    fontSize: 14.0.t,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 25.0.w,
              ),
              InkWell(
                  onTap: () async {
                    widget.onSettingsTap();
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: AppColor.strongRed),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                        ],
                      ),
                      child: AppSvg.asset(AssetUtils.settingsRed,
                          color: AppColor.light_acccent_blue))),
            ],
          ),
        )
      ],
    );
  }
}

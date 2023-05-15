import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
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

  CreditCardNotDeliveredWidget(
      {required this.key,
      required this.creditCard,
      this.isSmallDevice = false,
      required this.isChangePinEnabled});

  FlipCardController? flipCardController = FlipCardController();

  @override
  _CreditCardNotDeliveredWidgetState createState() => _CreditCardNotDeliveredWidgetState();
}

class _CreditCardNotDeliveredWidgetState extends State<CreditCardNotDeliveredWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Directionality(
      textDirection: TextDirection.ltr,
      child: FlipCard(
        controller: widget.flipCardController,
        flipOnTouch: false,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
            child: Container(
                key: ValueKey(true),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  color: Theme.of(context).primaryColor,
                  margin: EdgeInsets.zero,
                  shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
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
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.t,
                                  color: Colors.white),
                            ),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () async {
                                widget.flipCardController!.toggleCard();
                              },
                              child: Container(
                                height: 24.0.h,
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).flipCard,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0.t,
                                      color: Theme.of(context).textTheme.bodyLarge!.color!),
                                ),
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
                      Spacer(),
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
                        padding: EdgeInsetsDirectional.only(
                            top: 8.0.h, start: 23.0.w, bottom: 40.0.h, end: 23.0.w),
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
                                  await Navigator.pushNamed(context, RoutePaths.CreditCardSettings,
                                      arguments: CreditCardSettingsArguments(
                                          creditCard: widget.creditCard,
                                          isChangePinEnabled: widget.isChangePinEnabled));
                                },
                                child:
                                    AppSvg.asset(AssetUtils.settingsRed, color: AppColor.light_acccent_blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        back: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
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
                            height: 50.0.h,
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).flipBack,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                                  fontSize: 14.0.t,
                                  fontWeight: FontWeight.w600),
                            ),
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
    ));
  }
}

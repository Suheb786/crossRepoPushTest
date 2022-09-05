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
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardNotDeliveredWidget extends StatefulWidget {
  final Key key;
  final CreditCard creditCard;
  final bool isSmallDevice;

  CreditCardNotDeliveredWidget({required this.key, required this.creditCard, this.isSmallDevice: false});

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
            padding: EdgeInsets.all(15),
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
                          top: widget.isSmallDevice ? 21 : 30.0,
                          right: 23,
                          left: 23,
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
                                  fontSize: widget.isSmallDevice ? 10 : 12,
                                  color: Colors.white),
                            ),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () async {
                                widget.flipCardController!.toggleCard();
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).flipCard,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w600,
                                      fontSize: widget.isSmallDevice ? 12 : 14,
                                      color: Theme.of(context).accentTextTheme.bodyText1!.color),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
                        child: AppSvg.asset(AssetUtils.blink_updated_logo,
                            height: widget.isSmallDevice ? 26 : 33.64, width: widget.isSmallDevice ? 52 : 72),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
                        child: Text(
                          widget.creditCard.name ?? "",
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: widget.isSmallDevice ? 10 : 14,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        AssetUtils.line_black_white,
                        // fit: BoxFit.fill,
                        // height: widget.isSmallDevice ? 93 : 118,
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 8.0, start: 23),
                        child: Text(
                          S.of(context).cardRequiresActivation,
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).accentColor,
                            fontSize: widget.isSmallDevice ? 12 : 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 8.0, start: 23, bottom: 40, end: 23),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                S.of(context).cardRequiresActivationDesc,
                                style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.veryLightRed,
                                  fontSize: widget.isSmallDevice ? 12 : 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                                onTap: () async {
                                  var result = await Navigator.pushNamed(
                                      context, RoutePaths.CreditCardSettings,
                                      arguments: CreditCardSettingsArguments(creditCard: widget.creditCard));
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
          padding: EdgeInsets.all(15.0),
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
                padding: EdgeInsetsDirectional.only(start: 29.0, top: 32, end: 25, bottom: 30),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 96,
                          width: 96,
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(color: Theme.of(context).accentColor, shape: BoxShape.circle),
                          child: AppSvg.asset(AssetUtils.card_activation),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 16),
                          child: Text(
                            S.of(context).flipBackDesc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).accentColor,
                              fontSize: widget.isSmallDevice ? 12 : 14,
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
                          height: 50,
                          width: 50,
                        ),
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            widget.flipCardController!.toggleCard();
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).flipBack,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).accentTextTheme.bodyText1!.color,
                                  fontSize: widget.isSmallDevice ? 12 : 14,
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

import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DebitCardWidget extends StatefulWidget {
  final Key key;
  final DebitCard debitCard;
  final bool isSmallDevice;

  DebitCardWidget(
      {required this.key, required this.debitCard, this.isSmallDevice: false});

  FlipCardController? flipCardController = FlipCardController();

  @override
  _DebitCardWidgetState createState() => _DebitCardWidgetState();
}

class _DebitCardWidgetState extends State<DebitCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlipCard(
        controller: widget.flipCardController,
        flipOnTouch: false,
        // widget.debitCard.cardStatus == FreezeCardStatusEnum.F
        //     ? false
        //     : true,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          color: Theme.of(context).accentColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  color: widget.debitCard.cardStatus == FreezeCardStatusEnum.F
                      ? AppColor.paleYellow
                      : Theme.of(context).canvasColor,
                  margin: EdgeInsets.zero,
                  shadowColor:
                      Theme.of(context).primaryColorDark.withOpacity(0.32),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 27.0,
                      top: widget.isSmallDevice ? 21 : 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).myDebitCard,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: widget.isSmallDevice ? 10 : 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            widget.debitCard.cardStatus ==
                                    FreezeCardStatusEnum.F
                                ? Padding(
                                    padding: EdgeInsets.only(right: 23.0),
                                    child: Text(
                                      S.of(context).cardFrozen,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!
                                              .withOpacity(0.5),
                                          fontSize:
                                              widget.isSmallDevice ? 12 : 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () {
                                      widget.flipCardController!.toggleCard();
                                    },
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 23.0),
                                        child: Text(
                                          S.of(context).flipCard,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1!
                                                  .color!,
                                              fontSize: widget.isSmallDevice
                                                  ? 12
                                                  : 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: AppSvg.asset(AssetUtils.blinkBlack),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  widget.debitCard.accountTitle ?? '',
                                  style: TextStyle(
                                    fontSize: widget.isSmallDevice ? 12 : 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: widget.isSmallDevice ? 10 : 50),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AppSvg.asset(AssetUtils.zigzagCircle),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: widget.isSmallDevice ? 10 : 40,
                              bottom: widget.isSmallDevice ? 30 : 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      RoutePaths.AddMoneyOptionSelector);
                                },
                                child: Container(
                                  height: 40,
                                  width: widget.isSmallDevice ? 95 : 104,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Theme.of(context)
                                          .accentTextTheme
                                          .bodyText1!
                                          .color),
                                  child: Center(
                                    child: Text(
                                      S.of(context).addMoney,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              widget.isSmallDevice ? 12 : 14,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  var result = await Navigator.pushNamed(
                                      context, RoutePaths.DebitCardSettings,
                                      arguments: DebitCardSettingsArguments(
                                          debitCard: widget.debitCard));
                                  if (result != null) {
                                    bool value = result as bool;
                                    if (value) {
                                      ProviderScope.containerOf(context)
                                          .read(appHomeViewModelProvider)
                                          .getDashboardData();
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 33.0),
                                  child: AppSvg.asset(AssetUtils.settingsRed,
                                      color: Theme.of(context)
                                          .accentTextTheme
                                          .bodyText1!
                                          .color!),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///delivered button
              Visibility(
                visible: !(widget.debitCard.isDebitDelivered != null &&
                    widget.debitCard.isDebitDelivered!),
                child: Positioned(
                  top: 0,
                  child: Container(
                    height: 24,
                    width: widget.isSmallDevice ? 100 : 125,
                    decoration: BoxDecoration(
                        color: AppColor.darkGrey,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        S.of(context).cardDelivered,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: widget.isSmallDevice ? 10 : 12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        back: Padding(
          padding: EdgeInsets.all(15),
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              // if (details.primaryVelocity!.isNegative) {
              //   ProviderScope.containerOf(context)
              //       .read(appHomeViewModelProvider)
              //       .pageController
              //       .next();
              //   Future.delayed(Duration(milliseconds: 300)).then((value) {
              //     if (!model.cardKey.currentState!.isFront) {
              //       model.cardKey.currentState!.toggleCard();
              //     }
              //   });
              // } else {
              //   ProviderScope.containerOf(context)
              //       .read(appHomeViewModelProvider)
              //       .pageController
              //       .previous();
              //   Future.delayed(Duration(milliseconds: 600)).then((value) {
              //     if (!model.cardKey.currentState!.isFront) {
              //       model.cardKey.currentState!.toggleCard();
              //     }
              //   });
              // }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              color: Theme.of(context).canvasColor,
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 29.0, top: 38, right: 25, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.debitCard.accountTitle != null
                                ? widget.debitCard.accountTitle!.toTitleCase()
                                : '',
                            maxLines: 2,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: widget.isSmallDevice ? 10 : 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: 8,
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
                                  color: Theme.of(context)
                                      .accentTextTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: widget.isSmallDevice ? 12 : 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: widget.isSmallDevice ? 50 : 63),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.debitCard.cardNumber!.isNotEmpty
                                ? StringUtils.getFormattedCreditCardNumber(
                                    widget.debitCard.cardNumber)
                                : '-',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: widget.isSmallDevice ? 12 : 14,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                          text: widget.debitCard.cardNumber ??
                                              ''))
                                      .then((value) => Fluttertoast.showToast(
                                          msg: 'Card number Copied'));
                                },
                                child: AppSvg.asset(AssetUtils.copy)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        S.of(context).cardNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: widget.isSmallDevice ? 8 : 10,
                            color: AppColor.green),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 21),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.debitCard.expiryDate ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: widget.isSmallDevice ? 10 : 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  S.of(context).expiryDate,
                                  style: TextStyle(
                                      fontSize: widget.isSmallDevice ? 8 : 10,
                                      color: AppColor.green,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.debitCard.cvv ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: widget.isSmallDevice ? 10 : 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  S.of(context).cvv,
                                  style: TextStyle(
                                      fontSize: widget.isSmallDevice ? 8 : 10,
                                      color: AppColor.green,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Divider(
                        height: 2,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.1),
                      ),
                    ),
                    Text(
                      widget.debitCard.linkedAccountNumber!.isNotEmpty
                          ? StringUtils.getFormattedCreditCardNumber(
                              widget.debitCard.linkedAccountNumber)
                          : '',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: widget.isSmallDevice ? 12 : 14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        S.of(context).linkedAccountNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: widget.isSmallDevice ? 8 : 10,
                            color: AppColor.green),
                      ),
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
}

import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class CreditCardWidget extends StatefulWidget {
  final Key key;
  final CreditCard creditCard;
  final bool isSmallDevice;
  final String? accountBalance;

  CreditCardWidget(
      {required this.key,
      required this.creditCard,
      this.isSmallDevice: false,
      this.accountBalance: ""});

  FlipCardController? flipCardController = FlipCardController();

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlipCard(
      controller: widget.flipCardController,
      flipOnTouch: false,
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                  key: ValueKey(true),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2,
                    color:
                        widget.creditCard.cardStatus == FreezeCardStatusEnum.F
                            ? AppColor.verySoftRedCard
                            : Theme.of(context).primaryColor,
                    margin: EdgeInsets.zero,
                    shadowColor:
                        Theme.of(context).primaryColorDark.withOpacity(0.32),
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
                                    fontWeight: FontWeight.w600,
                                    fontSize: widget.isSmallDevice ? 10 : 12,
                                    color: Colors.white),
                              ),
                              widget.creditCard.cardStatus ==
                                      FreezeCardStatusEnum.F
                                  ? Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(right: 23.0),
                                      child: Text(
                                        S.of(context).cardFrozen,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .accentColor
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
                                        child: Text(
                                          S.of(context).flipCard,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: widget.isSmallDevice
                                                  ? 12
                                                  : 14,
                                              color: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1!
                                                  .color),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 23, vertical: 5),
                          child: AppSvg.asset(AssetUtils.blink_updated_logo,
                              height: widget.isSmallDevice ? 26 : 33.64,
                              width: widget.isSmallDevice ? 52 : 72),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 23, vertical: 5),
                          child: Text(
                            widget.creditCard.name ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: widget.isSmallDevice ? 10 : 14,
                                color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          AssetUtils.line_black_white,
                          // fit: BoxFit.fill,
                          // height: widget.isSmallDevice ? 93 : 118,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24,
                              top: widget.isSmallDevice ? 30 : 53,
                              right: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.creditCard.paymentDueAmount
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                widget.isSmallDevice ? 14 : 20),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          S.of(context).JOD,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.5),
                                              fontSize: widget.isSmallDevice
                                                  ? 12
                                                  : 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).minDueBy,
                                          style: TextStyle(
                                              color: AppColor.veryLightRed,
                                              fontWeight: FontWeight.w600,
                                              fontSize: widget.isSmallDevice
                                                  ? 8
                                                  : 10),
                                        ),
                                        Text(
                                          widget.creditCard.nextPaymentDate!
                                                  .isNotEmpty
                                              ? TimeUtils
                                                  .getFormattedDateForCreditCard(
                                                      widget.creditCard
                                                          .nextPaymentDate!)
                                              : "-",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: widget.isSmallDevice
                                                  ? 8
                                                  : 10),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutePaths.CreditCardPayBack,
                                      arguments: CreditCardPayBackArguments(
                                          accountHolderName:
                                              widget.creditCard.name!,
                                          secureCode:
                                              widget.creditCard.cardCode!,
                                          accountBalance:
                                              widget.accountBalance!,
                                          minDuePayBackAmount: widget
                                              .creditCard.paymentDueAmount
                                              .toString(),
                                          totalMinDueAmount:
                                              widget.creditCard.usedBalance!));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .bodyText1!
                                        .color,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal:
                                            widget.isSmallDevice ? 15 : 25),
                                    child: Text(
                                      S.of(context).payBack,
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize:
                                            widget.isSmallDevice ? 12 : 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 19,
                            left: 24,
                            right: 23,
                            bottom: widget.isSmallDevice ? 30 : 50,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.creditCard.availableBalance
                                            .toString(),
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              widget.isSmallDevice ? 14 : 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          S.of(context).JOD,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.5),
                                              fontSize: widget.isSmallDevice
                                                  ? 12
                                                  : 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      S.of(context).availableAmount,
                                      style: TextStyle(
                                          color: AppColor.veryLightRed,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              widget.isSmallDevice ? 8 : 10),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                  onTap: () async {
                                    var result = await Navigator.pushNamed(
                                        context, RoutePaths.CreditCardSettings,
                                        arguments: CreditCardSettingsArguments(
                                            creditCard: widget.creditCard));
                                    if (result != null) {
                                      bool value = result as bool;
                                      if (value) {
                                        ProviderScope.containerOf(context)
                                            .read(appHomeViewModelProvider)
                                            .getDashboardData();
                                      }
                                    }
                                  },
                                  child: AppSvg.asset(AssetUtils.settingsRed,
                                      color: AppColor.light_acccent_blue))
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Visibility(
              visible: !(widget.creditCard.isCreditDelivered != null &&
                  widget.creditCard.isCreditDelivered!),
              child: Positioned(
                top: 0,
                child: Container(
                  height: 24,
                  width: 125,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
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
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  AppSvg.asset(AssetUtils.swipeUp),
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      S.of(context).swipeUpToViewTransaction,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: widget.isSmallDevice ? 10 : 12,
                          color: AppColor.dark_gray_1),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      back: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          key: ValueKey(false),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            color: Theme.of(context).primaryColor,
            margin: EdgeInsets.zero,
            shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 29.0, top: 32, right: 25, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.creditCard.name ?? '',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: widget.isSmallDevice ? 10 : 12,
                            fontWeight: FontWeight.w600),
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
                    padding: EdgeInsets.only(top: 63),
                    child: Row(
                      children: [
                        Text(
                          widget.creditCard.cardNumber!.isNotEmpty
                              ? StringUtils.getFormattedCreditCardNumber(
                                  widget.creditCard.cardNumber)
                              : '-',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).accentColor,
                            fontSize: widget.isSmallDevice ? 12 : 14,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                    text: widget.creditCard.cardNumber ?? ''))
                                .then((value) => Fluttertoast.showToast(
                                    msg: 'Card Number Copied'));
                          },
                          child: AppSvg.asset(
                            AssetUtils.copy,
                          ),
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
                          color: Theme.of(context).accentColor.withOpacity(0.6),
                          fontSize: widget.isSmallDevice ? 8 : 10),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 19),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 21),
                      child: Text(
                        "140591314151414",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(S.of(context).linkedAccountNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.6),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 24),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.creditCard.expiryDate ?? '-',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: widget.isSmallDevice ? 10 : 12,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                S.of(context).expiryDate,
                                style: TextStyle(
                                    fontSize: widget.isSmallDevice ? 8 : 10,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.6),
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 59.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.creditCard.cvv!.isNotEmpty
                                    ? StringUtils.getCvv(widget.creditCard.cvv)
                                    : '-',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).accentColor,
                                  fontSize: widget.isSmallDevice ? 10 : 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  S.of(context).cvv,
                                  style: TextStyle(
                                      fontSize: widget.isSmallDevice ? 8 : 10,
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.creditCard.usedBalance ?? '-',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: widget.isSmallDevice ? 12 : 14,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            S.of(context).JOD,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: widget.isSmallDevice ? 8 : 10,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          S.of(context).totalUsedAmount,
                          style: TextStyle(
                              fontSize: widget.isSmallDevice ? 8 : 10,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.6),
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.creditCard.creditLimit ?? '-',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: widget.isSmallDevice ? 12 : 14,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            S.of(context).JOD,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: widget.isSmallDevice ? 8 : 10,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          S.of(context).yourCardLimit,
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.6),
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

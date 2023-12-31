import 'dart:io';

import 'package:data/helper/antelop_helper.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/model/apple_pay/get_all_card_data.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

import '../../../di/dashboard/dashboard_modules.dart';

class CreditCardWidget extends StatefulWidget {
  final Key key;
  final CreditCard creditCard;
  final String? accountBalance;
  final bool isChangePinEnabled;
  final Function() onPayBackClick;
  final Function() onSettingsTap;
  final int myIndex;

  CreditCardWidget({
    required this.key,
    required this.creditCard,
    this.accountBalance = "",
    required this.isChangePinEnabled,
    required this.onPayBackClick,
    required this.onSettingsTap,
    required this.myIndex,
  });

  FlipCardController? flipCardController = FlipCardController();

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FlipCard(
        controller: widget.flipCardController,
        flipOnTouch: false,
        direction: FlipDirection.HORIZONTAL,
        front: AppStreamBuilder<int>(
            stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).currentStep,
            initialData: 0,
            dataBuilder: (context, myyCurrentStep) {
              return AnimatedOpacity(
                opacity: myyCurrentStep == widget.myIndex ? 1 : 0.5,
                duration: const Duration(milliseconds: 400),
                child: Container(
                    key: ValueKey(true),
                    child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        color: widget.creditCard.cardStatus == FreezeCardStatusEnum.F
                            ? AppColor.verySoftRedCard
                            : Theme.of(context).primaryColor,
                        margin: EdgeInsets.zero,
                        shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                        child: Stack(
                          key: ValueKey(true),
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
                        ))),
              );
            }),
        back: AppStreamBuilder<int>(
            stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).currentStep,
            initialData: 0,
            dataBuilder: (context, myyCurrentStep) {
              return AnimatedOpacity(
                opacity: myyCurrentStep == widget.myIndex ? 1 : 0.5,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2,
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.zero,
                    shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                    child: Padding(
                      padding: EdgeInsets.only(left: 29.0.w, top: 30.0.h, right: 25.0.w, bottom: 30.0.h),
                      child: SingleChildScrollView(
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
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontSize: 12.0.t,
                                      fontWeight: FontWeight.w600),
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
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 63.0.h),
                              child: Row(
                                children: [
                                  Text(
                                    widget.creditCard.cardNumber!.isNotEmpty
                                        ? StringUtils.getFormattedCreditCardNumber(
                                            widget.creditCard.cardNumber)
                                        : '-',
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontSize: 14.0.t,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Clipboard.setData(
                                              ClipboardData(text: widget.creditCard.cardNumber ?? ''))
                                          .then((value) =>
                                              Fluttertoast.showToast(msg: S.of(context).cardNumberCopied));
                                    },
                                    child: AppSvg.asset(
                                      AssetUtils.copy,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0.h),
                              child: Text(
                                S.of(context).cardNumber,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                                    fontSize: 10.0.t),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: EdgeInsets.only(top: 19.0.h),
                                child: Divider(
                                  height: 1,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: EdgeInsets.only(top: 21.0.h),
                                child: Text(
                                  "140591314151414",
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0.t,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0.h),
                                child: Text(S.of(context).linkedAccountNumber,
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0.t,
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24.0.h, bottom: 24.0.h),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.creditCard.expiryDate ?? '-',
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.0.t,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.0.h),
                                        child: Text(
                                          S.of(context).expiryDate,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 10.0.t,
                                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 59.0.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.creditCard.cvv!.isNotEmpty
                                              ? StringUtils.getCvv(widget.creditCard.cvv)
                                              : '-',
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontSize: 12.0.t,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 4.0.h),
                                          child: Text(
                                            S.of(context).cvv,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 10.0.t,
                                                color:
                                                    Theme.of(context).colorScheme.secondary.withOpacity(0.6),
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
                              height: MediaQuery.of(context).size.height * 0.024,
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
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0.t,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.0.w,
                                    ),
                                    Text(
                                      S.of(context).JOD,
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.0.t,
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0.h),
                                  child: Text(
                                    S.of(context).totalUsedAmount,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10.0.t,
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.024,
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
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0.t,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.0.w,
                                    ),
                                    Text(
                                      S.of(context).JOD,
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.0.t,
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0.h),
                                  child: Text(
                                    S.of(context).yourCardLimit,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10.0.t,
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
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
              );
            }),
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
                  top: widget.creditCard.cardStatus == FreezeCardStatusEnum.F ? 15.0 : 0,
                  bottom: widget.creditCard.cardStatus == FreezeCardStatusEnum.F ? 20.0 : 0,
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
              Container(
                child: widget.creditCard.cardStatus == FreezeCardStatusEnum.F
                    ? Container(
                        height: 24.0.h,
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(right: 23.0.w, bottom: 6),
                        child: Text(
                          S.of(context).cardFrozen,
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                              fontSize: 14.0.t,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(
                        child: InkWell(
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
                        ),
                      ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 23.0.w, vertical: MediaQuery.of(context).size.height * 0.005),
              child: AppSvg.asset(AssetUtils.blink_updated_logo,
                  height: MediaQuery.of(context).size.height * 0.033,
                  width: MediaQuery.of(context).size.width * 0.072),
            ),
            AppStreamBuilder<bool>(
                stream: antelopStepCompletedStream,
                initialData: true,
                onData: (value) {
                  if (!value) {
                    List<GetAllCardData> antelopIssuerCardList = listOfCardFromAntelop.value;

                    for (int j = 0; j < antelopIssuerCardList.length; j++) {
                      if (antelopIssuerCardList[j].getIssuerCardId?.trim() ==
                          widget.creditCard.cardCode?.trim()) {
                        widget.creditCard.isCardInApplePay =
                            antelopIssuerCardList[j].isCardInApplePay ?? false;
                        widget.creditCard.getStatus = antelopIssuerCardList[j].getStatus ?? false;
                      }
                    }
                  }
                },
                dataBuilder: (context, antelopStepCompleted) {
                  return Platform.isIOS
                      ? (antelopStepCompleted ?? true)
                          ? Container()
                          : (widget.creditCard.isCardInApplePay)
                              ? InkWell(
                                  onTap: () {
                                    ///Pay
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(end: 24.0.w),
                                    child: AppSvg.asset(AssetUtils.applePayButton),
                                  ),
                                )
                              : Container()
                      : Container();
                })
          ],
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
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 23.50.w, top: MediaQuery.of(context).size.height * 0.04, right: 23.50.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: StringUtils.isDirectionRTL(context)
                ? [
                    InkWell(
                      onTap: () {
                        widget.onPayBackClick();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.0.w),
                          child: Text(
                            S.of(context).payBack,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 14.0.t,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.creditCard.paymentDueAmount.toString(),
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0.t),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0.w),
                              child: Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                                    fontSize: 14.0.t,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 130.w,
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                S.of(context).minDueBy,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.veryLightRed,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0.t),
                              ),
                              Text(
                                widget.creditCard.nextPaymentDate!.isNotEmpty
                                    ? TimeUtils.getFormattedDateForCreditCard(
                                        widget.creditCard.nextPaymentDate!)
                                    : "-",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0.t),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ]
                : [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            widget.creditCard.paymentDueAmount.toString(),
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0.t),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0.w),
                            child: Text(
                              S.of(context).JOD,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                                  fontSize: 14.0.t,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ]),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).minDueBy,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.veryLightRed,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0.t),
                              ),
                              Text(
                                widget.creditCard.nextPaymentDate!.isNotEmpty
                                    ? TimeUtils.getFormattedDateForCreditCard(
                                        widget.creditCard.nextPaymentDate!)
                                    : "-",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0.t),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        widget.onPayBackClick();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.0.w),
                          child: Text(
                            S.of(context).payBack,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 14.0.t,
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
            top: MediaQuery.of(context).size.height * 0.019,
            left: 24.0.w,
            right: 23.0.w,
            bottom: 32.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: StringUtils.isDirectionRTL(context)
                ? [
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
                            child: AppSvg.asset(AssetUtils.settingsRed, color: AppColor.light_acccent_blue))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.creditCard.availableBalance.toString(),
                              style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0.t,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 5.0.w),
                              child: Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                                    fontSize: 14.0.t,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0.h),
                          child: Text(
                            S.of(context).availableAmount,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.veryLightRed,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.t),
                          ),
                        ),
                      ],
                    ),
                  ]
                : [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.creditCard.availableBalance.toString(),
                              style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0.t,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0.h),
                              child: Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                                    fontSize: 14.0.t,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0.h),
                          child: Text(
                            S.of(context).availableAmount,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.veryLightRed,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.t),
                          ),
                        ),
                      ],
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
                            child: AppSvg.asset(AssetUtils.settingsRed, color: AppColor.light_acccent_blue)))
                  ],
          ),
        )
      ],
    );
  }
}

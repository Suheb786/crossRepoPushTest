import 'dart:io';

import 'package:data/helper/antelop_helper.dart';
import 'package:domain/constants/enum/account_status_enum.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/model/apple_pay/get_all_card_data.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../di/dashboard/dashboard_modules.dart';

class DebitCardWidget extends StatefulWidget {
  final Key key;
  final DebitCard debitCard;
  final bool isSmallDevice;
  final bool isPrimaryDebitCard;
  final bool isDebitCardRequestPhysicalCardEnabled;
  final AccountStatusEnum accountStatusEnum;
  final Function() onSettingsClick;
  int myIndex;

  DebitCardWidget(
      {required this.key,
      required this.debitCard,
      this.isSmallDevice = false,
      required this.isPrimaryDebitCard,
      this.isDebitCardRequestPhysicalCardEnabled = false,
      required this.accountStatusEnum,
      required this.onSettingsClick,
      required this.myIndex});

  FlipCardController? flipCardController = FlipCardController();

  @override
  _DebitCardWidgetState createState() => _DebitCardWidgetState();
}

class _DebitCardWidgetState extends State<DebitCardWidget> {
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
                  color: Theme.of(context).colorScheme.secondary,
                  child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 2,
                      color: widget.debitCard.cardStatus == FreezeCardStatusEnum.F
                          ? AppColor.paleYellow
                          : Theme.of(context).canvasColor,
                      margin: EdgeInsetsDirectional.zero,
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
                          Positioned(
                            child: bottomWidget(context),
                            bottom: 0,
                            left: 0,
                            right: 0,
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: AppSvg.asset(AssetUtils.zigzagCircle,
                                  height: MediaQuery.of(context).size.height * 0.156,
                                  matchTextDirection: true),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            }),
        back: AppStreamBuilder<int>(
            stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).currentStep,
            initialData: 0,
            dataBuilder: (context, myyCurrentStep) {
              return AnimatedOpacity(
                opacity: myyCurrentStep == widget.myIndex ? 1 : 0.5,
                duration: const Duration(milliseconds: 400),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  color: Theme.of(context).canvasColor,
                  margin: EdgeInsetsDirectional.zero,
                  shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 29.0.w,
                        top: MediaQuery.of(context).size.height * 0.032,
                        end: 25.0.w,
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: SingleChildScrollView(
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
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 12.0.t,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: 8.0.h,
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
                                    color: Theme.of(context).canvasColor,
                                    border: Border.all(color: AppColor.lightYellowColor),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                                    ],
                                  ),
                                  child: AppSvg.asset(AssetUtils.spin, height: 24.w, width: 24.w),
                                ) /*Container(
                                height: 50.0.h,
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).flipBack,
                                  style: TextStyle(fontFamily: StringUtils.appFont, color: Theme.of(context).textTheme.bodyLarge!.color!, fontSize: 14.0.t, fontWeight: FontWeight.w600),
                                ),
                              )*/
                                ,
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.only(top: MediaQuery.of(context).size.height * 0.063),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.debitCard.cardNumber!.isNotEmpty
                                      ? StringUtils.getFormattedCreditCardNumber(widget.debitCard.cardNumber)
                                      : '-',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0.t,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 10.0.w),
                                  child: InkWell(
                                      onTap: () {
                                        Clipboard.setData(
                                                ClipboardData(text: widget.debitCard.cardNumber ?? ''))
                                            .then((value) =>
                                                Fluttertoast.showToast(msg: S.of(context).cardNumberCopied));
                                      },
                                      child: AppSvg.asset(AssetUtils.copy)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 4.0.h),
                            child: Text(
                              S.of(context).cardNumber,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.0.t,
                                  color: AppColor.green),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 21.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.debitCard.expiryDate ?? '',
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.0.t,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(top: 4.0.h),
                                      child: Text(
                                        S.of(context).expiryDate,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 10.0.t,
                                            color: AppColor.green,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 8.0.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.debitCard.cvv ?? '',
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.0.t,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(top: 4.0.h),
                                      child: Text(
                                        S.of(context).cvv,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 10.0.t,
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
                            padding: EdgeInsets.symmetric(vertical: 32.0.h),
                            child: Divider(
                              height: 2,
                              color: Theme.of(context).primaryTextTheme.bodyLarge?.color!.withOpacity(0.1),
                            ),
                          ),
                          Text(
                            widget.debitCard.linkedAccountNumber!.isNotEmpty
                                ? StringUtils.getFormattedCreditCardNumber(
                                    widget.debitCard.linkedAccountNumber)
                                : '',
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0.t,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0.h),
                            child: Text(
                              S.of(context).linkedAccountNumber,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.0.t,
                                  color: AppColor.green),
                            ),
                          ),
                        ],
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
    return Padding(
      padding: EdgeInsets.only(top: 26.0.h, right: 23.0.w, left: 23.0.w),
      child: Column(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).myDebitCard,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 12.0.t,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                widget.debitCard.cardStatus == FreezeCardStatusEnum.F
                    ? Container(
                        height: 24.0.h,
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).cardFrozen,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).textTheme.bodyLarge?.color!.withOpacity(0.5),
                              fontSize: 14.0.t,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          widget.flipCardController?.toggleCard();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).canvasColor,
                            border: Border.all(color: AppColor.lightYellowColor),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                            ],
                          ),
                          child: AppSvg.asset(AssetUtils.spin, height: 24.w, width: 24.w),
                        ),
                      ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: 8.0.h),
                  child: AppSvg.asset(AssetUtils.blinkBlack),
                ),
              ),
              AppStreamBuilder<bool>(
                  stream: antelopStepCompletedStream,
                  initialData: true,
                  onData: (value) {
                    if (!value) {
                      List<GetAllCardData> antelopIssuerCardList = listOfCardFromAntelop.value;

                      for (int j = 0; j < antelopIssuerCardList.length; j++) {
                        if (antelopIssuerCardList[j].getIssuerCardId?.trim() ==
                            widget.debitCard.code?.trim()) {
                          //isCardInApplePay = true;
                          widget.debitCard.isCardInApplePay =
                              antelopIssuerCardList[j].isCardInApplePay ?? false;
                          widget.debitCard.getStatus = antelopIssuerCardList[j].getStatus ?? false;
                        }
                      }
                    }
                  },
                  dataBuilder: (context, antelopStepCompleted) {
                    return Platform.isIOS
                        ? (antelopStepCompleted ?? true)
                            ? Container()
                            : (widget.debitCard.isCardInApplePay)
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
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 20.0.h),
              child: Text(
                widget.debitCard.accountTitle ?? '',
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 14.0.t,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bottomWidget(BuildContext context) {
    return Directionality(
      textDirection: StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 27.0.w, end: 27.0.w, top: 23.0.h, bottom: 32.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.AddMoneyOptionSelector);
              },
              child: Container(
                height: 40.0.h,
                width: 104.0.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.h),
                    color: Theme.of(context).textTheme.bodyLarge!.color!),
                child: Center(
                  child: Text(
                    S.of(context).addMoney,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0.t,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
            ),
            InkWell(
                onTap: () async {
                  widget.onSettingsClick();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).canvasColor,
                    border: Border.all(color: AppColor.lightYellowColor),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                    ],
                  ),
                  child: AppSvg.asset(
                    AssetUtils.settingsRed,
                    color: Theme.of(context).textTheme.bodyLarge!.color!,
                    height: 50,
                    width: 50,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

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
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DebitCardWidget extends StatefulWidget {
  final Key key;
  final DebitCard debitCard;
  final bool isSmallDevice;
  final bool isPrimaryDebitCard;
  final bool isDebitCardRequestPhysicalCardEnabled;
  final AccountStatusEnum accountStatusEnum;

  DebitCardWidget(
      {required this.key,
      required this.debitCard,
      this.isSmallDevice = false,
      required this.isPrimaryDebitCard,
      this.isDebitCardRequestPhysicalCardEnabled = false,
      required this.accountStatusEnum});

  FlipCardController? flipCardController = FlipCardController();

  @override
  _DebitCardWidgetState createState() => _DebitCardWidgetState();
}

class _DebitCardWidgetState extends State<DebitCardWidget> {
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
            color: Theme.of(context).colorScheme.secondary,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2,
                    color: widget.debitCard.cardStatus == FreezeCardStatusEnum.F
                        ? AppColor.paleYellow
                        : Theme.of(context).canvasColor,
                    margin: EdgeInsetsDirectional.zero,
                    shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 27.0.w,
                        top: 30.0.h,
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
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 12.0.t,
                                    fontWeight: FontWeight.w600),
                              ),
                              widget.debitCard.cardStatus == FreezeCardStatusEnum.F
                                  ? Container(
                                      height: 24.0.h,
                                      alignment: Alignment.center,
                                      padding: EdgeInsetsDirectional.only(end: 23.0.w),
                                      child: Text(
                                        S.of(context).cardFrozen,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color!
                                                .withOpacity(0.5),
                                            fontSize: 14.0.t,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () async {
                                        ///go to settings
                                        // var result = await Navigator.pushNamed(
                                        //     context, RoutePaths.DebitCardSettings,
                                        //     arguments: DebitCardSettingsArguments(
                                        //         debitCard: widget.debitCard));
                                        // if (result != null) {
                                        //   bool value = result as bool;
                                        //   if (value) {
                                        //     ProviderScope.containerOf(context)
                                        //         .read(appHomeViewModelProvider)
                                        //         .getDashboardData();
                                        //   }
                                        // }
                                        widget.flipCardController!.toggleCard();
                                      },
                                      child: Container(
                                        height: 24.0.h,
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(end: 23.0.w),
                                          child: Text(
                                            S.of(context).flipCard,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: Theme.of(context).textTheme.bodyLarge!.color!,
                                                fontSize: 14.0.t,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(top: 10.0.h),
                                      child: AppSvg.asset(AssetUtils.blinkBlack),
                                    ),
                                  ),
                                  AppStreamBuilder<bool>(
                                      stream: antelopStepCompletedStream,
                                      initialData: true,
                                      onData: (value) {
                                        if (!value) {
                                          List<GetAllCardData> antelopIssuerCardList =
                                              listOfCardFromAntelop.value;

                                          for (int j = 0; j < antelopIssuerCardList.length; j++) {
                                            if (antelopIssuerCardList[j].getIssuerCardId?.trim() ==
                                                widget.debitCard.code?.trim()) {
                                              //isCardInApplePay = true;
                                              widget.debitCard.isCardInApplePay =
                                                  antelopIssuerCardList[j].isCardInApplePay ?? false;
                                              widget.debitCard.getStatus =
                                                  antelopIssuerCardList[j].getStatus ?? false;
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
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 50.0.h,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: AppSvg.asset(AssetUtils.zigzagCircle,
                                  height: 156.0.h, matchTextDirection: true),
                            ),
                          ),
                          Directionality(
                            textDirection:
                                StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: StringUtils.isDirectionRTL(context) ? 27.0.w : 0,
                                  top: 24.0.h,
                                  bottom: 32.0.h),
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
                                          borderRadius: BorderRadius.circular(20),
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
                                      var result = await Navigator.pushNamed(
                                          context, RoutePaths.DebitCardSettings,
                                          arguments: DebitCardSettingsArguments(
                                              accountStatusEnum: widget.accountStatusEnum,
                                              isPrimaryDebitCard: widget.isPrimaryDebitCard,
                                              debitCard: widget.debitCard,
                                              debitCardRequestPhysicalCardEnabled:
                                                  widget.isDebitCardRequestPhysicalCardEnabled));
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
                                      padding: EdgeInsetsDirectional.only(end: 30.0.w),
                                      child: AppSvg.asset(AssetUtils.settingsRed,
                                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///delivered button
                Visibility(
                  visible: false,
                  // visible: !(widget.debitCard.isDebitDelivered != null && widget.debitCard.isDebitDelivered!),
                  child: Positioned(
                    top: 0,
                    child: Container(
                      height: 24.0.h,
                      width: 125.0.w,
                      decoration:
                          BoxDecoration(color: AppColor.darkGrey, borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          S.of(context).cardDelivered,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0.t),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          back: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              color: Theme.of(context).canvasColor,
              margin: EdgeInsetsDirectional.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 29.0.w, top: 38.0.h, end: 25.0.w, bottom: 30.0.h),
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
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 63.0.h),
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
                                  Clipboard.setData(ClipboardData(text: widget.debitCard.cardNumber ?? ''))
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
                          ? StringUtils.getFormattedCreditCardNumber(widget.debitCard.linkedAccountNumber)
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
        ),
      ),
    );
  }
}

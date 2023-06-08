import 'package:domain/constants/enum/payment_type_enum.dart';
import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class PaymentActivityTransactionWidget extends StatelessWidget {
  final PaymentActivityContent content;
  final Function(RequestMoneyActivityList) onAcceptButton;
  final Function(RequestMoneyActivityList) onRejectButton;
  final Function(RequestMoneyActivityList) onTapRTPStatus;
  final Function(RequestMoneyActivityList) onTapInWardSendMoney;
  final Function(RequestMoneyActivityList) onTapOutWardSendMoney;

  const PaymentActivityTransactionWidget(
      {Key? key,
      required this.onAcceptButton,
      required this.onRejectButton,
      required this.onTapRTPStatus,
      required this.onTapInWardSendMoney,
      required this.onTapOutWardSendMoney,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          content.activityDate != null
              ? TimeUtils.getFormattedDateForRTP(content.activityDate!.toString())
              : '-',
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: 14.0.t,
              fontWeight: FontWeight.w600,
              color: AppColor.veryDarkGray2),
        ),
        Card(
          margin: EdgeInsets.only(top: 16.0.h, bottom: 32.0.h),
          color: Theme.of(context).colorScheme.secondary,
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 17.0.h),
            itemBuilder: (context, index) {
              return (content.data?[index].trxDir ==
                          RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING &&
                      content.data?[index].paymentType == PaymentTypeEnum.SEND_MONEY)
                  ? GestureDetector(
                      onTap: () {
                        onTapInWardSendMoney.call(content.data![index]);
                      },
                      child: Row(
                        children: [
                          Container(
                              height: 50.0.h,
                              width: 50.0.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                              child: Center(
                                  child: Text(
                                StringUtils.getFirstInitials(content.data?[index].dbtrName ?? ''),
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0.t),
                              ))),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 14.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getItemForInwardSendMoney(context, content.data?[index]),
                                  Padding(
                                      padding: EdgeInsets.only(top: 5.0.h),
                                      child: Row(
                                        children: [
                                          Text(
                                            content.data?[index].paymentDate != null
                                                ? TimeUtils.getFormattedTimeFor12HrsFormat(
                                                    content.data![index].paymentDate.toString())
                                                : '-',
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.gray1,
                                                fontSize: 12.0.t,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Visibility(
                                            visible: false,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.only(start: 9.0.w),
                                              child: Container(
                                                padding: EdgeInsetsDirectional.only(
                                                    start: 8.0.w, end: 8.0.w, top: 3.5.h, bottom: 1.5.h),
                                                decoration: BoxDecoration(
                                                    color: getColor(content.data?[index].trxStatus),
                                                    borderRadius: BorderRadius.circular(100)),
                                                child: Text(
                                                  (content.data?[index].trxStatus ?? '').toString(),
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: Theme.of(context).colorScheme.secondary,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12.0.t),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0.h),
                              child: AppSvg.asset(AssetUtils.rightChevron,
                                  matchTextDirection: true, color: AppColor.white_gray))
                        ],
                      ),
                    )
                  : (content.data?[index].trxDir ==
                              RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_OUTGOING &&
                          content.data?[index].paymentType == PaymentTypeEnum.SEND_MONEY)
                      ? GestureDetector(
                          onTap: () {
                            onTapOutWardSendMoney.call(content.data![index]);
                          },
                          child: Row(
                            children: [
                              Container(
                                  height: 50.0.h,
                                  width: 50.0.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                                  child: Center(
                                      child: Text(
                                    StringUtils.getFirstInitials(content.data?[index].cdtrName ?? ''),
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).colorScheme.secondary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0.t),
                                  ))),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(start: 14.0.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      getItemForOutwardSendMoney(context, content.data?[index]),
                                      Padding(
                                          padding: EdgeInsets.only(top: 5.0.h),
                                          child: Row(
                                            children: [
                                              Text(
                                                content.data?[index].paymentDate != null
                                                    ? TimeUtils.getFormattedTimeFor12HrsFormat(
                                                        content.data![index].paymentDate.toString())
                                                    : '-',
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: AppColor.gray1,
                                                    fontSize: 12.0.t,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Visibility(
                                                visible: true,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 9.0.w),
                                                  child: Container(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 8.0.w, end: 8.0.w, top: 3.5.h, bottom: 1.5.h),
                                                    decoration: BoxDecoration(
                                                        color: getColor(content.data?[index].trxStatus),
                                                        borderRadius: BorderRadius.circular(100)),
                                                    child: Text(
                                                      (content.data?[index].trxStatus ?? '').toString(),
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          color: Theme.of(context).colorScheme.secondary,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 12.0.t),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                  child: AppSvg.asset(AssetUtils.rightChevron,
                                      matchTextDirection: true, color: AppColor.white_gray))
                            ],
                          ),
                        )
                      : (content.data?[index].trxDir ==
                                  RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING &&
                              content.data?[index].paymentType == PaymentTypeEnum.RTP_REQUEST)
                          ? Row(
                              children: [
                                Container(
                                    height: 50.0.h,
                                    width: 50.0.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                                    child: Center(
                                        child: Text(
                                      StringUtils.getFirstInitials(content.data?[index].cdtrName ?? ''),
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).colorScheme.secondary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0.t),
                                    ))),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(start: 14.0.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        getItemForInwardRTP(context, content.data?[index]),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0.h),
                                            child: (content.data?[index].paymentType ==
                                                        PaymentTypeEnum.RTP_REQUEST &&
                                                    content.data?[index].trxDir ==
                                                        RequestMoneyActivityStatusEnum
                                                            .TRANSACTION_DIRECTORY_INCOMING &&
                                                    content.data?[index].trxStatus ==
                                                        RequestMoneyActivityStatusEnum.CATEGORY_PENDING)
                                                ? Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        content.data?[index].rtpDate != null
                                                            ? TimeUtils.getFormattedTimeFor12HrsFormat(
                                                                content.data![index].rtpDate.toString())
                                                            : '-',
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            color: AppColor.gray1,
                                                            fontSize: 12.0.t,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 5.0.h),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                onAcceptButton.call(content.data![index]);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: AppColor.sky_blue_mid,
                                                                  borderRadius: BorderRadius.circular(20),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal: 16.0.w,
                                                                    vertical: 10.h,
                                                                  ),
                                                                  child: Text(
                                                                    S.of(context).accept,
                                                                    style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      color: AppColor.white,
                                                                      fontSize: 12.0.t,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8.0.w,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                onRejectButton.call(content.data![index]);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: AppColor.white,
                                                                    border: Border.all(
                                                                        color: AppColor.white_gray),
                                                                    borderRadius: BorderRadius.circular(20)),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal: 16.0.w,
                                                                    vertical: 10.h,
                                                                  ),
                                                                  child: Text(
                                                                    S.of(context).reject,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        color: AppColor.sky_blue_mid,
                                                                        fontSize: 12.0.t,
                                                                        fontWeight: FontWeight.w600),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        content.data?[index].rtpDate != null
                                                            ? TimeUtils.getFormattedTimeFor12HrsFormat(
                                                                content.data![index].rtpDate.toString())
                                                            : '-',
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            color: AppColor.gray1,
                                                            fontSize: 12.0.t,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.only(start: 9.0.w),
                                                        child: Container(
                                                          padding: EdgeInsetsDirectional.only(
                                                              start: 8.0.w,
                                                              end: 8.0.w,
                                                              top: 3.5.h,
                                                              bottom: 1.5.h),
                                                          decoration: BoxDecoration(
                                                              color: getColor(content.data?[index].trxStatus),
                                                              borderRadius: BorderRadius.circular(100)),
                                                          child: Text(
                                                            (content.data?[index].trxStatus ?? '').toString(),
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                color:
                                                                    Theme.of(context).colorScheme.secondary,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 12.0.t),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                    child: AppSvg.asset(AssetUtils.rightChevron,
                                        matchTextDirection: true, color: AppColor.white_gray))
                              ],
                            )
                          :
                          // (content.data?[index].trxDir ==
                          //     RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_OUTGOING &&
                          //     content.data?[index].paymentType == PaymentTypeEnum.RTP_REQUEST)?
                          GestureDetector(
                              onTap: () {
                                onTapRTPStatus.call(content.data![index]);
                              },
                              child: Row(
                                children: [
                                  Container(
                                      height: 50.0.h,
                                      width: 50.0.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                                      child: Center(
                                          child: Text(
                                        StringUtils.getFirstInitials(content.data?[index].dbtrName ?? ''),
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.0.t),
                                      ))),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(start: 14.0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          getItemForOutwardRTP(context, content.data?[index]),
                                          Padding(
                                              padding: EdgeInsets.only(top: 5.0.h),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    content.data?[index].rtpDate != null
                                                        ? TimeUtils.getFormattedTimeFor12HrsFormat(
                                                            content.data![index].rtpDate.toString())
                                                        : '-',
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        color: AppColor.gray1,
                                                        fontSize: 12.0.t,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 9.0.w),
                                                    child: Container(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 8.0.w,
                                                          end: 8.0.w,
                                                          top: 3.5.h,
                                                          bottom: 1.5.h),
                                                      decoration: BoxDecoration(
                                                          color: getColor(content.data?[index].trxStatus),
                                                          borderRadius: BorderRadius.circular(100)),
                                                      child: Text(
                                                        (content.data?[index].trxStatus ?? '').toString(),
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            color: Theme.of(context).colorScheme.secondary,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 12.0.t),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                      child: AppSvg.asset(AssetUtils.rightChevron,
                                          matchTextDirection: true, color: AppColor.white_gray))
                                ],
                              ),
                            );
            },
            shrinkWrap: true,
            itemCount: (content.data ?? []).length,
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0.h),
                child: Container(
                  height: 1,
                  color: AppColor.light_grayish_violet,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getItemForInwardSendMoney(BuildContext context, RequestMoneyActivityList? data) {
    return RichText(
        maxLines: 3,
        text: TextSpan(
            text: "${data?.dbtrName ?? ""} ",
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: 12.0.t,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
              color: AppColor.sky_blue_mid,
            ),
            children: [
              TextSpan(
                text: " " + S.of(context).sent.toLowerCase(),
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 12.0.t,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColorDark),
              ),
              TextSpan(
                text: " " + "${(data?.amount?.toStringAsFixed(3)).toString()} ${data?.curr ?? ''}",
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 12.0.t,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark,
                ),
                children: [
                  TextSpan(
                    text: " " + S.of(context).toYou,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.0.t,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColorDark),
                  ),
                ],
              ),
            ]));
  }

  Widget getItemForInwardRTP(BuildContext context, RequestMoneyActivityList? data) {
    return RichText(
        maxLines: 3,
        text: TextSpan(
            text: data?.cdtrName ?? '',
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: 12.0.t,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
              color: AppColor.sky_blue_mid,
            ),
            children: [
              TextSpan(
                text: S.of(context).requested,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 12.0.t,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColorDark),
              ),
              TextSpan(
                text: "${(data?.amount?.toStringAsFixed(3)).toString()} ${data?.curr ?? ''}",
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 12.0.t,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark,
                ),
                children: [
                  TextSpan(
                    text: " " + S.of(context).fromYou,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.0.t,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColorDark),
                  ),
                ],
              ),
            ]));
  }

  Widget getItemForOutwardSendMoney(BuildContext context, RequestMoneyActivityList? data) {
    return RichText(
        maxLines: 3,
        text: TextSpan(
            text: S.of(context).youSent,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 12.0.t,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColorDark),
            children: [
              TextSpan(
                  text: "${(data?.amount?.toStringAsFixed(3)).toString()} ${data?.curr ?? ''}",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 12.0.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark),
                  children: [
                    TextSpan(
                      text: " " + S.of(context).to,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.0.t,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColorDark),
                      children: [],
                    ),
                    TextSpan(
                      text: " ${data?.cdtrName ?? ''}",
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.0.t,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        color: AppColor.sky_blue_mid,
                        // color: AppColor.sky_blue_mid,
                      ),
                    ),
                  ]),
            ]));
  }

  Widget getItemForOutwardRTP(BuildContext context, RequestMoneyActivityList? data) {
    return RichText(
        maxLines: 3,
        text: TextSpan(
            text: S.of(context).youRequested,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 12.0.t,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColorDark),
            children: [
              TextSpan(
                  text: "${(data?.amount?.toStringAsFixed(3)).toString()} ${data?.curr ?? ''}",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 12.0.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark),
                  children: [
                    TextSpan(
                      text: S.of(context).from,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.0.t,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColorDark),
                      children: [],
                    ),
                    TextSpan(
                      text: " ${data?.dbtrName ?? ''}",
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.0.t,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        color: AppColor.sky_blue_mid,
                        // color: AppColor.sky_blue_mid,
                      ),
                    ),
                  ]),
            ]));
  }

  Color getColor(RequestMoneyActivityStatusEnum? value) {
    switch (value) {
      case RequestMoneyActivityStatusEnum.CATEGORY_ACCEPTED:
        return AppColor.darkModerateLimeGreen;
      case RequestMoneyActivityStatusEnum.CATEGORY_REJECTED:
        return AppColor.dark_brown;
      case RequestMoneyActivityStatusEnum.CATEGORY_PENDING:
        return AppColor.dark_orange;
      case RequestMoneyActivityStatusEnum.CATEGORY_EXPIRED:
        return AppColor.gray5;
      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}

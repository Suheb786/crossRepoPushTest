// ignore_for_file: deprecated_member_use

import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class PaymentActivityTransactionWidget extends StatelessWidget {
  final PaymentActivityContent content;
  final Function(RequestMoneyActivityList) onAcceptButton;
  final Function(RequestMoneyActivityList) onRejectButton;

  const PaymentActivityTransactionWidget(
      {Key? key, required this.onAcceptButton, required this.onRejectButton, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          content.rtpDate != null ? TimeUtils.getFormattedDateForRTP(content.rtpDate!.toString()) : '-',
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: 14.0.t,
              fontWeight: FontWeight.w600,
              color: AppColor.veryDarkGray2),
        ),
        Card(
          margin: EdgeInsets.only(top: 16.0.h, bottom: 32.0.h),
          color: Theme.of(context).accentColor,
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 17.0.h),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      height: 50.0.h,
                      width: 50.0.w,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                      child: Center(
                          child: content.data?[index].trxDir ==
                              RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_OUTGOING
                              ? Text(
                                  StringUtils.getFirstInitials(content.data?[index].cdtrName ?? ''),
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0.t),
                                )
                              : Text(
                                  StringUtils.getFirstInitials(content.data?[index].dbtrName ?? ''),
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0.t),
                                ))),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 14.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          content.data?[index].trxDir ==
                              RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_OUTGOING
                              ? RichText(
                                  maxLines: 3,
                                  text: TextSpan(
                                      text: S.current.youSend,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.0.t,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryColorDark),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 12.0.t,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryColorDark,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: " " + S.of(context).to + ' ',
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12.0.t,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context).primaryColorDark),
                                            ),
                                            TextSpan(
                                              text: content.data?[index].cdtrName,
                                              style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 12.0.t,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.sky_blue_mid,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]))
                              : RichText(
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
                                            text:
                                                "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
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
                                                text: " ${content.data?[index].dbtrName}",
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
                                      ])),
                          Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: content.data?[index].trxDir ==
                                          RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING &&
                                      content.data?[index].trxStatus ==
                                          RequestMoneyActivityStatusEnum.CATEGORY_PENDING
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          content.data?[index].rtpDate != null
                                              ? TimeUtils.getFormattedTimeForTransaction(
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
                                                  // RTPConfirmationDialog.show(context,
                                                  //     amount:
                                                  //         "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                                  //     cdtrAcct: content.data?[index].cdtrAcct ?? '',
                                                  //     cdtrDpText: content.data?[index].cdtrName ?? '',
                                                  //     cdtrName: content.data?[index].cdtrName ?? '',
                                                  //     onAccepted: () {
                                                  //   Navigator.pop(context);
                                                  //   InformationDialog.show(
                                                  //     context,
                                                  //     isSwipeToCancel: true,
                                                  //     onDismissed: () => Navigator.pop(context),
                                                  //     onSelected: () {
                                                  //       onAcceptButton.call(content.data![index]);
                                                  //     },
                                                  //     image: AssetUtils.acceptIcon,
                                                  //     title: S.current.acceptRequest,
                                                  //     descriptionWidget: RichText(
                                                  //       text: TextSpan(
                                                  //         children: [
                                                  //           TextSpan(
                                                  //             text: S.current.youareabouttosend,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text:
                                                  //                 "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: S.current.towithspace,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: content.data?[index].cdtrName ?? '',
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text:
                                                  //                 S.current.asperhisrequestconfirmthisaction,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   );
                                                  // }, onRejected: () {
                                                  //   Navigator.pop(context);
                                                  //   InformationDialog.show(
                                                  //     context,
                                                  //     isSwipeToCancel: true,
                                                  //     onDismissed: () {
                                                  //       Navigator.pop(context);
                                                  //     },
                                                  //     onSelected: () {
                                                  //       onRejectButton.call(content.data![index]);
                                                  //     },
                                                  //     image: AssetUtils.rejectIcon,
                                                  //     title: S.current.rejectRequest,
                                                  //     descriptionWidget: RichText(
                                                  //       text: TextSpan(
                                                  //         children: [
                                                  //           TextSpan(
                                                  //             text: S.current.youareabouttoreject,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text:
                                                  //                 "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: S.current.requestFrom,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: content.data?[index].cdtrName ?? '',
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text:
                                                  //                 S.current.asperhisrequestconfirmthisaction,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   );
                                                  // });
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
                                                  // RTPConfirmationDialog.show(context,
                                                  //     amount:
                                                  //         "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                                  //     cdtrAcct: content.data?[index].cdtrAcct ?? '',
                                                  //     cdtrDpText: content.data?[index].cdtrName ?? '',
                                                  //     cdtrName: content.data?[index].cdtrName ?? '',
                                                  //     onAccepted: () {
                                                  //   Navigator.pop(context);
                                                  //   InformationDialog.show(
                                                  //     context,
                                                  //     isSwipeToCancel: true,
                                                  //     onDismissed: () => Navigator.pop(context),
                                                  //     onSelected: () {
                                                  //       Navigator.pop(context);
                                                  //       //Todo Api calling
                                                  //     },
                                                  //     image: AssetUtils.acceptIcon,
                                                  //     title: S.current.acceptRequest,
                                                  //     descriptionWidget: RichText(
                                                  //       text: TextSpan(
                                                  //         children: [
                                                  //           TextSpan(
                                                  //             text: S.current.youareabouttosend,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text:
                                                  //                 "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: S.current.to,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: content.data?[index].cdtrName ?? '',
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text:
                                                  //                 S.current.asperhisrequestconfirmthisaction,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   );
                                                  // }, onRejected: () {
                                                  //   Navigator.pop(context);
                                                  //   InformationDialog.show(
                                                  //     context,
                                                  //     isSwipeToCancel: true,
                                                  //     onDismissed: () {
                                                  //       Navigator.pop(context);
                                                  //     },
                                                  //     onSelected: () {
                                                  //       Navigator.pop(context);
                                                  //       //Todo api calling
                                                  //     },
                                                  //     image: AssetUtils.rejectIcon,
                                                  //     title: S.current.rejectRequest,
                                                  //     descriptionWidget: RichText(
                                                  //       text: TextSpan(
                                                  //         children: [
                                                  //           TextSpan(
                                                  //             text: S.current.youareabouttoreject,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: (content.data?[index].cdtrName ?? 0.0)
                                                  //                 .toString(),
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: S.current.requestFrom,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text: content.data?[index].cdtrName ?? '',
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //           TextSpan(
                                                  //             text:
                                                  //                 S.current.asperhisrequestconfirmthisaction,
                                                  //             style: TextStyle(
                                                  //                 fontFamily: StringUtils.appFont,
                                                  //                 fontSize: 14.0.t,
                                                  //                 fontWeight: FontWeight.w400,
                                                  //                 color: Theme.of(context).primaryColorDark),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   );
                                                  // });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      border: Border.all(color: AppColor.white_gray),
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
                                                          color: AppColor.black,
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
                                              ? TimeUtils.getFormattedTimeForTransaction(
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
                                                start: 8.0.w, end: 8.0.w, top: 3.5.h, bottom: 1.5.h),
                                            decoration: BoxDecoration(
                                                color: getColor(content.data?[index].trxStatus),
                                                borderRadius: BorderRadius.circular(100)),
                                            child: Text(
                                              (content.data?[index].trxStatus ?? '').toString(),
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: Theme.of(context).accentColor,
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
                    child: Divider(
                      thickness: 4,
                      color: Colors.red,
                    ),
                  )
                ],
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

import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/Inward_RTP/RTP_confirmation_dialog/RTP_confirmation_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';

import "";
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class PaymentActivityTransactionWidget extends StatelessWidget {
  final String rtpDate;
  final List<RequestMoneyActivityList>? activity;
  final int index;
  final PaymentActivityTransactionViewModel model;
  final RequestMoneyActivityStatusEnum? trxStatus;
  final RequestMoneyActivityStatusEnum? trxDIR;
  final String dbtrDpText;
  final String cdtrDpText;
  final String amount;
  final String dbtrName;
  final String cdtrName;
  final Function() onAcceptButton;
  const PaymentActivityTransactionWidget(
      {Key? key,
      this.activity,
      required this.index,
      required this.model,
      this.trxDIR = RequestMoneyActivityStatusEnum.CATEGORY_NONE,
      this.trxStatus = RequestMoneyActivityStatusEnum.CATEGORY_NONE,
      required this.rtpDate,
      required this.dbtrDpText,
      required this.cdtrDpText,
      required this.amount,
      required this.dbtrName,
      required this.cdtrName,
      required this.onAcceptButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rtpDate,
       
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: 15.0.t,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        // Card(
        //   margin: EdgeInsets.only(top: 16.0.h, bottom: 32.0.h),
        //   color: Theme.of(context).accentColor,
        //   child: ListView.separated(
        //     physics: NeverScrollableScrollPhysics(),
        //     padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 17.0.h),
        //     itemBuilder: (context, index) {
        //       return Row(
        //         children: [
        //           Container(
        //               height: 50.0.h,
        //               width: 50.0.w,
        //               decoration: BoxDecoration(
        //                   shape: BoxShape.circle,
        //                   color: Theme.of(context).primaryColor),
        //               child: Center(
        //                 child: Text(
        //                   StringUtils.getFirstInitials(
        //                       (activity?[index].cdtrName) ?? ""),
        //                   style: TextStyle(
        //                       fontFamily: StringUtils.appFont,
        //                       color: Theme.of(context).accentColor,
        //                       fontWeight: FontWeight.w700,
        //                       fontSize: 14.0.t),
        //                 ),
        //               )),
        //           Expanded(
        //             child: Padding(
        //               padding: EdgeInsetsDirectional.only(start: 14.0.w),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   RichText(
        //                       maxLines: 3,
        //                       text: TextSpan(
        //                           text: (activity?[index].cdtrName) ?? "",
        //                           style: TextStyle(
        //                             fontFamily: StringUtils.appFont,
        //                             fontSize: 12.0.t,
        //                             overflow: TextOverflow.ellipsis,
        //                             fontWeight: FontWeight.w600,
        //                             color: AppColor.sky_blue_mid,
        //                           ),
        //                           children: [
        //                             TextSpan(
        //                                 text: S.current.requested,
        //                                 style: TextStyle(
        //                                     fontFamily: StringUtils.appFont,
        //                                     fontSize: 12.0.t,
        //                                     fontWeight: FontWeight.w400,
        //                                     color: Theme.of(context)
        //                                         .primaryColorDark),
        //                                 children: [
        //                                   TextSpan(
        //                                     text:
        //                                         "${(activity?[index].amount) ?? ""}" +
        //                                             " JOD",
        //                                     style: TextStyle(
        //                                       fontFamily: StringUtils.appFont,
        //                                       fontSize: 12.0.t,
        //                                       fontWeight: FontWeight.w600,
        //                                       color: Theme.of(context)
        //                                           .primaryColorDark,
        //                                     ),
        //                                     children: [
        //                                       TextSpan(
        //                                         text: S.of(context).from,
        //                                         style: TextStyle(
        //                                             fontFamily:
        //                                                 StringUtils.appFont,
        //                                             fontSize: 12.0.t,
        //                                             fontWeight: FontWeight.w400,
        //                                             color: Theme.of(context)
        //                                                 .primaryColorDark),
        //                                         children: [
        //                                           TextSpan(
        //                                             text: S.current.you,
        //                                             style: TextStyle(
        //                                               fontFamily:
        //                                                   StringUtils.appFont,
        //                                               fontSize: 12.0.t,
        //                                               overflow:
        //                                                   TextOverflow.ellipsis,
        //                                               fontWeight:
        //                                                   FontWeight.w400,
        //                                               color: Theme.of(context)
        //                                                   .primaryColorDark,
        //                                             ),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ])
        //                           ])),
        //                   Padding(
        //                     padding: EdgeInsets.only(top: 5.0.h),
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                           TimeUtils.getFormattedTimeForTransaction(
        //                               (activity?[index].rtpDate.toString()) ??
        //                                   ""),
        //                           style: TextStyle(
        //                               fontFamily: StringUtils.appFont,
        //                               color: AppColor.gray1,
        //                               fontSize: 12.0.t,
        //                               fontWeight: FontWeight.w600),
        //                         ),
        //                         Row(
        //                           mainAxisAlignment: MainAxisAlignment.start,
        //                           children: [
        //                             GestureDetector(
        //                               onTap: () {},
        //                               child: Container(
        //                                 decoration: BoxDecoration(
        //                                   color: AppColor.sky_blue_mid,
        //                                   borderRadius:
        //                                       BorderRadius.circular(20),
        //                                 ),
        //                                 height: 40.h,
        //                                 child: Center(
        //                                   child: Padding(
        //                                     padding: EdgeInsets.symmetric(
        //                                       horizontal: 16.0.w,
        //                                       vertical: 10.h,
        //                                     ),
        //                                     child: Text(
        //                                       S.of(context).accept,
        //                                       style: TextStyle(
        //                                         fontFamily: StringUtils.appFont,
        //                                         color: AppColor.white,
        //                                         fontSize: 12.0.t,
        //                                         fontWeight: FontWeight.w600,
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               width: 8.0.w,
        //                             ),
        //                             GestureDetector(
        //                               onTap: () {
        //                                 RTPConfirmationDialog.show(context,
        //                                     index: index,
        //                                     model: model,
        //                                     activity: activity, onAccepted: () {
        //                                   Navigator.pop(context);
        //                                   InformationDialog.show(
        //                                     context,
        //                                     isSwipeToCancel: true,
        //                                     onDismissed: () =>
        //                                         Navigator.pop(context),
        //                                     onSelected: () {
        //                                       Navigator.pop(context);
        //                                       //Todo Api calling
        //                                     },
        //                                     image: AssetUtils.acceptIcon,
        //                                     title: S.current.acceptRequest,
        //                                     descriptionWidget: RichText(
        //                                       text: TextSpan(
        //                                         children: [
        //                                           TextSpan(
        //                                             text: S.current
        //                                                 .youareabouttosend,
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w400,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                           TextSpan(
        //                                             text:
        //                                                 "${(activity?[index].amount) ?? ""}" +
        //                                                     " JOD ",
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w600,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                           TextSpan(
        //                                             text: S.current.to,
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w400,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                           TextSpan(
        //                                             text:
        //                                                 " ${(activity?[index].cdtrName) ?? ""}",
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w600,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                           TextSpan(
        //                                             text: S.current
        //                                                 .asperhisrequestconfirmthisaction,
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w400,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   );
        //                                 }, onRejected: () {
        //                                   Navigator.pop(context);
        //                                   InformationDialog.show(
        //                                     context,
        //                                     isSwipeToCancel: true,
        //                                     onDismissed: () {
        //                                       Navigator.pop(context);
        //                                     },
        //                                     onSelected: () {
        //                                       Navigator.pop(context);
        //                                       //Todo api calling
        //                                     },
        //                                     image: AssetUtils.rejectIcon,
        //                                     title: S.current.rejectRequest,
        //                                     descriptionWidget: RichText(
        //                                       text: TextSpan(
        //                                         children: [
        //                                           TextSpan(
        //                                             text: S.current
        //                                                 .youareabouttoreject,
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w400,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                           TextSpan(
        //                                             text:
        //                                                 "${(activity?[index].amount) ?? ""}" +
        //                                                     " JOD ",
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w600,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                           TextSpan(
        //                                             text: S.current.requestFrom,
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w400,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                           TextSpan(
        //                                             text:
        //                                                 " ${(activity?[index].cdtrName) ?? ""} ",
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w600,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                           TextSpan(
        //                                             text: S.current
        //                                                 .asperhisrequestconfirmthisaction,
        //                                             style: TextStyle(
        //                                                 fontFamily:
        //                                                     StringUtils.appFont,
        //                                                 fontSize: 14.0.t,
        //                                                 fontWeight:
        //                                                     FontWeight.w400,
        //                                                 color: Theme.of(context)
        //                                                     .primaryColorDark),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   );
        //                                 });
        //                               },
        //                               child: Container(
        //                                 decoration: BoxDecoration(
        //                                     color: AppColor.white,
        //                                     border: Border.all(
        //                                         color: AppColor.white_gray),
        //                                     borderRadius:
        //                                         BorderRadius.circular(20)),
        //                                 height: 40.h,
        //                                 child: Center(
        //                                     child: Padding(
        //                                   padding: EdgeInsets.symmetric(
        //                                     horizontal: 16.0.w,
        //                                     vertical: 10.h,
        //                                   ),
        //                                   child: Text(
        //                                     S.of(context).reject,
        //                                     style: TextStyle(
        //                                         fontFamily: StringUtils.appFont,
        //                                         color: AppColor.black,
        //                                         fontSize: 12.0.t,
        //                                         fontWeight: FontWeight.w600),
        //                                   ),
        //                                 )),
        //                               ),
        //                             )
        //                           ],
        //                         )
        //                       ],
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(vertical: 16.0.h),
        //             child: Divider(
        //               thickness: 4,
        //               color: Colors.red,
        //             ),
        //           )
        //         ],
        //       );
        //     },
        //     shrinkWrap: true,
        //     itemCount: activity!.length,
        //     separatorBuilder: (BuildContext context, int index) {
        //       return Padding(
        //         padding: EdgeInsets.symmetric(vertical: 15.0.h),
        //         child: Container(
        //           height: 1,
        //           color: AppColor.light_grayish_violet,
        //         ),
        //       );
        //     },
        //   ),
        // ),

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
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Center(
                          child: trxDIR ==
                                  RequestMoneyActivityStatusEnum
                                      .TRANSACTION_DIRECTORY_INCOMING
                              ? Text(
                                  dbtrDpText,
                                  // activity![index].dbtrName.split(" ").length >
                                  //         1
                                  //     ? StringUtils.getFirstInitials(
                                  //         (activity?[index].dbtrName) ?? "")
                                  //     : "",
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0.t),
                                )
                              : Text(
                                  cdtrDpText,
                                  // activity![index].cdtrName.split(" ").length >
                                  //         1
                                  //     ? StringUtils.getFirstInitials(
                                  //         (activity?[index].cdtrName) ?? "")
                                  //     : "",
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
                          trxDIR ==
                                  RequestMoneyActivityStatusEnum
                                      .TRANSACTION_DIRECTORY_INCOMING
                              ? //*Dbtr text
                              RichText(
                                  maxLines: 3,
                                  text: TextSpan(
                                      text: S.of(context).youRequested,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.0.t,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      children: [
                                        TextSpan(
                                          text: amount,
                                          // " ${(activity?[index].amount) ?? ""} ${S.of(context).JOD}",
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12.0.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                          children: [
                                            TextSpan(
                                              text: S.of(context).from,
                                              style: TextStyle(
                                                  fontFamily:
                                                      StringUtils.appFont,
                                                  fontSize: 12.0.t,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context)
                                                      .primaryColorDark),
                                              children: [
                                                TextSpan(
                                                  text: dbtrName,
                                                  // "${(activity?[index].dbtrName) ?? ""}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        StringUtils.appFont,
                                                    fontSize: 12.0.t,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColor.sky_blue_mid,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]))
                              : //*Cdtr text
                              RichText(
                                  maxLines: 3,
                                  text: TextSpan(
                                      text: cdtrName,
                                      //  (activity?[index].cdtrName) ?? "",
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.0.t,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.sky_blue_mid,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: S.current.requested,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 12.0.t,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                            children: [
                                              TextSpan(
                                                text: amount,
                                                // "${(activity?[index].amount) ?? ""}" +
                                                //     " JOD",
                                                style: TextStyle(
                                                  fontFamily:
                                                      StringUtils.appFont,
                                                  fontSize: 12.0.t,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: S.of(context).from,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            StringUtils.appFont,
                                                        fontSize: 12.0.t,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Theme.of(context)
                                                            .primaryColorDark),
                                                    children: [
                                                      TextSpan(
                                                        text: S.current.you,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              StringUtils
                                                                  .appFont,
                                                          fontSize: 12.0.t,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorDark,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ])
                                      ])),
                          Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: trxDIR ==
                                          RequestMoneyActivityStatusEnum
                                              .TRANSACTION_DIRECTORY_INCOMING &&
                                      trxStatus ==
                                          RequestMoneyActivityStatusEnum
                                              .CATEGORY_PENDING
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          rtpDate,
                                          // TimeUtils
                                          //     .getFormattedTimeForTransaction(
                                          //         (activity?[index]
                                          //                 .rtpDate
                                          //                 .toString()) ??
                                          //             ""),
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.gray1,
                                              fontSize: 12.0.t,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  RTPConfirmationDialog.show(
                                                      context,
                                                      index: index,
                                                      model: model,
                                                      activity: activity,
                                                      onAccepted: () {
                                                    Navigator.pop(context);
                                                    InformationDialog.show(
                                                      context,
                                                      isSwipeToCancel: true,
                                                      onDismissed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      onSelected: () {
                                                        onAcceptButton.call();
                                                      },
                                                      image:
                                                          AssetUtils.acceptIcon,
                                                      title: S.current
                                                          .acceptRequest,
                                                      descriptionWidget:
                                                          RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: S.current
                                                                  .youareabouttosend,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: amount,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  S.current.to,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: cdtrName,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: S.current
                                                                  .asperhisrequestconfirmthisaction,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }, onRejected: () {
                                                    Navigator.pop(context);
                                                    InformationDialog.show(
                                                      context,
                                                      isSwipeToCancel: true,
                                                      onDismissed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      onSelected: () {
                                                        Navigator.pop(context);
                                                        //Todo api calling
                                                      },
                                                      image:
                                                          AssetUtils.rejectIcon,
                                                      title: S.current
                                                          .rejectRequest,
                                                      descriptionWidget:
                                                          RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: S.current
                                                                  .youareabouttoreject,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: amount,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: S.current
                                                                  .requestFrom,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: cdtrName,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: S.current
                                                                  .asperhisrequestconfirmthisaction,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColor.sky_blue_mid,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 16.0.w,
                                                      vertical: 10.h,
                                                    ),
                                                    child: Text(
                                                      S.of(context).accept,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            StringUtils.appFont,
                                                        color: AppColor.white,
                                                        fontSize: 12.0.t,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                  RTPConfirmationDialog.show(
                                                      context,
                                                      index: index,
                                                      model: model,
                                                      activity: activity,
                                                      onAccepted: () {
                                                    Navigator.pop(context);
                                                    InformationDialog.show(
                                                      context,
                                                      isSwipeToCancel: true,
                                                      onDismissed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      onSelected: () {
                                                        Navigator.pop(context);
                                                        //Todo Api calling
                                                      },
                                                      image:
                                                          AssetUtils.acceptIcon,
                                                      title: S.current
                                                          .acceptRequest,
                                                      descriptionWidget:
                                                          RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: S.current
                                                                  .youareabouttosend,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: amount,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  S.current.to,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: cdtrName,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: S.current
                                                                  .asperhisrequestconfirmthisaction,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }, onRejected: () {
                                                    Navigator.pop(context);
                                                    InformationDialog.show(
                                                      context,
                                                      isSwipeToCancel: true,
                                                      onDismissed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      onSelected: () {
                                                        Navigator.pop(context);
                                                        //Todo api calling
                                                      },
                                                      image:
                                                          AssetUtils.rejectIcon,
                                                      title: S.current
                                                          .rejectRequest,
                                                      descriptionWidget:
                                                          RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: S.current
                                                                  .youareabouttoreject,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: amount,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: S.current
                                                                  .requestFrom,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: cdtrName,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                            TextSpan(
                                                              text: S.current
                                                                  .asperhisrequestconfirmthisaction,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .appFont,
                                                                  fontSize:
                                                                      14.0.t,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      border: Border.all(
                                                          color: AppColor
                                                              .white_gray),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 16.0.w,
                                                      vertical: 10.h,
                                                    ),
                                                    child: Text(
                                                      S.of(context).reject,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              StringUtils
                                                                  .appFont,
                                                          color: AppColor.black,
                                                          fontSize: 12.0.t,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                          TimeUtils
                                              .getFormattedTimeForTransaction(
                                                  (activity?[index]
                                                          .rtpDate
                                                          .toString()) ??
                                                      ""),
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.gray1,
                                              fontSize: 12.0.t,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 9.0.w),
                                          child: Container(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 8.0.w,
                                                end: 8.0.w,
                                                top: 3.5.h,
                                                bottom: 1.5.h),
                                            decoration: BoxDecoration(
                                                color: model.getColor(
                                                    activity![index].trxStatus),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Text(
                                              (activity?[index]
                                                      .trxStatus
                                                      .toString()) ??
                                                  "",
                                              style: TextStyle(
                                                  fontFamily:
                                                      StringUtils.appFont,
                                                  color: Theme.of(context)
                                                      .accentColor,
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
            itemCount: activity!.length,
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
}

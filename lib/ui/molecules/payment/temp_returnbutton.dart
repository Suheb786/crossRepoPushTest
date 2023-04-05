// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/Inward_RTP/RTP_confirmation_dialog/RTP_confirmation_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class TempReturnButton extends StatelessWidget {
  const TempReturnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.only(start: 24.0, end: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                //* ACCEPT/REJECT POP UP
                RTPConfirmationDialog.show(
                  context,
                  amount: "",
                  isAmountVisible: false,
                  cdtrAcct: "EFBKI000012341234123819241213|",
                  cdtrDpText: StringUtils.getFirstInitials("Ahmed Lutfi"),
                  cdtrName: "Ahmed Lutfi",
                  description: RichText(
                      maxLines: 3,
                      text: TextSpan(
                          text: "Ahmed Lutfi ",
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 14.0.t,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              color: AppColor.veryDarkGray1),
                          children: [
                            TextSpan(
                              text: S.current.isRequesting,

                              // "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.0.t,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColorDark),
                              children: [
                                TextSpan(
                                  text: " 10.00 JOD",
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.0.t,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.veryDarkGray1),
                                  children: [
                                    TextSpan(
                                      text: S.current.fromYouWouldYouLikeToAcceptIt,
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14.0.t,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                        // color: AppColor.sky_blue_mid,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ])),
                  showDescription: true,
                  actionWidget: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: AppColor.sky_blue_mid,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                            ),
                            child: Text(
                              S.of(context).accept,
                              textAlign: TextAlign.center,
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
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(color: AppColor.sky_blue_mid),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                            ),
                            child: Text(
                              S.of(context).reject,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.sky_blue_mid,
                                fontSize: 12.0.t,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  listOfDetails: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.date,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 12.t,
                                color: AppColor.very_dark_gray1,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "12 September 2021",
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 12.t,
                              color: AppColor.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 12.t,
                                color: AppColor.very_dark_gray1,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "8:21 PM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 12.t,
                              color: AppColor.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  currency: '',
                );
              },
              child: Text(
                "11 September",
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 15.0.t,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColorDark),
              ),
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
                      GestureDetector(
                        onTap: () {
                          //* CREDIT CONFIRMATION POP UP
                          RTPConfirmationDialog.show(
                            context,
                            amount: "- 10.000",
                            isAmountVisible: true,
                            cdtrAcct: "EFBKI000012341234123819241213|",
                            cdtrDpText: StringUtils.getFirstInitials("Ahmed Lutfi"),
                            cdtrName: "Ahmed Lutfi",
                            description: Container(),
                            showDescription: false,
                            actionWidget: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RoutePaths.CreditConfirmation);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  border: Border.all(color: AppColor.white_gray),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.0.w,
                                    vertical: 16.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).creditConfirmation,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.skyblue,
                                          fontSize: 12.0.t,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      AppSvg.asset(AssetUtils.creditConfirmation, height: 16.h, width: 16.h)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            listOfDetails: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   S.current.status,
                                    //   style: TextStyle(
                                    //       fontFamily: StringUtils.appFont,
                                    //       fontSize: 12.t,
                                    //       fontWeight: FontWeight.w400),
                                    // ),
                                    // Text(
                                    //   "Rejected",
                                    //   style: TextStyle(
                                    //       fontFamily: StringUtils.appFont,
                                    //       fontSize: 12.t,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current.transactionType,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.very_dark_gray1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "Send Money",
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current.date,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.very_dark_gray1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "12 September 2021",
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Time",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.very_dark_gray1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "8:21 PM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ref ID",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.very_dark_gray1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "1209323102133939",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            currency: '',
                          );
                        },
                        child: Container(
                            height: 50.0.h,
                            width: 50.0.w,
                            decoration:
                                BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                            child: Center(
                                child: Text(
                              StringUtils.getFirstInitials("Shakila"),
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0.t),
                            ))),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 14.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  maxLines: 3,
                                  text: TextSpan(
                                      text: "Shakila",
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.0.t,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.skyblue),
                                      children: [
                                        TextSpan(
                                          text: S.current.sent,

                                          // "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12.0.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).primaryColorDark),
                                          children: [
                                            TextSpan(
                                              text: " 10.00 JOD",
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12.0.t,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context).primaryColorDark),
                                              children: [
                                                TextSpan(
                                                  text: S.current.toYou,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 12.0.t,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    // color: AppColor.sky_blue_mid,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ])),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        //* STATUS POP UP
                                        RTPConfirmationDialog.show(
                                          context,
                                          amount: "- 10.000",
                                          isAmountVisible: false,
                                          cdtrAcct: "EFBKI000012341234123819241213|",
                                          cdtrDpText: StringUtils.getFirstInitials("Ahmed Lutfi"),
                                          cdtrName: "Ahmed Lutfi",
                                          showDescription: true,
                                          actionWidget: Container(),
                                          description: RichText(
                                              text: TextSpan(
                                                  text: S.current.yourequested,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14.0.t,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColor.veryDarkGray1),
                                                  children: [
                                                TextSpan(
                                                  text: " 10.00 JOD ",
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14.0.t,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColor.veryDarkGray1),
                                                  children: [
                                                    TextSpan(
                                                      text: S.current.fromSingleLine,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.0.t,
                                                        overflow: TextOverflow.ellipsis,
                                                        fontWeight: FontWeight.w400,
                                                        // color: AppColor.sky_blue_mid,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: " Ahmed Lutfi",
                                                          style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontSize: 14.0.t,
                                                            overflow: TextOverflow.ellipsis,
                                                            fontWeight: FontWeight.w700,
                                                            // color: AppColor.sky_blue_mid,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ])),
                                          listOfDetails: Column(
                                            children: [
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    S.current.status,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: AppColor.very_dark_gray1,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: AppColor.dark_brown),
                                                    padding: EdgeInsets.only(
                                                        left: 8.w, right: 8.w, top: 4.h, bottom: 1.h),
                                                    child: Text(
                                                      "Rejected",
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 12.t,
                                                          color: AppColor.white,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    S.current.reason,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: AppColor.very_dark_gray1,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                  Text(
                                                    "Personal",
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: AppColor.black,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    S.current.date,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: AppColor.very_dark_gray1,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                  Text(
                                                    "12 September 2021",
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: AppColor.black,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Time",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: AppColor.very_dark_gray1,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                  Text(
                                                    "8:21 PM",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: AppColor.black,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          currency: '',
                                        );
                                      },
                                      child: Text(
                                        "12:03 AM",
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: AppColor.gray1,
                                            fontSize: 12.0.t,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(top: 5.0.h),
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       RTPConfirmationDialog.show(
                                    //         context,
                                    //         amount: "10.00",
                                    //         cdtrAcct: "EFBKI000012341234123819241213|",
                                    //         cdtrDpText: StringUtils.getFirstInitials("Shakila Naseem"),
                                    //         cdtrName: "Shakila Naseem",
                                    //         description: Container(),
                                    //         listOfDetails: Column(
                                    //           children: [
                                    //             Row(
                                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //               children: [
                                    //                 Text(
                                    //                   S.current.date,
                                    //                   style: TextStyle(
                                    //                       fontFamily: StringUtils.appFont,
                                    //                       fontSize: 12.t,
                                    //                       fontWeight: FontWeight.w400),
                                    //                 ),
                                    //                 Text(
                                    //                   "12 September 2021",
                                    //                   style: TextStyle(
                                    //                       fontFamily: StringUtils.appFont,
                                    //                       fontSize: 12.t,
                                    //                       fontWeight: FontWeight.w600),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //             SizedBox(
                                    //               height: 16.h,
                                    //             ),
                                    //             Row(
                                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //               children: [
                                    //                 Text(
                                    //                   "Time",
                                    //                   textAlign: TextAlign.center,
                                    //                   style: TextStyle(
                                    //                       fontFamily: StringUtils.appFont,
                                    //                       fontSize: 12.t,
                                    //                       fontWeight: FontWeight.w400),
                                    //                 ),
                                    //                 Text(
                                    //                   "8:21 PM",
                                    //                   textAlign: TextAlign.center,
                                    //                   style: TextStyle(
                                    //                       fontFamily: StringUtils.appFont,
                                    //                       fontSize: 12.t,
                                    //                       fontWeight: FontWeight.w600),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //             SizedBox(
                                    //               height: 16.h,
                                    //             ),
                                    //             Row(
                                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //               children: [
                                    //                 Text(
                                    //                   "Ref ID",
                                    //                   textAlign: TextAlign.center,
                                    //                   style: TextStyle(
                                    //                       fontFamily: StringUtils.appFont,
                                    //                       fontSize: 12.t,
                                    //                       fontWeight: FontWeight.w400),
                                    //                 ),
                                    //                 Text(
                                    //                   "1209323102133939",
                                    //                   textAlign: TextAlign.center,
                                    //                   style: TextStyle(
                                    //                       fontFamily: StringUtils.appFont,
                                    //                       fontSize: 12.t,
                                    //                       fontWeight: FontWeight.w600),
                                    //                 ),
                                    //               ],
                                    //             )
                                    //           ],
                                    //         ),
                                    //         showDescription: false,
                                    //         actionWidget: GestureDetector(
                                    //           onTap: () {
                                    //             Navigator.pushNamed(
                                    //                 context, RoutePaths.ReturnPaymentSliderPage);
                                    //           },
                                    //           child: Container(
                                    //             width: double.infinity,
                                    //             decoration: BoxDecoration(
                                    //               color: AppColor.sky_blue_mid,
                                    //               borderRadius: BorderRadius.circular(100),
                                    //             ),
                                    //             child: Padding(
                                    //               padding: EdgeInsets.symmetric(
                                    //                 horizontal: 16.0.w,
                                    //                 vertical: 16.h,
                                    //               ),
                                    //               child: Text(
                                    //                 S.of(context).returnPayment,
                                    //                 textAlign: TextAlign.center,
                                    //                 style: TextStyle(
                                    //                   fontFamily: StringUtils.appFont,
                                    //                   color: AppColor.white,
                                    //                   fontSize: 12.0.t,
                                    //                   fontWeight: FontWeight.w600,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     },
                                    //     child: Container(
                                    //       decoration: BoxDecoration(
                                    //         border: Border.all(color: AppColor.skyblue),
                                    //         borderRadius: BorderRadius.circular(20),
                                    //       ),
                                    //       child: Padding(
                                    //         padding: EdgeInsets.symmetric(
                                    //           horizontal: 16.0.w,
                                    //           vertical: 10.h,
                                    //         ),
                                    //         child: Text(
                                    //           S.current.returnPayment,
                                    //           style: TextStyle(
                                    //             fontFamily: StringUtils.appFont,
                                    //             color: AppColor.skyblue,
                                    //             fontSize: 12.0.t,
                                    //             fontWeight: FontWeight.w600,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          //* RETURN PAYMENT POP UP
                          RTPConfirmationDialog.show(
                            context,
                            amount: "10.00",
                            isAmountVisible: true,
                            cdtrAcct: "EFBKI000012341234123819241213|",
                            cdtrDpText: StringUtils.getFirstInitials("Shakila Naseem"),
                            cdtrName: "Shakila Naseem",
                            description: Container(),
                            listOfDetails: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current.date,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.very_dark_gray1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "12 September 2021",
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Time",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.very_dark_gray1,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "8:21 PM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ref ID",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.very_dark_gray1,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "1209323102133939",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            showDescription: false,
                            actionWidget: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RoutePaths.ReturnPaymentSliderPage);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColor.sky_blue_mid,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0.w,
                                    vertical: 16.h,
                                  ),
                                  child: Text(
                                    S.of(context).returnPayment,
                                    textAlign: TextAlign.center,
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
                            currency: '',
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.chevron_right,
                            color: AppColor.white_gray,
                          ),
                        ),
                      )

                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 16.0.h),
                      //   child: Divider(
                      //     thickness: 114,
                      //     color: Colors.red,
                      //   ),
                      // )
                    ],
                  );
                },
                shrinkWrap: true,
                itemCount: 2,
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
        ),
      ),
    );
  }
}

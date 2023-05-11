// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RTPConfirmationDialogView extends StatelessWidget {
  final String amount;
  final String cdtrAcct;
  final String cdtrDpText;
  final String cdtrName;

  final Function? onAccepted;
  final Function? onDismiss;
  final Function? onRejected;
  final Widget listOfDetails;
  final Widget description;
  final bool showDescription;
  final bool isAmountVisible;
  final String currency;
  final Widget actionWidget;

  const RTPConfirmationDialogView(
      {this.onDismiss,
      this.onAccepted,
      this.onRejected,
      required this.currency,
      required this.isAmountVisible,
      required this.actionWidget,
      required this.description,
      required this.listOfDetails,
      required this.showDescription,
      required this.cdtrName,
      required this.cdtrDpText,
      required this.amount,

      required this.cdtrAcct});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                Navigator.pop(context);
              }
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 32.h),
                      Container(
                          height: 64.0.h,
                          width: 64.0.h,
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                          child: Center(
                            child: Text(
                              cdtrDpText,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0.t),
                            ),
                          )),
                      SizedBox(height: 16.0.h),
                      Visibility(
                        visible: isAmountVisible,
                        child: RichText(
                          text: TextSpan(
                            text: amount,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 24.t,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black),
                            children: [
                              TextSpan(text: " "),
                              TextSpan(
                                text: currency,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.t,
                                    color: AppColor.light_gray,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(
                        cdtrName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.veryDarkGray1,
                            fontSize: 20.t,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        cdtrAcct,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont, fontSize: 12.t, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 31.h),
                      Visibility(
                          visible: showDescription,
                          child: showDescription == true ? description : Container()),
                      Column(
                        children: [
                          listOfDetails,
                        ],
                      ),
                      SizedBox(height: 32.h),
                      actionWidget,
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 16.h),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              S.of(context).swipeDownToCancel,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 10.t,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.dark_gray_1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}

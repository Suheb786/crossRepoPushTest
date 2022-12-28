import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RTPConfirmationDialogView extends StatelessWidget {
  final Function? onAccepted;
  final Function? onRejected;
  final Function? onDismiss;

  final List<RequestMoneyActivityList>? activity;
  final int index;
  final PaymentActivityTransactionViewModel model;

  const RTPConfirmationDialogView(
      {this.activity,
      required this.index,
      required this.model,
      this.onDismiss,
      this.onAccepted,
      this.onRejected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding:
            EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
                          height: 50.0.h,
                          width: 50.0.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          child: Center(
                            child: Text(
                              activity![index].dbtrName.split(" ").length > 1
                                  ? StringUtils.getFirstInitials(
                                      (activity?[index].cdtrName) ?? "")
                                  : "",
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0.t),
                            ),
                          )),
                      SizedBox(height: 16.0.h),
                      Text(
                        (activity?[index].cdtrName) ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 20.t,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        (activity?[index].cdtrAcct) ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 12.t,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 31.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: (activity?[index].cdtrName) ?? "",
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.0.t,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            TextSpan(
                              text: S.current.isRequesting,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.0.t,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            TextSpan(
                              text:
                                  "${(activity?[index].amount) ?? ""}" + " JOD",
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.0.t,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            TextSpan(
                              text: S.current.fromYouWouldYouLikeToAcceptIt,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.0.t,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              onAccepted?.call();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              height: 48.h,
                              // width: 57.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context)
                                      .accentTextTheme
                                      .bodyText1!
                                      .color!),
                              child: Center(
                                child: Text(S.current.accept,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.t,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.white)),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          InkWell(
                            onTap: () {
                              onRejected?.call();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              height: 48.h,
                              // width: 57.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppColor.white_gray),
                              ),
                              child: Center(
                                child: Text(S.current.reject,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.t,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.sky_blue_mid)),
                              ),
                            ),
                          ),
                        ],
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

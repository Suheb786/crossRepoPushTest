import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/constants/enum/transaction_type.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_view_model.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/edit_transaction_purpose_dialog/edit_transaction_purpose_dialog.dart';
import 'package:neo_bank/ui/molecules/numeric_keyboard.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SendAmountToContactPageView extends BasePageViewWidget<SendAmountToContactViewModel> {
  SendAmountToContactPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
          } else {
            Navigator.pop(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.0.h),
                    child: Container(
                      height: 50.h,
                      width: 281.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    child: Column(
                      children: [
                        AppSvg.asset(AssetUtils.downArrow),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0.h),
                          child: Text(
                            S.of(context).backToPayments,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 12.t,
                                fontWeight: FontWeight.w600,
                                color: AppColor.dark_gray_2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0.h),
              child: model.beneficiary.imageUrl.toString().isNotEmpty
                  ? CircleAvatar(
                      radius: 28.w,
                      backgroundImage: Image.memory(
                        model.beneficiary.imageUrl,
                        fit: BoxFit.cover,
                      ).image,
                    )
                  : CircleAvatar(
                      radius: 28.w,
                      backgroundColor: Theme.of(context).canvasColor,
                      child: Text(
                        StringUtils.getFirstInitials(model.beneficiary.fullName),
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.t,
                            color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                S.of(context).sendMoneyTo,
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.t,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 24.w, start: 24.w),
              child: Text(
                (model.beneficiary.nickName != null && model.beneficiary.nickName!.isNotEmpty)
                    ? model.beneficiary.nickName!
                    : model.beneficiary.fullName!,
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.t,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 16.h, end: 24.w, start: 24.w),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColor.whiteGray)),
                padding: EdgeInsetsDirectional.only(top: 14.h, bottom: 14.h, start: 26.w, end: 34.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).transactionPurpose,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: AppColor.dark_gray_1,
                          fontSize: 10.t,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppStreamBuilder<String>(
                              stream: model.purposeStream,
                              initialData: (model.beneficiary.purposeParentDetails != null &&
                                      model.beneficiary.purposeParentDetails!.isNotEmpty)
                                  ? model.beneficiary.purposeParentDetails!
                                  : '',
                              dataBuilder: (context, value) {
                                return Text(
                                  value!,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 12.t,
                                      fontWeight: FontWeight.w600),
                                );
                              }),
                          Visibility(
                            visible: true,
                            child: InkWell(
                              onTap: () {
                                EditTransactionPurposeDialog.show(context, onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value1, value2) {
                                  model.updatePurpose(value1);
                                  model.updatePurposeDetail(value2);
                                  Navigator.pop(context);
                                },
                                    purposeDetail: model.purposeDetail == null
                                        ? model.beneficiary.purposeDetails!
                                        : model.purposeDetail!.labelEn,
                                    purpose: model.purpose == null
                                        ? model.beneficiary.purposeParentDetails
                                        : model.purpose!.labelEn,
                                    beneficiary: model.beneficiary,
                                    type: TransactionType.SM);
                              },
                              child: Text(
                                S.of(context).edit,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.t,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).textTheme.bodyMedium!.color!),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: AppStreamBuilder<String>(
                          stream: model.purposeDetailStream,
                          initialData: (model.beneficiary.purposeDetails != null &&
                                  model.beneficiary.purposeDetails!.isNotEmpty)
                              ? model.beneficiary.purposeDetails!
                              : '',
                          dataBuilder: (context, value) {
                            return Text(
                              value!,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 12.t,
                                  fontWeight: FontWeight.w600),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 27.h, start: 24.w, end: 24.w),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection:
                          StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              model.currentPinValue,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.t,
                                  color: AppColor.black),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 15.h, start: 4.w),
                              child: Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.verLightGray4,
                                    fontSize: 16.t,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          model.clearValue();
                        },
                        child: AppSvg.asset(AssetUtils.backspaceBlue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: Text(
                S.of(context).accountBalance,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.t,
                    color: AppColor.dark_gray_1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ProviderScope.containerOf(context)
                        .read(appHomeViewModelProvider)
                        .dashboardDataContent
                        .account!
                        .availableBalance!,
                    style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.t,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 4.0.w, top: 2.h),
                    child: Text(
                      S.of(context).JOD,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.t,
                          color: AppColor.dark_gray_1),
                    ),
                  ),
                ],
              ),
            ),
            AppStreamBuilder<Resource<TransferSuccessResponse>>(
                stream: model.transferStream,
                initialData: Resource.none(),
                onData: (data) async {
                  if (data.status == Status.SUCCESS) {
                    ///LOGGING EVENT TO APP FLYER
                    model.logEventsForAppFlyer(
                        eventName: 'send_money_to_contact',
                        eventValue: {"money_sent": data.data?.transferSuccessContent?.amount ?? 0.0});

                    ///LOG EVENT TO FIREBASE
                    await FireBaseLogUtil.fireBaseLog("send_money_to_saved_beneficiary_success", {
                      "is_money_sent": true,
                      "money_sent": data.data?.transferSuccessContent?.amount ?? 0.0
                    });
                    data.data!.transferSuccessContent?.paymentMadeTo = model.beneficiary.iban ?? '';
                    Navigator.pushNamed(context, RoutePaths.SendAmountToContactSuccess,
                        arguments: data.data!.transferSuccessContent);
                  } else if (data.status == Status.ERROR) {
                    ///LOG EVENT TO FIREBASE
                    await FireBaseLogUtil.fireBaseLog(
                        "send_money_to_saved_beneficiary_failure", {"is_money_sent": false});
                    //Navigator.pushNamed(context, RoutePaths.SendMoneyFailure);
                    if (data.appError!.type == ErrorType.INVALID_OTP_NETWORK) {
                      model.showToastWithError(data.appError!);
                    } else if (data.appError!.type == ErrorType.DAILY_LIMIT_EXCEDED) {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.SendMoneyFailure,
                        arguments: SendMoneyFailurePageArgument(
                            title: S.of(context).sendMoneyNotSuccessful,
                            content: S.of(context).dailyLimitExceededorTryLater),
                      );
                    } else if (data.appError!.type == ErrorType.LOGIN_REGISTER_DISABLED) {
                      model.showToastWithError(data.appError!);
                    } else {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.SendMoneyFailure,
                        arguments: SendMoneyFailurePageArgument(
                            title: S.of(context).sendMoneyNotSuccessful,
                            content: S.of(context).tryAgainLater),
                      );
                    }
                  }
                },
                dataBuilder: (context, snapshot) {
                  return AppStreamBuilder<Resource<CheckSendMoneyResponse>>(
                      stream: model.checkSendMoneyStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.transfer(data.data!.checkSendMoneyContent!.transferResponse!);
                        }
                      },
                      dataBuilder: (context, checkSendMoneyResponse) {
                        return Expanded(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: NumericKeyboard(
                                onKeyboardTap: (value) {
                                  model.changeValue(value);
                                },
                                textColor: Colors.black,
                                rightButtonFn: () {
                                  if (double.parse(model.currentPinValue) <= 0) {
                                    model.showToastWithError(AppError(
                                        cause: Exception(),
                                        error: ErrorInfo(message: ""),
                                        type: ErrorType.ZERO_AMOUNT));
                                  } else if (model.beneficiary.purpose == null &&
                                      model.purposeDetail == null) {
                                    model.showToastWithError(AppError(
                                        cause: Exception(),
                                        error: ErrorInfo(message: ""),
                                        type: ErrorType.EMPTY_PURPOSE_DETAIL));
                                  } else {
                                    model.checkSendMoney();
                                  }
                                },
                                leftIcon: Icon(
                                  Icons.circle,
                                  color: AppColor.black,
                                  size: 5,
                                ),
                                rightWidget: CircleAvatar(
                                  radius: 30.w,
                                  backgroundColor: Color(0xFF3CB4E5),
                                  child: Center(
                                    child: AppSvg.asset(AssetUtils.next),
                                  ),
                                ),
                                leftButtonFn: () {
                                  model.changeValue(".");
                                },
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}

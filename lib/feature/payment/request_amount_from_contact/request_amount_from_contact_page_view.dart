import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/constants/enum/transaction_type.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/request_amount_from_contact/request_amount_from_contact_view_model.dart';
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

import '../../../di/payment/payment_modules.dart';
import '../account_swiching/payment_account_switcher.dart';
import '../payment_home/payment_home_view_model.dart';

class RequestAmountFromContactPageView extends BasePageViewWidget<RequestAmountFromContactViewModel> {
  RequestAmountFromContactPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<RequestToPayContentResponse>>(
          stream: model.requestFromContactResponseStream,
          initialData: Resource.none(),
          onData: (data) async {
            if (data.status == Status.ERROR) {
              model.showToastWithError(data.appError!);

              ///LOG EVENT TO FIREBASE
              await FireBaseLogUtil.fireBaseLog(
                  "request_money_saved_beneficiary_failure", {"is_money_requested": false});
            } else if (data.status == Status.SUCCESS) {
              ///LOGGING EVENT TO APP FLYER
              model.logEventsForAppFlyer(
                  eventName: 'request_money_from_contact',
                  eventValue: {"money_requested": model.currentPinValue});

              ///LOG EVENT TO FIREBASE
              await FireBaseLogUtil.fireBaseLog("request_money_saved_beneficiary_success",
                  {"is_money_requested": true, "money_requested": model.currentPinValue});
              Navigator.pushNamed(context, RoutePaths.RequestAmountFromContactSuccess, arguments: [
                model.currentPinValue,
                data.data!.requestToPayContent!.dbtrName!,
                model.beneficiary?.iban ?? '',
              ]);
            }
          },
          dataBuilder: (context, value) {
            return AppStreamBuilder<Resource<GetAccountByAliasContentResponse>>(
                stream: model.getAccountByAliasResponseStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.ERROR) {
                    model.showToastWithError(data.appError!);
                    model.showBackButton
                        ? Navigator.pop(context)
                        : ProviderScope.containerOf(context)
                            .read(paymentHomeViewModelProvider)
                            .animatePage(AnimatedPage.REQUEST_FROM_SPECIFIC_PERSON);
                  }
                },
                dataBuilder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.showBackButton
                          ? Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: InkWell(
                                onTap: () {
                                  model.showBackButton
                                      ? Navigator.pop(context)
                                      : ProviderScope.containerOf(context)
                                          .read(paymentHomeViewModelProvider)
                                          .animatePage(AnimatedPage.REQUEST_FROM_SPECIFIC_PERSON);
                                },
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(bottom: 32.h, top: 50.h, start: 24.w),
                                  child: AppSvg.asset(
                                    AssetUtils.back,
                                    height: 24.h,
                                    width: 24.w,
                                    matchTextDirection: true,
                                    color: Theme.of(context).colorScheme.shadow,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: !model.showBackButton
                                ? ((MediaQuery.of(context).size.height * 0.14) + 24.h)
                                : 0),
                        child: model.beneficiary!.imageUrl.isNotEmpty
                            ? CircleAvatar(
                                radius: 32.w,
                                backgroundImage: Image.memory(
                                  model.beneficiary!.imageUrl,
                                  fit: BoxFit.cover,
                                ).image,
                              )
                            : CircleAvatar(
                                radius: 32.w,
                                backgroundColor: Theme.of(context).canvasColor,
                                child: Text(
                                  StringUtils.getFirstInitials(model.beneficiary!.fullName),
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.t,
                                      color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          S.of(context).requestMoneyFrom,
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w400,
                            fontSize: 20.t,
                          ),
                        ),
                      ),
                      Text(
                        (model.beneficiary!.nickName != null && model.beneficiary!.nickName!.isNotEmpty)
                            ? model.beneficiary!.nickName!
                            : model.beneficiary!.fullName!,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.t,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 16.h, end: 24.w, start: 24.w),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor.whiteGray)),
                          padding:
                              EdgeInsetsDirectional.only(top: 14.h, bottom: 14.h, start: 26.w, end: 34.w),
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
                                        initialData: (model.beneficiary!.purposeParentDetails != null &&
                                                model.beneficiary!.purposeParentDetails!.isNotEmpty)
                                            ? model.beneficiary!.purposeParentDetails!
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
                                              beneficiary: model.beneficiary,
                                              purposeDetail: model.purposeDetail == null
                                                  ? model.beneficiary!.purposeDetails!
                                                  : model.purposeDetail!.labelEn,
                                              purpose: model.purpose == null
                                                  ? model.beneficiary!.purposeParentDetails
                                                  : model.purpose!.labelEn,
                                              type: TransactionType.RTP);
                                        },
                                        child: Text(
                                          S.of(context).edit,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12.t,
                                              fontWeight: FontWeight.w700,
                                              color: Theme.of(context).textTheme.bodyLarge!.color!),
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
                                    initialData: (model.beneficiary!.purposeDetails != null &&
                                            model.beneficiary!.purposeDetails!.isNotEmpty)
                                        ? model.beneficiary!.purposeDetails!
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
                      Spacer(),
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 27.h, start: 24.w, end: 24.w),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Directionality(
                                textDirection: StringUtils.isDirectionRTL(context)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
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
                                        padding: EdgeInsetsDirectional.only(top: 6.h, start: 4.w),
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
                                alignment: AlignmentDirectional.centerEnd,
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
                        padding: EdgeInsets.only(top: 15.0.h, bottom: 10.0.h),
                        child: PaymentAccountSwitcher(
                          title: S.of(context).transferFrom,
                          onDefaultSelectedAccount: (Account account) {
                            model.selectedAccount = account;
                          },
                          onSelectAccount: (Account account) {
                            model.selectedAccount = account;
                          },
                          isSingleLineView: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.06),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: NumericKeyboard(
                              onKeyboardTap: (value) {
                                model.changeValue(value);
                              },
                              textColor: Colors.black,
                              rightButtonFn: () {
                                model.requestFromNewRecipient(context);
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
                      )
                    ],
                  );
                });
          }),
    );
  }
}

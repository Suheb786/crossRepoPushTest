import 'dart:ui';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill_conent.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'how_much_like_to_pay_prepaid_bills_page_view_model.dart';

class HowMuchLikeToPayPrePaidBillsPageView
    extends BasePageViewWidget<HowMuchLikeToPayPrePaidBillsPageViewModel> {
  HowMuchLikeToPayPrePaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, HowMuchLikeToPayPrePaidBillsPageViewModel model) {
    return AppStreamBuilder<Resource<ValidatePrePaidBill>>(
      initialData: Resource.none(),
      stream: model.validatePrePaidStream,
      onData: (value) {
        if (value.status == Status.SUCCESS) {
          model.dueAmount = value.data?.content?.dueAmount ?? '0';
          model.amtController.text = double.parse(value.data?.content?.dueAmount ?? "0").toStringAsFixed(3);
          model.feesAmt = value.data?.content?.feesAmount ?? "0";
          model.billerCode = value.data?.content?.billerCode ?? "";
          model.billingNumber = value.data?.content?.billingNo ?? "";
          model.otpCode = value.data?.content?.validationCode ?? "";
          model.isNewBiller = value.data?.content?.validationCode == "" ? false : true;
          model.validate(model.amtController.text);
          if (model.isPrepaidCategoryListEmpty == true) {
            Future.delayed(Duration(milliseconds: 200)).then((value) => model.payPrePaidBill(context));
          }
        }
      },
      dataBuilder: (context, snapshot) {
        return AppStreamBuilder<Resource<PayPrePaid>>(
          initialData: Resource.none(),
          stream: model.payPrePaidStream,
          onData: (value) {
            if (value.status == Status.SUCCESS) {
              Navigator.pushNamed(context, RoutePaths.PrePaidBillsSuccessPage,
                  arguments: PrePaidBillsSuccessPageArguments(value.data!.content ?? PaidBillContent()));

              var errorBillFail = value.data?.content?.paidBill?[0].statusDescription ?? "";
              if (errorBillFail == "err-377") {
                model.showToastWithError(AppError(
                    cause: Exception(),
                    error: ErrorInfo(message: ''),
                    type: ErrorType.BILL_PAYMENT_SORRY_MESSAGE));
              }
            } else {
              model.showToastWithError(value.appError!);
            }
          },
          dataBuilder: (context, snapshot) {
            return GestureDetector(
              onHorizontalDragEnd: (details) {
                if (StringUtils.isDirectionRTL(context)) {
                  if (!details.primaryVelocity!.isNegative) {
                    if (model.isPrepaidCategoryListEmpty == false) {
                      model.payPrePaidBill(context);
                    } else if (model.isPrepaidCategoryListEmpty == true) {
                      model.validatePrePaidBill();
                    }
                  } else {
                    Navigator.pop(context);
                  }
                } else {
                  if (details.primaryVelocity!.isNegative) {
                    if (model.isPrepaidCategoryListEmpty == false) {
                      model.payPrePaidBill(context);
                    } else if (model.isPrepaidCategoryListEmpty == true) {
                      model.validatePrePaidBill();
                    }
                  } else {
                    Navigator.pop(context);
                  }
                }
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.0.w, top: 96.h, bottom: 56.h),
                child: Column(
                  children: [
                    model.isPrepaidCategoryListEmpty == true
                        ? Container()
                        : Text(
                            S.of(context).paying,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 20.0.t,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                          ),
                    model.isPrepaidCategoryListEmpty == true
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeTextField(
                                wrapWords: false,
                                fullwidth: false,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
                                ],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                controller: model.amtController,
                                readOnly: true,
                                textAlign: TextAlign.center,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                    isDense: true, contentPadding: const EdgeInsetsDirectional.all(0.0)),
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 28.0.t),
                              ),
                              Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.gray5,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0.t),
                              ),
                            ],
                          ),
                    // model.isPrepaidCategoryListEmpty == true
                    //     ? Container()
                    //     : Text(
                    //         S.of(context).tapAmtToEdit,
                    //         style: TextStyle(
                    //           fontFamily: StringUtils.appFont,
                    //           fontSize: 12.0.t,
                    //           fontWeight: FontWeight.w600,
                    //           color: AppColor.brightBlue,
                    //         ),
                    //       ),
                    model.isPrepaidCategoryListEmpty == false
                        ? Container()
                        : Text(
                            S.of(context).payBill.toUpperCase(),
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 10.0.t,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                          ),
                    model.isPrepaidCategoryListEmpty == false
                        ? Container()
                        : Text(
                            S.of(context).howMuchWouldYouLikeToPay,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 20.0.t,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                          ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Expanded(
                      child: Card(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.h),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model.argument.payMyPrePaidBillsPageDataList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.black,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                                            child: Text(
                                              (index + 1).toString(),
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0.t),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              StringUtils.isDirectionRTL(context)
                                                  ? "${model.argument.payMyPrePaidBillsPageDataList[index].serviceTypeAR ?? ''}"
                                                  : "${model.argument.payMyPrePaidBillsPageDataList[index].serviceType ?? ''}",
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0.t),
                                            ),
                                            Text(
                                              StringUtils.isDirectionRTL(context)
                                                  ? "${model.argument.payMyPrePaidBillsPageDataList[index].billerNameAR ?? ''}"
                                                  : "${model.argument.payMyPrePaidBillsPageDataList[index].billerName ?? ''}",
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.veryDarkGray2,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0.t),
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                              model.feesAmt != null &&
                                      model.feesAmt!.isNotEmpty &&
                                  double.parse(model.feesAmt ?? "0.0") > 0.0
                                  ? Container(
                                margin: EdgeInsetsDirectional.only(top: 8.0.h),
                                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
                                      decoration: BoxDecoration(
                                          color: AppColor.lightGray,
                                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          AppSvg.asset(AssetUtils.infoFee, height: 16.h, width: 16.w),
                                          SizedBox(width: 8.w),
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(top: 4.0.h),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${S.of(context).fees} ",
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: AppColor.gray5,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12.0.t),
                                                ),
                                                Text(
                                                  model.feesAmt != null && model.feesAmt!.isNotEmpty
                                                      ? double.parse(model.feesAmt ?? "0.0")
                                                          .toStringAsFixed(3)
                                                      : "0.0",
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: AppColor.very_dark_gray1,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12.0.t),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: 32.h,
                              ),
                              model.isPrepaidCategoryListEmpty == false
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        S.of(context).pleaseEnter,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 14.0.t,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.gray_black,
                                        ),
                                      ),
                                    ),
                              model.isPrepaidCategoryListEmpty == false
                                  ? Container()
                                  : SizedBox(height: 16.h),
                              model.isPrepaidCategoryListEmpty == false
                                  ? Container()
                                  : _enterAmountAppTextField(model, context),
                              SizedBox(height: 16.h),
                              AppTextField(
                                labelText: S.of(context).payFrom.toUpperCase(),
                                hintText: S.of(context).savingAccount(''),
                                controller: model.savingAccountController,
                                readOnly: true,
                                onChanged: (val) {
                                  model.validate(model.amtController.text);
                                },

                                /*onPressed: () {
                                  AccountsDialog.show(context, label: S.of(context).selectAccount,
                                      onDismissed: () {
                                    Navigator.pop(context);
                                  }, onSelected: (value) {
                                    model.savingAccountController.text = value;
                                    model.validate(model.amtController.text);
                                    Navigator.pop(context);
                                  }, accountsList: [
                                    ProviderScope.containerOf(context)
                                            .read(appHomeViewModelProvider)
                                            .dashboardDataContent
                                            .account
                                            ?.accountNo ??
                                        ''
                                  ]);
                                },*/
                                // suffixIcon: (value, data) {
                                //   return Container(
                                //       height: 16.h,
                                //       width: 16.w,
                                //       padding: EdgeInsetsDirectional.only(end: 8.w),
                                //       child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                                // },
                              ),
                              SizedBox(
                                height: 110.h,
                              ),
                              GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  if (StringUtils.isDirectionRTL(context)) {
                                    if (!details.primaryVelocity!.isNegative) {
                                      if (model.isPrepaidCategoryListEmpty == false) {
                                        model.payPrePaidBill(context);
                                      } else if (model.isPrepaidCategoryListEmpty == true) {
                                        model.validatePrePaidBill();
                                      }
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    if (details.primaryVelocity!.isNegative) {
                                      if (model.isPrepaidCategoryListEmpty == false) {
                                        model.payPrePaidBill(context);
                                      } else if (model.isPrepaidCategoryListEmpty == true) {
                                        model.validatePrePaidBill();
                                      }
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: AppStreamBuilder<bool>(
                                    stream: model.showButtonStream,
                                    initialData: false,
                                    dataBuilder: (context, isValid) {
                                      return Visibility(
                                        visible: isValid!,
                                        child: AnimatedButton(
                                          buttonText: S.of(context).swipeToProceed,
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  S.of(context).backToPayments,
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 14.0.t,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.brightBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  ///enter amount appTextField
  _enterAmountAppTextField(HowMuchLikeToPayPrePaidBillsPageViewModel model, BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.only(top: 16.0.h),
        child: AppTextField(
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
          labelText: S.of(context).amount.toUpperCase(),
          inputType: TextInputType.numberWithOptions(decimal: true),
          controller: model.amtController,
          readOnly: !model.isPrepaidCategoryListEmpty,
          hintText: S.of(context).pleaseEnter,
          onPressed: () {},
          onChanged: (val) {
            if (val != null && val.isNotEmpty) {
              model.validate(val);
            }
          },
        ));
  }
}

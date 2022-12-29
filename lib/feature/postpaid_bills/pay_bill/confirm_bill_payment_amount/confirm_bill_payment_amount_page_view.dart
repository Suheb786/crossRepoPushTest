import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_details_bill_paymemts_model.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill_conent.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/get_bill_payments_categories.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'confirm_bill_payment_amount_page_view_model.dart';

class ConfirmBillPaymentAmountPageView extends BasePageViewWidget<ConfirmBillPaymentAmountPageViewModel> {
  ConfirmBillPaymentAmountPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return AppStreamBuilder<Resource<PostPaidBillInquiry>>(
              stream: model.postPaidBillEnquiryStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                } else if (data.status == Status.SUCCESS) {
                  model.postPaidBillInquiryData = data.data?.content?.postPaidBillInquiryData;
                  model.isPartial = model.postPaidBillInquiryData?[0].isPartial ?? false;

                  model.amtController.text = model.addAllBillAmt();
                  model.addNewBillDetailsData.amount = model.amtController.text;
                  model.validate(model.amtController.text);
                }
              },
              dataBuilder: (BuildContext context, data) {
                return AppStreamBuilder<Resource<PayPostPaidBill>>(
                  stream: model.payPostPaidStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      if (AppConstantsUtils.NICK_NAME.toString().trim().isNotEmpty) {
                        AppConstantsUtils.IS_NEW_BILL_ADD_API_CALL = true;
                      }
                      Navigator.pushNamed(context, RoutePaths.PaidBillsSuccessPage,
                          arguments: PaidBillsSuccessPageArguments(
                            data.data?.content?.billerList?[0].totalAmount ?? "0.0",
                            data.data?.content?.billerList?[0].billerName ?? "",
                            AppConstantsUtils.NICK_NAME,
                            data.data?.content?.billerList?[0].refNo ?? "",
                            data.data?.content?.billerList?[0].isPaid ?? false,
                          ));
                    }
                  },
                  dataBuilder: (BuildContext context, data) {
                    return AppStreamBuilder<Resource<PayPrePaid>>(
                      initialData: Resource.none(),
                      stream: model.payPrePaidStream,
                      onData: (value) {
                        if (value.status == Status.SUCCESS) {
                          if (AppConstantsUtils.NICK_NAME.toString().trim().isNotEmpty) {
                            AppConstantsUtils.IS_NEW_BILL_ADD_API_CALL = true;
                          }
                          Navigator.pushNamed(context, RoutePaths.PrePaidBillsSuccessPage,
                              arguments:
                                  PrePaidBillsSuccessPageArguments(value.data!.content ?? PaidBillContent()));
                        }
                      },
                      dataBuilder: (context, snapshot) {
                        return AppStreamBuilder<Resource<ValidatePrePaidBill>>(
                          initialData: Resource.none(),
                          stream: model.validatePrePaidStream,
                          onData: (value) {
                            if (value.status == Status.SUCCESS) {
                              model.amtController.text =
                                  double.parse(value.data?.content?.dueAmount ?? "0").toStringAsFixed(3);
                              model.validate(model.amtController.text);
                              model.otpCode = value.data?.content?.validationCode ?? "";
                              model.isNewBiller = value.data?.content?.validationCode == "" ? false : true;
                              if (AppConstantsUtils.PRE_PAID_FLOW == true) {
                                if (model.addNewBillDetailsData.isPrepaidCategoryListEmpty == true) {
                                  if (model.isAmountMoreThanZero == true) {
                                    model.payPrePaidBill();
                                  } else {
                                    model.showToastWithError(AppError(
                                        cause: Exception(),
                                        error: ErrorInfo(message: ''),
                                        type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                                  }
                                } else {
                                  model.validate(model.amtController.text);
                                }
                              }
                            }
                          },
                          dataBuilder: (context, snapshot) {
                            return AppStreamBuilder<AddNewDetailsBillPaymentsModel>(
                              stream: model.getPurposeResponseStream,
                              initialData: AddNewDetailsBillPaymentsModel(),
                              onData: (data) {
                                model.addNewBillDetailsData = data;

                                /// prepaid case where there is no denomination and amount is filled from amtcontroller form details screen
                                if (model.addNewBillDetailsData.amount != null &&
                                    model.addNewBillDetailsData.amount!.isNotEmpty) {
                                  model.amtController.text =
                                      double.parse(model.addNewBillDetailsData.amount!).toStringAsFixed(3);
                                  model.validate(model.amtController.text);
                                }
                              },
                              dataBuilder: (context, snapshot) {
                                return AppStreamBuilder<bool>(
                                    stream: model.showButtonStream,
                                    initialData: false,
                                    dataBuilder: (context, isValid) {
                                      return ShakeAnimatedWidget(
                                          enabled: isError ?? false,
                                          duration: Duration(milliseconds: 100),
                                          shakeAngle: Rotation.deg(z: 1),
                                          curve: Curves.easeInOutSine,
                                          child: GestureDetector(
                                            onHorizontalDragEnd: (details) {
                                              if (ProviderScope.containerOf(context)
                                                      .read(payBillPageViewModelProvider)
                                                      .appSwiperController
                                                      .page ==
                                                  1.0) {
                                                FocusScope.of(context).unfocus();
                                                if (StringUtils.isDirectionRTL(context)) {
                                                  if (details.primaryVelocity!.isNegative) {
                                                    ProviderScope.containerOf(context)
                                                        .read(payBillPageViewModelProvider)
                                                        .previousPage();
                                                  } else {
                                                    if (AppConstantsUtils.POST_PAID_FLOW) {
                                                      if (isValid == true) {
                                                        model.payPostPaidBill();
                                                      } else {
                                                        model.showToastWithError(AppError(
                                                            cause: Exception(),
                                                            error: ErrorInfo(message: ''),
                                                            type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                                                      }
                                                    } else if (AppConstantsUtils.PRE_PAID_FLOW) {
                                                      if (model.addNewBillDetailsData
                                                              .isPrepaidCategoryListEmpty ==
                                                          false) {
                                                        if (isValid == true) {
                                                          model.payPrePaidBill();
                                                        } else {
                                                          model.showToastWithError(AppError(
                                                              cause: Exception(),
                                                              error: ErrorInfo(message: ''),
                                                              type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                                                        }
                                                      } else if (model.addNewBillDetailsData
                                                              .isPrepaidCategoryListEmpty ==
                                                          true) {
                                                        model.validatePrePaidBill();
                                                      }
                                                    }
                                                  }
                                                } else {
                                                  if (details.primaryVelocity!.isNegative) {
                                                    if (AppConstantsUtils.POST_PAID_FLOW) {
                                                      if (isValid == true) {
                                                        model.payPostPaidBill();
                                                      } else {
                                                        model.showToastWithError(AppError(
                                                            cause: Exception(),
                                                            error: ErrorInfo(message: ''),
                                                            type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                                                      }
                                                    } else if (AppConstantsUtils.PRE_PAID_FLOW) {
                                                      if (model.addNewBillDetailsData
                                                              .isPrepaidCategoryListEmpty ==
                                                          false) {
                                                        if (isValid == true) {
                                                          model.payPrePaidBill();
                                                        } else {
                                                          model.showToastWithError(AppError(
                                                              cause: Exception(),
                                                              error: ErrorInfo(message: ''),
                                                              type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                                                        }
                                                      } else if (model.addNewBillDetailsData
                                                              .isPrepaidCategoryListEmpty ==
                                                          true) {
                                                        model.validatePrePaidBill();
                                                      }
                                                    }
                                                  } else {
                                                    ProviderScope.containerOf(context)
                                                        .read(payBillPageViewModelProvider)
                                                        .previousPage();
                                                  }
                                                }
                                              }
                                            },
                                            child: _cardWidget(model, context),
                                          ));
                                    });
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          }),
    );
  }

  _cardWidget(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _confirmDetailsWidget(model, context),
              // SizedBox(height: 107.h),
              Spacer(),
              _swipeAndBackWidgets(model, context),
            ],
          )),
    );
  }

  _confirmDetailsWidget(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          // padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, top: 24.0.h),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.white_gray), borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            children: [
              _amountTitle(model, context),
              _totalAmountWidget(model, context),
              _tapToEditWidget(model, context),
              _dueAmountPostPaidWidget(model, context),
              // _feeAmountWidget(model, context),
              SizedBox(
                height: 24.0.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.white_gray,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
                  child: Row(
                    children: [
                      _iconWidget(model, context),
                      SizedBox(width: 16.w),
                      _billDetailsWidget(model, context),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  _amountTitle(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.0.w, end: 16.0.w, top: 24.0.h),
      child: Text(
        S.of(context).amount,
        style: TextStyle(
          fontFamily: StringUtils.appFont,
          color: AppColor.veryDarkGray2,
          fontSize: 10.0.t,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _totalAmountWidget(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeTextField(
          wrapWords: false,
          fullwidth: false,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          readOnly: model.isPartial == false,
          controller: model.amtController,
          textAlign: TextAlign.center,
          onChanged: (value) {
            model.validate(value);
          },
          onSubmitted: (value) {
            model.amtController.text = double.parse(value).toStringAsFixed(3);
            model.validate(value);
          },
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.black,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
              fontSize: 24.0.t),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 4.0.w),
          child: Text(
            S.of(context).JOD,
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.verLightGray4,
              fontSize: 14.0.t,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  _tapToEditWidget(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return !AppConstantsUtils.PRE_PAID_FLOW && model.isPartial == true
        ? Text(
            S.of(context).tapAmtToEdit,
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.gray1,
              fontSize: 10.0.t,
              fontWeight: FontWeight.w600,
            ),
          )
        : Container();
  }

  _dueAmountPostPaidWidget(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 16.0.h,
        start: 16.0.w,
        end: 16.0.w,
      ),
      child: AppConstantsUtils.PRE_PAID_FLOW == false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).dueAmt,
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontSize: 12.0.t,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '${model.addNewBillDetailsData.amount} ${S.of(context).JOD}',
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontSize: 12.0.t,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            )
          : Container(),
    );
  }

  _feeAmountWidget(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
/*
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 8.0.h,
        left: 16.0.w,
        right: 16.0.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).fees,
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.black,
              fontSize: 12.0.t,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '20.000 JOD',
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.black,
              fontSize: 12.0.t,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
*/
  }

  _iconWidget(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.vividYellow,
      ),
      child: Image.asset(
        GetBillPaymentsCategories.path(
            ProviderScope.containerOf(context).read(newBillsPageViewModelProvider).titleIcon),
        matchTextDirection: false,
        width: 24.w,
        height: 24.h,
      ),
    );
  }

  _billDetailsWidget(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.addNewBillDetailsData.nickName ?? "",
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.veryDarkGray2,
              fontSize: 12.0.t,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            model.addNewBillDetailsData.billerName ?? '',
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.very_dark_gray_black,
              fontSize: 12.0.t,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            model.addNewBillDetailsData.service ?? "",
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.veryDarkGray2,
              fontSize: 12.0.t,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            model.addNewBillDetailsData.refNo ?? "",
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: AppColor.veryDarkGray2,
              fontSize: 12.0.t,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  _swipeAndBackWidgets(ConfirmBillPaymentAmountPageViewModel model, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AppStreamBuilder<bool>(
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
          SizedBox(
            height: 23.h,
          ),
          InkWell(
            onTap: () {
              ProviderScope.containerOf(context).read(payBillPageViewModelProvider).previousPage();
            },
            child: Text(
              S.of(context).backToPayments,
              style: TextStyle(
                fontFamily: StringUtils.appFont,
                color: AppColor.brightBlue,
                fontSize: 14.t,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

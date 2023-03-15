import 'dart:ui';

import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model_data.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/pay_bill/pay_bill_multiple_list_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PayAllPostPaidBillsPageView extends BasePageViewWidget<PayAllPostPaidBillsPageViewModel> {
  PayAllPostPaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return AppStreamBuilder<Resource<bool>>(
        initialData: Resource.none(),
        stream: model.removeCustomerBillingStream,
        onData: (data) {
          if (data.status == Status.ERROR) {
            model.showErrorState();
            model.showToastWithError(data.appError!);
          } else if (data.status == Status.SUCCESS) {
            model.showSuccessToast(S.of(context).yourBillHasBeenRemoved);
            Future.delayed(Duration(milliseconds: 200)).then((value) => model.getPostpaidBiller());
          }
        },
        dataBuilder: (context, snapshot) {
          return AppStreamBuilder<Resource<List<GetPostpaidBillerListModelData>?>>(
              initialData: Resource.none(),
              stream: model.searchPostpaidBillerStream,
              // onData: (data) {
              //   model.payPostPaidBillsDataList = data.data ?? [];
              // },
              dataBuilder: (context, snapshot) {
                return AppStreamBuilder<List<GetPostpaidBillerListModelData>>(
                  stream: model.itemSelectedStream,
                  initialData: model.payPostPaidBillsDataList,
                  onData: (data) {
                    model.payPostPaidBillsDataList = data;
                  },
                  dataBuilder: (BuildContext context, data) {
                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity!.isNegative) {
                          Navigator.pop(context);
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                            child: Padding(
                                padding: EdgeInsetsDirectional.only(top: 8.0.h, bottom: 56.h),
                                child: Column(
                                  children: [
                                    Container(
                                        width: 64.0.w,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                            color: AppColor.whiteGrey,
                                            borderRadius: BorderRadius.all(Radius.circular(4.0)))),
                                    SizedBox(height: 24.0.h),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        end: 24.0.w,
                                        start: 24.0.w,
                                      ),
                                      child: Visibility(
                                        visible: model.payPostPaidBillsDataList != null &&
                                            model.payPostPaidBillsDataList.isNotEmpty,
                                        child: AppTextField(
                                          labelText: '',
                                          hintText: S.of(context).searchBill,
                                          controller: model.searchBillController,
                                          readOnly: false,
                                          onPressed: () {},
                                          onChanged: (val) {
                                            model.searchPostPaidBillerList(val);
                                          },
                                          suffixIcon: (value, data) {
                                            return Container(
                                                height: 16.h,
                                                width: 16.w,
                                                padding: EdgeInsetsDirectional.only(end: 8.w),
                                                child: AppSvg.asset(AssetUtils.search,
                                                    color: AppColor.dark_gray_1));
                                          },
                                        ),
                                      ),
                                    ),
                                    model.arguments.paidBillsPayTypeOptionEnum ==
                                                PostPaidBillsPayTypeOptionEnum.PAYALLBILLS ||
                                            model.payPostPaidBillsDataList != null &&
                                                model.payPostPaidBillsDataList.length <= 0
                                        ? Container()
                                        : Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 50.0, end: 50.0, top: 16.0, bottom: 16.0),
                                            child: Container(
                                              padding:
                                                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
                                              decoration: BoxDecoration(
                                                  color: AppColor.lightGray,
                                                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  AppSvg.asset(AssetUtils.bulbIcon,
                                                      height: 16.h, width: 16.w),
                                                  SizedBox(width: 8.w),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(top: 4.0.h),
                                                    child: Text(
                                                      S.of(context).swipeAnyBillerToTheLeftToRemove,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          color: AppColor.very_dark_gray1,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12.0.t),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    model.arguments.paidBillsPayTypeOptionEnum ==
                                            PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                                        ? Container()
                                        : AppDivider(),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: model.arguments.paidBillsPayTypeOptionEnum ==
                                                    PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                                                ? 24.0.h
                                                : 8.0.h,
                                            bottom: 24.0.h),
                                        child: model.payPostPaidBillsDataList.length > 0
                                            ? ListView.separated(
                                                shrinkWrap: true,
                                                itemCount: model.payPostPaidBillsDataList.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      if (isDisabledConditions(context, model, index)) {
                                                        showErrorMethod(context, model, index);
                                                      }
                                                      model.selectedItem(index);
                                                    },
                                                    child: model.arguments.paidBillsPayTypeOptionEnum ==
                                                            PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                                                        ? PayBillsMultipleListSelectionWidget(
                                                            icon: model.payPostPaidBillsDataList[index]
                                                                    .iconCode ??
                                                                "",
                                                            isPartial: model.payPostPaidBillsDataList[index]
                                                                    .isPartial ??
                                                                false,
                                                            isDisabled:
                                                                isDisabledConditions(context, model, index),
                                                            maxValue: double.parse(model
                                                                        .payPostPaidBillsDataList[index]
                                                                        .maxValue ??
                                                                    "0")
                                                                .toStringAsFixed(3),
                                                            biller: StringUtils.isDirectionRTL(context)
                                                                ? model.payPostPaidBillsDataList[index]
                                                                        .billerNameAR ??
                                                                    ""
                                                                : model.payPostPaidBillsDataList[index]
                                                                        .billerNameEN ??
                                                                    "",
                                                            billAmtDue: double.parse(model
                                                                        .payPostPaidBillsDataList[index]
                                                                        .actualdueAmountFromApi ??
                                                                    "0")
                                                                .toStringAsFixed(3),
                                                            fees: double.parse(model
                                                                        .payPostPaidBillsDataList[index]
                                                                        .fees ??
                                                                    "0")
                                                                .toStringAsFixed(3),
                                                            isSelected: model.payPostPaidBillsDataList[index]
                                                                    .isChecked ??
                                                                false,
                                                            nickName: model.payPostPaidBillsDataList[index]
                                                                    .nickName ??
                                                                "",
                                                            paidBillsPayTypeOptionEnum:
                                                                model.arguments.paidBillsPayTypeOptionEnum,
                                                          )
                                                        : Slidable(
                                                            endActionPane: ActionPane(
                                                              extentRatio: 0.25,
                                                              motion: DrawerMotion(),
                                                              children: [
                                                                SlidableAction(
                                                                  // An action can be bigger than the others.
                                                                  onPressed: (context1) => {
                                                                    InformationDialog.show(context,
                                                                        image: AssetUtils.deleteBlackIcon,
                                                                        isSwipeToCancel: true,
                                                                        title: S.of(context).areYouSure,
                                                                        descriptionWidget: Text(
                                                                          "${S.of(context).doYouReallyWantToDelete} ${StringUtils.isDirectionRTL(context) ? model.payPostPaidBillsDataList[index].billerNameAR : model.payPostPaidBillsDataList[index].billerNameEN} ${S.of(context).fromSavedBills}",
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontSize: 14.t,
                                                                              fontWeight: FontWeight.w400),
                                                                        ), onDismissed: () {
                                                                      Navigator.pop(context);
                                                                    }, onSelected: () {
                                                                      Navigator.pop(context);
                                                                      var billerCode = model
                                                                          .payPostPaidBillsDataList[index]
                                                                          .billerCode;
                                                                      var billingNo = model
                                                                          .payPostPaidBillsDataList[index]
                                                                          .billingNo;
                                                                      var serviceType = model
                                                                          .payPostPaidBillsDataList[index]
                                                                          .serviceType;
                                                                      model.removeCustomerBilling(
                                                                          billerCode, billingNo, serviceType);
                                                                    })
                                                                  },
                                                                  backgroundColor: AppColor.dark_brown,
                                                                  foregroundColor: Colors.white,
                                                                  icon: Icons.delete,
                                                                ),
                                                              ],
                                                            ),
                                                            child: PayBillsMultipleListSelectionWidget(
                                                              icon: model.payPostPaidBillsDataList[index]
                                                                      .iconCode ??
                                                                  "",
                                                              isPartial: model.payPostPaidBillsDataList[index]
                                                                      .isPartial ??
                                                                  false,
                                                              isDisabled:
                                                                  isDisabledConditions(context, model, index),
                                                              maxValue: double.parse(model
                                                                          .payPostPaidBillsDataList[index]
                                                                          .maxValue ??
                                                                      "0")
                                                                  .toStringAsFixed(3),
                                                              biller: StringUtils.isDirectionRTL(context)
                                                                  ? model.payPostPaidBillsDataList[index]
                                                                          .billerNameAR ??
                                                                      ""
                                                                  : model.payPostPaidBillsDataList[index]
                                                                          .billerNameEN ??
                                                                      "",
                                                              billAmtDue: double.parse(model
                                                                          .payPostPaidBillsDataList[index]
                                                                          .actualdueAmountFromApi ??
                                                                      "0")
                                                                  .toStringAsFixed(3),
                                                              fees: double.parse(model
                                                                          .payPostPaidBillsDataList[index]
                                                                          .fees ??
                                                                      "0")
                                                                  .toStringAsFixed(3),
                                                              isSelected: model
                                                                      .payPostPaidBillsDataList[index]
                                                                      .isChecked ??
                                                                  false,
                                                              nickName: model.payPostPaidBillsDataList[index]
                                                                      .nickName ??
                                                                  "",
                                                              paidBillsPayTypeOptionEnum:
                                                                  model.arguments.paidBillsPayTypeOptionEnum,
                                                            ),
                                                          ),
                                                  );
                                                },
                                                separatorBuilder: (context, index) {
                                                  return AppDivider();
                                                },
                                              )
                                            : Center(
                                                child: Text(
                                                  S.of(context).noDataFound,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Theme.of(context).primaryColorDark),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Visibility(
                            visible: true,
                            child: AppStreamBuilder<double>(
                              initialData: 0.0,
                              stream: model.totalBillAmtDueStream,
                              dataBuilder: (BuildContext context, amt) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        bottom: 36.0.h, start: 24.0.w, end: 24.0.w),
                                    child: InkWell(
                                      onTap: () {
                                        if (model.payPostPaidBillsDataList == null ||
                                            model.payPostPaidBillsDataList.isEmpty) return;

                                        bool isAnyChecked = false;
                                        for (var item1 in model.payPostPaidBillsDataList) {
                                          if (item1.isChecked == true) {
                                            isAnyChecked = true;
                                            break;
                                          }
                                        }
                                        if (isAnyChecked == false) return;

                                        bool isAnyBillPartial = false;
                                        for (var item1 in model.postPaidBillInquiryData ?? []) {
                                          if (item1.isPartial == true) {
                                            isAnyBillPartial = true;
                                            break;
                                          }
                                        }

                                        if (amt! > 0.0 || amt <= 0.0 && isAnyBillPartial == true) {
                                          List<PostPaidBillInquiryData> temPostPaidBillInquiryData = [];
                                          List<GetPostpaidBillerListModelData> tempSelectedPostPaidBillsList =
                                              [];

                                          for (var payPostPaidBillsDataListItem
                                              in model.payPostPaidBillsDataList) {
                                            if (double.parse(
                                                        payPostPaidBillsDataListItem.actualdueAmountFromApi ??
                                                            "0") >
                                                    0.0 ||
                                                double.parse(payPostPaidBillsDataListItem
                                                                .actualdueAmountFromApi ??
                                                            "0") ==
                                                        0.0 &&
                                                    payPostPaidBillsDataListItem.isPartial == true &&
                                                    double.parse(
                                                            payPostPaidBillsDataListItem.maxValue ?? "0") >
                                                        0.0 ||
                                                payPostPaidBillsDataListItem.expDateStatus == true) {
                                              payPostPaidBillsDataListItem.dueAmount =
                                                  payPostPaidBillsDataListItem.actualdueAmountFromApi;
                                              if (payPostPaidBillsDataListItem.billingNo != null &&
                                                  payPostPaidBillsDataListItem.billingNo!.isNotEmpty &&
                                                  payPostPaidBillsDataListItem.serviceType != null &&
                                                  payPostPaidBillsDataListItem.serviceType!.isNotEmpty &&
                                                  payPostPaidBillsDataListItem.isChecked == true) {
                                                tempSelectedPostPaidBillsList
                                                    .add(payPostPaidBillsDataListItem);
                                              }
                                            }

                                            for (var item in model.postPaidBillInquiryData!) {
                                              var dueAmt = double.parse(item.dueAmount ?? "0");

                                              if (item.billingNo == payPostPaidBillsDataListItem.billingNo &&
                                                  item.serviceType ==
                                                      payPostPaidBillsDataListItem.serviceType &&
                                                  payPostPaidBillsDataListItem.isAmountUpdatedFromApi ==
                                                      true) {
                                                dueAmt = double.parse(
                                                    payPostPaidBillsDataListItem.actualdueAmountFromApi ??
                                                        "0");
                                              }

                                              if (dueAmt > 0.0 ||
                                                  dueAmt == 0.0 &&
                                                      item.isPartial == true &&
                                                      double.parse(item.maxValue ?? "0") > 0.0 ||
                                                  item.success == true) {
                                                ///resetting dueAmount back to actual api dueAmount
                                                item.dueAmount = dueAmt.toStringAsFixed(3);
                                                item.actualDueAmountFromApi = dueAmt.toStringAsFixed(3);
                                                item.minMaxValidationMessage = "";

                                                if (item.billingNo != null &&
                                                    item.billingNo!.isNotEmpty &&
                                                    item.serviceType != null &&
                                                    item.serviceType!.isNotEmpty) {
                                                  if (payPostPaidBillsDataListItem.billingNo ==
                                                          item.billingNo &&
                                                      payPostPaidBillsDataListItem.serviceType ==
                                                          item.serviceType &&
                                                      payPostPaidBillsDataListItem.isChecked == true) {
                                                    temPostPaidBillInquiryData.add(item);
                                                  }
                                                }
                                              }
                                            }
                                          }

                                          for (var item in model.payPostPaidBillsDataList) {
                                            if (item.isChecked == false) {
                                              temPostPaidBillInquiryData.removeWhere((element) =>
                                                  element.billingNo == item.billingNo &&
                                                  element.serviceType == item.serviceType);
                                              tempSelectedPostPaidBillsList.removeWhere((element) =>
                                                  element.billingNo == item.billingNo &&
                                                  element.serviceType == item.serviceType);
                                            }

                                            if (item.expDateStatus == false) {
                                              temPostPaidBillInquiryData.removeWhere((element) =>
                                                  element.billingNo == item.billingNo &&
                                                  element.serviceType == item.serviceType);
                                              tempSelectedPostPaidBillsList.removeWhere((element) =>
                                                  element.billingNo == item.billingNo &&
                                                  element.serviceType == item.serviceType);
                                            }
                                            if (item.isChecked == null || item.isChecked == false) {
                                              temPostPaidBillInquiryData.remove(item);
                                              tempSelectedPostPaidBillsList.remove(item);
                                            }
                                          }
                                          tempSelectedPostPaidBillsList =
                                              tempSelectedPostPaidBillsList.toSet().toList();
                                          temPostPaidBillInquiryData =
                                              temPostPaidBillInquiryData.toSet().toList();

                                          if (temPostPaidBillInquiryData != null &&
                                              temPostPaidBillInquiryData.isNotEmpty &&
                                              tempSelectedPostPaidBillsList != null &&
                                              temPostPaidBillInquiryData.isNotEmpty) {
                                            Navigator.pushNamed(
                                                context, RoutePaths.PaySelectedBillsPostPaidBillsPage,
                                                arguments: PaySelectedBillsPostPaidBillsPageArguments(
                                                    model.postPaidBillInquiryData!.length.toString(),
                                                    amt,
                                                    tempSelectedPostPaidBillsList,
                                                    // model.postPaidRequestListJson,
                                                    temPostPaidBillInquiryData));
                                          } else {
                                            model.showToastWithError(AppError(
                                                cause: Exception(),
                                                error: ErrorInfo(message: ""),
                                                type: ErrorType.SELECT_AT_LEAST_ONE_BILL));
                                          }
                                        } else {
                                          model.showToastWithError(AppError(
                                              cause: Exception(),
                                              error: ErrorInfo(message: ""),
                                              type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                                        }
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        height: 56.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.0),
                                          color: model.payPostPaidBillsDataList == null ||
                                                  model.payPostPaidBillsDataList.isEmpty
                                              ? AppColor.very_dark_gray1.withOpacity(0.5)
                                              : model.payPostPaidBillsDataList
                                                      .any((item) => item.isChecked == true)
                                                  ? Theme.of(context).accentTextTheme.bodyText1!.color!
                                                  : AppColor.very_dark_gray1.withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: Text(
                                              S.of(context).pay +
                                                  " " +
                                                  "${amt == null || amt.toString().isEmpty ? double.parse("0").toStringAsFixed(3) : amt.toStringAsFixed(3)}" +
                                                  " " +
                                                  S.of(context).JOD,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14.t,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                  color: AppColor.white)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              });
        });
  }

  showSuccessMsg(context, String title, String message) {
    showTopSnackBar(
        context,
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: EdgeInsetsDirectional.all(16),
              decoration: BoxDecoration(
                  color: AppColor.darkModerateLimeGreen, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 4.0, end: 16),
                          child: Text(message,
                              style: TextStyle(
                                  color: AppColor.white, fontWeight: FontWeight.w600, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1000),
        hideOutAnimationDuration: Duration(milliseconds: 200),
        showOutAnimationDuration: Duration(milliseconds: 500));
  }

  isDisabledConditions(BuildContext context, PayAllPostPaidBillsPageViewModel model, int index) {
    return (double.parse(model.payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0") <= 0.0 &&
            model.payPostPaidBillsDataList[index].isPartial == false) ||
        (double.parse(model.payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0") <= 0.0 &&
            model.payPostPaidBillsDataList[index].isPartial == true &&
            double.parse(model.payPostPaidBillsDataList[index].maxValue ?? "0") <= 0.0) ||
        (model.payPostPaidBillsDataList[index].expDateStatus == false);
  }

  void showErrorMethod(BuildContext context, PayAllPostPaidBillsPageViewModel model, int index) {
    if (model.payPostPaidBillsDataList[index].expDateStatus == false) {
      if (model.payPostPaidBillsDataList != null &&
          model.payPostPaidBillsDataList[index] != null &&
          model.payPostPaidBillsDataList[index].expDateMessage != null &&
          model.payPostPaidBillsDataList[index].expDateMessage!.toString().isNotEmpty) {
        if (model.payPostPaidBillsDataList[index].expDateMessage == "err-379") {
          model.showToastWithError(AppError(
              cause: Exception(),
              error: ErrorInfo(message: ''),
              type: ErrorType.EXPIRY_DATE_SAVED_BILL_CHECK_MESSAGE));
        } else if (model.payPostPaidBillsDataList[index].expDateMessage == "err-381") {
          model.showToastWithError(AppError(
              cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.OPEN_DATE_ISSUE_MESSAGE));
        } else if (model.payPostPaidBillsDataList[index].expDateMessage == "err-383") {
          model.showToastWithError(AppError(
              cause: Exception(),
              error: ErrorInfo(message: ''),
              type: ErrorType.CLOSE_DATE_SAVED_BILL_CHECK_MESSAGE));
        } else {
          if (double.parse(model.payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0") <= 0.0) {
            model.showToastWithError(
                AppError(error: ErrorInfo(message: ''), type: ErrorType.NETWORK, cause: Exception()));
          }
        }
      }
    } else if (model.payPostPaidBillsDataList[index].expDateStatus == true) {
      if (double.parse(model.payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0") <= 0.0) {
        if (model.payPostPaidBillsDataList[index].isPartial == false) {
          model.showToastWithError(AppError(
              cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.THERE_ARE_NO_DUE_BILLS));
        } else {
          model.showToastWithError(AppError(
              cause: Exception(),
              error: ErrorInfo(message: ''),
              type: ErrorType.THERE_ARE_NO_DUE_BILLS_BUT_CAN_MAKE_PARTIAL_PAYMENTS));
        }
      }
    }
  }
}

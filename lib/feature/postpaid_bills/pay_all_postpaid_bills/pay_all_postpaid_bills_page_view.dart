import 'dart:ui';

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
              onData: (data) {
                model.payPostPaidBillsDataList = data.data ?? [];
              },
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
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(top: 24.0.h, bottom: 24.0.h),
                                        child: model.payPostPaidBillsDataList.length > 0
                                            ? ListView.separated(
                                                shrinkWrap: true,
                                                itemCount: model.payPostPaidBillsDataList.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      model.selectedItem(index);
                                                    },
                                                    child: Slidable(
                                                      endActionPane: ActionPane(
                                                        extentRatio: 0.25,
                                                        motion: DrawerMotion(),
                                                        children: [
                                                          SlidableAction(
                                                            // An action can be bigger than the others.
                                                            onPressed: (context1) => {
                                                              InformationDialog.show(context,
                                                                  image: AssetUtils.deleteBlackIcon,
                                                                  isSwipeToCancel: false,
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
                                                        icon:
                                                            model.payPostPaidBillsDataList[index].iconCode ??
                                                                "",
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
                                                        isSelected:
                                                            model.payPostPaidBillsDataList[index].isChecked ??
                                                                false,
                                                        nickName:
                                                            model.payPostPaidBillsDataList[index].nickName ??
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
                            visible: model.payPostPaidBillsDataList.any((item) => item.isChecked == true),
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
                                        if (amt! > 0.0) {
                                          List<PostPaidBillInquiryData> temPostPaidBillInquiryData = [];
                                          List<GetPostpaidBillerListModelData> tempSelectedPostPaidBillsList =
                                              [];

                                          for (var payPostPaidBillsDataListItem
                                              in model.payPostPaidBillsDataList) {
                                            for (var item in model.selectedPostPaidBillsList) {
                                              if (double.parse(item.dueAmount ?? "0") > 0.0) {
                                                if (item.billingNo ==
                                                        payPostPaidBillsDataListItem.billingNo &&
                                                    item.serviceType ==
                                                        payPostPaidBillsDataListItem.serviceType &&
                                                    payPostPaidBillsDataListItem.isAmountUpdatedFromApi ==
                                                        true) {
                                                  item.dueAmount =
                                                      payPostPaidBillsDataListItem.actualdueAmountFromApi;
                                                }
                                                tempSelectedPostPaidBillsList.add(item);
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

                                              if (dueAmt >
                                                  0.0 /*|| dueAmt == 0.0 && item.isPartial == true*/) {
                                                temPostPaidBillInquiryData.add(item);
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
                                          }
                                          tempSelectedPostPaidBillsList =
                                              tempSelectedPostPaidBillsList.toSet().toList();
                                          temPostPaidBillInquiryData =
                                              temPostPaidBillInquiryData.toSet().toList();
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
                                              type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                                        }
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        height: 56.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.0),
                                          color: Theme.of(context).accentTextTheme.bodyText1!.color!,
                                        ),
                                        child: Center(
                                          child: Expanded(
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
}

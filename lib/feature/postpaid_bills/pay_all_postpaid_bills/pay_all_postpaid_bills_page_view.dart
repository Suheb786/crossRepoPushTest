import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';
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
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PayAllPostPaidBillsPageView extends BasePageViewWidget<PayAllPostPaidBillsPageViewModel> {
  PayAllPostPaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return AppStreamBuilder<List<PallAllPostPaidBillsData>>(
      stream: model.itemSelectedStream,
      initialData: model.payAllPostPaidBillsDataList,
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
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, top: 8.0.h, bottom: 56.h),
                  child: Column(
                    children: [
                      Container(
                          width: 64.0.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                              color: AppColor.whiteGrey,
                              borderRadius: BorderRadius.all(Radius.circular(4.0)))),
                      SizedBox(
                        height: 24.0.h,
                      ),
                      AppTextField(
                        labelText: '',
                        hintText: S.of(context).searchBill,
                        controller: model.searchBillController,
                        readOnly: true,
                        onPressed: () {},
                        suffixIcon: (value, data) {
                          return Container(
                              height: 16.h,
                              width: 16.w,
                              padding: EdgeInsets.only(right: 8.w),
                              child: AppSvg.asset(AssetUtils.search, color: AppColor.dark_gray_1));
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 24.0.h, bottom: 24.0.h),
                          child: ListView.separated(
                              shrinkWrap: true,
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
                                                image: AssetUtils.alert,
                                                isSwipeToCancel: false,
                                                title: S.of(context).areYouSure,
                                                descriptionWidget: Text(
                                                  S.of(context).doYouReallyDeleteSavedBills,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14.t,
                                                      fontWeight: FontWeight.w400),
                                                ), onDismissed: () {
                                              Navigator.pop(context);
                                            }, onSelected: () {
                                              Navigator.pop(context);
                                              model.removeItem(index);

                                              model.showSuccessToast(
                                                  'BILL UPDATED\nYour bill has been removed.');
                                            })
                                          },
                                          backgroundColor: AppColor.dark_brown,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                        ),
                                      ],
                                    ),
                                    child: PayBillsMultipleListSelectionWidget(
                                      icon: data![index].icon,
                                      billType: data[index].billType,
                                      billAmtDue: data[index].billAmtDue.toString(),
                                      isSelected: data[index].isSelected,
                                      billName: data[index].billName,
                                      paidBillsPayTypeOptionEnum: model.arguments.paidBillsPayTypeOptionEnum,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return AppDivider();
                              },
                              itemCount: model.payAllPostPaidBillsDataList.length),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: data!.any((item) => item.isSelected == true),
                child: AppStreamBuilder<double>(
                  initialData: model.totalBillAmt,
                  stream: model.totalBillAmtDueStream,
                  dataBuilder: (BuildContext context, amt) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 36.0.h, left: 24.0.w, right: 24.0.w),
                        child: InkWell(
                          onTap: () {
                            // model.showSuccessToast(success)
                            var noOfSelectedBills = data.where((c) => c.isSelected == true).toList();
                            Navigator.pushNamed(context, RoutePaths.PaySelectedBillsPostPaidBillsPage,
                                arguments: PaySelectedBillsPostPaidBillsPageArguments(
                                    noOfSelectedBills.length.toString(), amt!, noOfSelectedBills));
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: 56.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Theme.of(context).accentTextTheme.bodyText1!.color!,
                            ),
                            child: Center(
                              child: Text(S.of(context).pay + amt.toString(),
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

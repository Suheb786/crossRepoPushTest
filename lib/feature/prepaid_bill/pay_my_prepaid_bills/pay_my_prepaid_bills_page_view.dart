import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/prepaid_bill/how_much_like__to_pay_prepaid_bills/how_much_like_to_pay_prepaid_bills_page.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/prepaid/pay_my_prepaid_bills/pay_my_prepaid_bill_list_item_widget.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PayMyPrePaidBillsPageView extends BasePageViewWidget<PayMyPrePaidBillsPageViewModel> {
  PayMyPrePaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PayMyPrePaidBillsPageViewModel model) {
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
            child: Padding(
              padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, top: 8.0.h, bottom: 56.h),
              child: Column(
                children: [
                  Container(
                      width: 64.0.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                          color: AppColor.whiteGrey, borderRadius: BorderRadius.all(Radius.circular(4.0)))),
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
                        itemCount: model.payMyPrePaidBillsPageDataList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              model.selectedPrePaidBillsPageDataList = [
                                model.payMyPrePaidBillsPageDataList[index],
                              ];
                              Navigator.pushNamed(context, RoutePaths.HowMuchLikeToPayPrePaidBillsPage,
                                  arguments: HowMuchLikeToPayPrePaidBillsPageArgument(
                                      model.selectedPrePaidBillsPageDataList));

                              // Navigator.pushNamed(context, RoutePaths.PayingPrePaidBillsPage,
                              //     arguments:
                              //         PayingPrePaidBillsPageArgument(model.selectedPrePaidBillsPageDataList));
                            },
                            child: PayMyPrepPaidBillListItemWidget(
                              billName: model.payMyPrePaidBillsPageDataList[index].billName,
                              billType: model.payMyPrePaidBillsPageDataList[index].billType,
                              icon: model.payMyPrePaidBillsPageDataList[index].icon,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return AppDivider();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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

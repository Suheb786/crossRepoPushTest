import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/change_card_pin_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/view_postpaid_bills/view_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/pay_bill/pay_bill_multiple_list_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ViewPostPaidBillsPageView extends BasePageViewWidget<ViewPostPaidBillsPageViewModel> {
  ViewPostPaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ViewPostPaidBillsPageViewModel model) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: Padding(
            padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0, bottom: 56),
            child: Column(
              children: [
                Container(
                    width: 64.0,
                    height: 4,
                    decoration: BoxDecoration(
                        color: AppColor.whiteGrey, borderRadius: BorderRadius.all(Radius.circular(4.0)))),
                SizedBox(
                  height: 24.0,
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
                AppStreamBuilder<List<ViewPostPaidBillsPageData>>(
                  stream: model.itemSelectedStream,
                  initialData: model.viewPostPaidBillsPageDataList,
                  dataBuilder: (BuildContext context, data) {
                    return MultipleListSelectionWidget(data: data!, model: model);
                  },
                ),
              ],
            ),
          ),
        ),
        AppStreamBuilder<List<ViewPostPaidBillsPageData>>(
          stream: model.itemSelectedStream,
          initialData: model.viewPostPaidBillsPageDataList,
          dataBuilder: (BuildContext context, data) {
            return Visibility(
              visible: data!.any((item) => item.isSelected == true),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 36.0, left: 24.0, right: 24.0),
                  child: Container(
                    width: double.maxFinite,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Theme.of(context).accentTextTheme.bodyText1!.color!,
                    ),
                    child: Center(
                      child: Text(S.of(context).pay + model.calculateTotalDueAmt.toString(),
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
      ],
    );
  }
}

import 'dart:ui';

import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories.dart';
import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/card/postpaid_setting_title_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'new_bills_page_view_model.dart';

class NewBillsPageView extends BasePageViewWidget<NewBillsPageViewModel> {
  NewBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, NewBillsPageViewModel model) {
    return SafeArea(
      child: Container(
        /// get respective ui of selected tab
        child: AppStreamBuilder<Resource<List<GetBillCategoriesList>>>(
            stream: model.searchCategoryListStream,
            initialData: Resource.none(),
            dataBuilder: (context, snapshot) {
              return Padding(
                padding: EdgeInsetsDirectional.only(top: 0.h),
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity!.isNegative) {
                      Navigator.pop(context);
                    }
                  },
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 48.w),
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: AppColor.black,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                          ),
                          Positioned(
                              bottom: -8,
                              child: LottieBuilder.asset(
                                AssetUtils.swipeDownAnimation,
                                width: 28.0.w,
                                height: 28.0.h,
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 8.h),
                        child: Text(
                          S.of(context).backToPayments,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.t,
                              color: AppColor.dark_gray_1),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        S.of(context).newBill,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.t,
                            color: AppColor.gray_black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 26.0.h, bottom: 32.h, left: 24.w, right: 24.w),
                        child: AppTextField(
                          labelText: '',
                          hintText: S.of(context).searchBill,
                          controller: model.searchBillController,
                          onChanged: (value) {
                            model.searchBillerCategory(value);
                          },
                          onPressed: () {},
                          suffixIcon: (value, data) {
                            return Container(
                                height: 16.h,
                                width: 16.w,
                                padding: EdgeInsets.only(right: 8.w),
                                child: AppSvg.asset(AssetUtils.search,
                                    color: AppColor.dark_gray_1));
                          },
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    model.billerCategory =
                                        snapshot!.data![index].categoryName ??
                                            "";
                                    model.titleIcon =
                                        snapshot.data![index].iconCode ?? "";
                                    return PostPaidSettingTitleWidget(
                                      tileIcon: model.titleIcon.toString(),
                                      title: model.billerCategory,
                                      onTap: () {
                                        AppConstantsUtils.BILLER_CATEGORY = snapshot.data![index].categoryName ?? "";
                                        AppConstantsUtils.BILLER_CATEGORY_API_VALUE =
                                        AppConstantsUtils.LANGUAGE_KEY.toString().toLowerCase() == "ar"
                                            ?  snapshot.data![index].categoryName ?? ""
                                            :  snapshot.data![index].categoryNameAr ?? "";
                                        Navigator.pushNamed(
                                            context, RoutePaths.PayBillPage);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return AppDivider();
                                  },
                                  itemCount: snapshot!.data!.length),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
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
import 'package:neo_bank/utils/string_utils.dart';

import '../../../di/payment/payment_modules.dart';
import 'new_bills_page_view_model.dart';

class NewBillsPageView extends BasePageViewWidget<NewBillsPageViewModel> {
  NewBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, NewBillsPageViewModel model) {
    return Container(
      /// get respective ui of selected tab
      child: AppStreamBuilder<Resource<List<GetBillCategoriesList>>>(
          stream: model.searchCategoryListStream,
          initialData: Resource.none(),
          dataBuilder: (context, snapshot) {
            return Column(children: [
              model.showBackButton
                  ? Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
              SizedBox(
                height: !model.showBackButton ? ((MediaQuery.of(context).size.height * 0.14) + 16.h) : 0,
              ),
              Text(
                AppConstantsUtils.PRE_PAID_FLOW
                    ? S.of(context).newPrePaidBill
                    : S.of(context).newPostPaidBill,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.t,
                    color: AppColor.gray_black),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 24.0.h, bottom: 32.h, start: 24.w, end: 24.w),
                child: AppTextField(
                  labelText: '',
                  hintText: S.of(context).searchCategory,
                  controller: model.searchBillController,
                  onChanged: (value) {
                    model.searchBillerCategory(value);
                  },
                  onPressed: () {},
                  suffixIcon: (value, data) {
                    return Container(
                        height: 16.h,
                        width: 16.w,
                        padding: EdgeInsetsDirectional.only(end: 8.w),
                        child: AppSvg.asset(AssetUtils.search, color: AppColor.dark_gray_1));
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: snapshot != null && snapshot.data != null && snapshot.data!.length > 0
                          ? SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return PostPaidSettingTitleWidget(
                                      tileIcon: snapshot.data?[index].iconCode ?? "",
                                      title: !StringUtils.isDirectionRTL(context)
                                          ? snapshot.data![index].categoryName ?? ""
                                          : snapshot.data![index].categoryNameAr ?? "",
                                      onTap: () {
                                        model.billerCategory = snapshot.data?[index].categoryName ?? "";
                                        model.titleIcon = snapshot.data?[index].iconCode ?? "";
                                        AppConstantsUtils.BILLER_CATEGORY =
                                            snapshot.data?[index].categoryName ?? "";
                                        AppConstantsUtils.BILLER_CATEGORY_ARABIC =
                                            snapshot.data?[index].categoryNameAr ?? "";
                                        if (AppConstantsUtils.PRE_PAID_FLOW == true) {
                                          AppConstantsUtils.billerDetailsCacheListKey =
                                              '${AppConstantsUtils.BILLER_CATEGORY}${AppConstantsUtils.PREPAID_KEY}';
                                        } else {
                                          AppConstantsUtils.billerDetailsCacheListKey =
                                              '${AppConstantsUtils.BILLER_CATEGORY}${AppConstantsUtils.POSTPAID_KEY}';
                                        }
                                        AppConstantsUtils.BILLER_CATEGORY_API_VALUE =
                                            !StringUtils.isDirectionRTL(context)
                                                ? snapshot.data![index].categoryName ?? ""
                                                : snapshot.data![index].categoryNameAr ?? "";

                                        Navigator.pushNamed(context, RoutePaths.PayBillPage).then((value) {
                                          if (value != null && value is bool && value) {
                                            ProviderScope.containerOf(context)
                                                .read(paymentHomeViewModelProvider)
                                                .animatePage(AnimatedPage.NULL);
                                          }
                                        });
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return AppDivider();
                                  },
                                  itemCount: snapshot.data!.length),
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
                  ],
                ),
              )
            ]);
          }),
    );
  }
}

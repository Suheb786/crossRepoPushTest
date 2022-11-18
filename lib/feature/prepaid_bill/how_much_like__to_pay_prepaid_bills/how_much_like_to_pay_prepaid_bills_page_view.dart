import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'how_much_like_to_pay_prepaid_bills_page_view_model.dart';

class HowMuchLikeToPayPrePaidBillsPageView
    extends BasePageViewWidget<HowMuchLikeToPayPrePaidBillsPageViewModel> {
  HowMuchLikeToPayPrePaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, HowMuchLikeToPayPrePaidBillsPageViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, top: 96.h, bottom: 56.h),
        child: Column(
          children: [
            Text(
              S.of(context).payBill.toUpperCase(),
              style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 10.0.t,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
            Text(
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
                                    padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
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
                                      model.argument.payMyPrePaidBillsPageDataList[index].billType,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0.t),
                                    ),
                                    Text(
                                      model.argument.payMyPrePaidBillsPageDataList[index].billName,
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
                      SizedBox(
                        height: 32.h,
                      ),
                      Align(
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
                      SizedBox(
                        height: 16.h,
                      ),
                      AppTextField(
                        labelText: S.of(context).amount.toUpperCase(),
                        hintText: '',
                        controller: model.amtController,
                        readOnly: false,
                        inputType: TextInputType.number,
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppTextField(
                        labelText: S.of(context).payFrom.toUpperCase(),
                        hintText: S.of(context).savingAccount(''),
                        controller: model.savingAccountController,
                        readOnly: true,
                        onPressed: () {},
                        suffixIcon: (value, data) {
                          return Container(
                              height: 16.h,
                              width: 16.w,
                              padding: EdgeInsets.only(right: 8.w),
                              child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                        },
                      ),
                      SizedBox(
                        height: 110.h,
                      ),
                      GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            Navigator.pushNamed(context, RoutePaths.PrePaidBillsSuccessPage,
                                arguments: PrePaidBillsSuccessPageArguments('50.000',
                                    'Orange Mobile and Net Every..', 'Prepaid Tariq', '123142141213'));
                          }
                        },
                        child: AnimatedButton(
                          buttonText: S.of(context).swipeToProceed,
                        ),
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
  }
}

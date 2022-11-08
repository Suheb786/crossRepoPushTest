import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/change_card_pin_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PayAllPostPaidBillsPageView extends BasePageViewWidget<PayAllPostPaidBillsPageViewModel> {
  PayAllPostPaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 96.0.h, bottom: 56.0.h, start: 24.w, end: 24.w),
      child: Column(
        children: [
          Text(
            S.of(context).payBills,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                color: AppColor.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.0.t),
          ),
          SizedBox(
            height: 3.h,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: '370.000',
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: AppColor.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 28.0.t),
            ),
            TextSpan(
              text: S.of(context).JOD,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: AppColor.gray5,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0.t),
            ),
          ])),
          SizedBox(
            height: 43.h,
          ),
          Expanded(
            child: Card(
              child: FadingEdgeScrollView.fromSingleChildScrollView(
                child: SingleChildScrollView(
                  controller: model.payingBillController,
                  child: Column(
                    children: [
                      ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.all(24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.black,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional.all(16.0),
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0.t),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Electric Home ',
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0.t),
                                            ),
                                            Text(
                                              'Electric Home',
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.veryDarkGray2,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0.t),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AutoSizeTextField(
                                                wrapWords: false,
                                                fullwidth: false,
                                                controller: model.amtController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                    isDense: true, contentPadding: const EdgeInsets.all(0.0)),
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: AppColor.brightBlue,
                                                    fontWeight: FontWeight.w700,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 14.0.t),
                                              ),
                                            ),
                                            Text(
                                              S.of(context).JOD,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.brightBlue,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0.t),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          S.of(context).tapToEditAmt,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.gray5,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0.t),
                                        ),

                                        /*   Text.rich(TextSpan(children: [
                                          TextSpan(
                                            text: '65.300',
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.brightBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.0.t),
                                          ),

                                        ]))*/
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return AppDivider();
                          },
                          itemCount: 16),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24, top: 32, bottom: 16),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            S.of(context).selectAccount,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.veryDarkGray2,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0.t),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: AppTextField(
                          labelText: S.of(context).payFrom.toUpperCase(),
                          hintText: S.of(context).pleaseSelect,
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
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            Navigator.pushNamed(context, RoutePaths.ViewPostPaidBillsPage);
                            //FirebaseCrashlytics.instance.crash();
                          }
                        },
                        child: AnimatedButton(
                          buttonText: S.of(context).swipeToProceed,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        S.of(context).backToPayments,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.brightBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0.t),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

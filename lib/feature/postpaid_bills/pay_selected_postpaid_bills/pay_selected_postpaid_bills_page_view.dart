import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/pay_selected_postpaid_bills/selected_bills_to_paid_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaySelectedBillsPostPaidBillsPageView
    extends BasePageViewWidget<PaySelectedBillsPostPaidBillsPageViewModel> {
  PaySelectedBillsPostPaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PaySelectedBillsPostPaidBillsPageViewModel model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 96.0.h, bottom: 56.0.h, start: 24.w, end: 24.w),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
            Navigator.pop(context);
          }
        },
        child: Column(
          children: [
            Text(
              S.of(context).payBills('${model.arguments.nosOfBills}'),
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: AppColor.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0.t),
            ),
            SizedBox(
              height: 3.h,
            ),
            AppStreamBuilder<double>(
              initialData: model.arguments.amt,
              stream: model.totalBillAmtDueStream,
              dataBuilder: (BuildContext context, data) {
                return RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: data.toString(),
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
                ]));
              },
            ),
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
                              return SelectedBillsToPaidWidget(
                                billName: model.arguments.noOfSelectedBills[index].billName,
                                billType: model.arguments.noOfSelectedBills[index].billType,
                                itemCount: (index + 1).toString(),
                                onChanged: (value) {
                                  model.newAmtEnter(index, double.parse(value));
                                },
                                billAmtDue: model.arguments.noOfSelectedBills[index].billAmtDue.toString(),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return AppDivider();
                            },
                            itemCount: model.arguments.noOfSelectedBills.length),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 24.w, top: 32.h, bottom: 16.h),
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
                          padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w),
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
                          height: 40.h,
                        ),
                        AppStreamBuilder<double>(
                          initialData: model.arguments.amt,
                          stream: model.totalBillAmtDueStream,
                          dataBuilder: (BuildContext context, data) {
                            return GestureDetector(
                              onHorizontalDragEnd: (details) {
                                if (details.primaryVelocity!.isNegative) {
                                  Navigator.pushNamed(context, RoutePaths.PostPaidBillsSuccessPage,
                                      arguments: PostPaidBillsSuccessPageArguments(
                                        model.arguments.noOfSelectedBills,
                                        data.toString(),
                                      ));
                                }
                              },
                              child: AnimatedButton(
                                buttonText: S.of(context).swipeToProceed,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 24.h,
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
                          height: 32.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/pay_selected_postpaid_bills/selected_bills_to_paid_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaySelectedBillsPostPaidBillsPageView
    extends BasePageViewWidget<PaySelectedBillsPostPaidBillsPageViewModel> {
  PaySelectedBillsPostPaidBillsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PaySelectedBillsPostPaidBillsPageViewModel model) {
    return AppStreamBuilder<List<PostPaidBillInquiryData>>(
      stream: model.postPaidBillEnquiryListStream,
      initialData: model.postPaidBillInquiryData!,
      onData: (data) {
        model.postPaidBillInquiryData = data;
        model.addAllBillAmt(context);
        model.initialValidation(context: context);
      },
      dataBuilder: (BuildContext context, data) {
        return AppStreamBuilder<Resource<PayPostPaidBill>>(
          stream: model.payPostPaidStream,
          initialData: Resource.none(),
          onData: (data) {
            model.addAllBillAmt(context);
            if (data.status == Status.SUCCESS) {
              Future.delayed(Duration(milliseconds: 200)).then((value) {
                Navigator.pushNamed(context, RoutePaths.PostPaidBillsSuccessPage,
                    arguments: PostPaidBillsSuccessPageArguments(
                        model.billerSuccessDetailsList, model.totalBillAmtSuccess));
              });
            }
          },
          dataBuilder: (BuildContext context, data) {
            return Padding(
              padding: EdgeInsetsDirectional.only(top: 96.0.h, bottom: 56.0.h, start: 24.w, end: 24.w),
              child: AppStreamBuilder<bool>(
                  stream: model.showButtonStream,
                  initialData: false,
                  dataBuilder: (context, isValid) {
                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (StringUtils.isDirectionRTL(context)) {
                          if (!details.primaryVelocity!.isNegative) {
                            if (isValid == true) {
                              // model.addAllBillAmt(context);
                              model.payPostPaidBill(context);
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        } else {
                          if (details.primaryVelocity!.isNegative) {
                            if (isValid == true) {
                              // model.addAllBillAmt(context);
                              model.payPostPaidBill(context);
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Column(
                        children: [
                          Text(
                            S.of(context).payBills('${model.postPaidBillInquiryData?.length ?? 0}'),
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
                            onData: (amount) {
                              // model.totalAmount = amount.toString();
                              model.totalBillAmtSuccess = amount;
                              model.totalBillAmt = amount;
                              model.validate();
                            },
                            dataBuilder: (BuildContext context, data) {
                              return RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: data != null ? data.toStringAsFixed(3) : "0.0",
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28.0.t),
                                ),
                                TextSpan(
                                  text: ' ${S.of(context).JOD}',
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
                              child: model.postPaidBillInquiryData == null ||
                                      model.postPaidBillInquiryData!.isEmpty
                                  ? Center(
                                      child: Text(
                                        S.of(context).noDataFound,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).primaryColorDark),
                                      ),
                                    )
                                  : GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onPanDown: (_) {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                      },
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
                                                    model.arguments.noOfSelectedBills[index].dueAmount = model
                                                            .arguments
                                                            .postPaidBillInquiryData?[index]
                                                            .dueAmount ??
                                                        "0";
                                                    return SelectedBillsToPaidWidget(
                                                      minMaxValidationMessage: model
                                                              .postPaidBillInquiryData?[index]
                                                              .minMaxValidationMessage ??
                                                          "",
                                                      minRange: double.parse(model
                                                                  .postPaidBillInquiryData?[index].minValue ??
                                                              "0")
                                                          .toStringAsFixed(3),
                                                      maxRange: double.parse(model
                                                                  .postPaidBillInquiryData?[index].maxValue ??
                                                              "0")
                                                          .toStringAsFixed(3),
                                                      allowPartialPay:
                                                          model.postPaidBillInquiryData?[index].isPartial ??
                                                              false,
                                                      billName: model.getValidBillerNickName(
                                                        model.arguments.postPaidBillInquiryData?[index]
                                                            .billingNo,
                                                        model.arguments.postPaidBillInquiryData?[index]
                                                            .serviceType,
                                                      ),
                                                      billType: model.getValidBillerNameEN(
                                                          model.arguments.postPaidBillInquiryData?[index]
                                                              .billingNo,
                                                          model.arguments.postPaidBillInquiryData?[index]
                                                              .serviceType,
                                                          context),
                                                      itemCount: (index + 1).toString(),
                                                      onFocusChanged: (hasChanged) {
                                                        if (!hasChanged) {
                                                          model.postpaidInquiryDataListener(
                                                              list: model.postPaidBillInquiryData!);
                                                        }
                                                      },
                                                      onChanged: (value) {
                                                        model.onChangedCalled(index, value, context);
                                                      },
                                                      billAmtDue: model.checkAndGetValidBillerDueAmount(
                                                        model.arguments.postPaidBillInquiryData?[index]
                                                            .billingNo,
                                                        model.arguments.postPaidBillInquiryData?[index]
                                                            .serviceType,
                                                      ),
                                                      billAmtFee: double.parse(
                                                              model.postPaidBillInquiryData?[index].feesAmt ??
                                                                  "0")
                                                          .toStringAsFixed(3),
                                                    );
                                                  },
                                                  separatorBuilder: (context, index) {
                                                    return AppDivider();
                                                  },
                                                  itemCount: model.arguments.postPaidBillInquiryData!.length),
                                              Padding(
                                                padding: EdgeInsetsDirectional.only(
                                                    start: 24.w, top: 32.h, bottom: 16.h),
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
                                                padding:
                                                    EdgeInsetsDirectional.only(start: 24.0.w, end: 24.0.w),
                                                child: AppTextField(
                                                  labelText: S.of(context).payFrom.toUpperCase(),
                                                  hintText: S.of(context).pleaseSelect,
                                                  controller: model.savingAccountController,
                                                  readOnly: true,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 40.h,
                                              ),
                                              AppStreamBuilder<bool>(
                                                  stream: model.showButtonStream,
                                                  initialData: false,
                                                  dataBuilder: (context, isValid) {
                                                    return Visibility(
                                                      visible: isValid!,
                                                      child: AnimatedButton(
                                                        buttonText: S.of(context).swipeToProceed,
                                                      ),
                                                    );
                                                  }),
                                              SizedBox(
                                                height: 24.h,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  S.of(context).backToPayments,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: AppColor.brightBlue,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.0.t),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 32.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          },
        );
      },
    );
  }
}

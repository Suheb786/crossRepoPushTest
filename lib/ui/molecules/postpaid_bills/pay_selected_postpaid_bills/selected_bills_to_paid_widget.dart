import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/pay_selected_postpaid_bills/selected_bills_to_paid_widget_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SelectedBillsToPaidWidget extends StatelessWidget {
  final String? itemCount;
  final String? billType;
  final String? billName;
  final String? billAmtDue;
  final String? billAmtFee;
  final String? minRange;
  final String? minMaxValidationMessage;
  final String? maxRange;
  final bool? allowPartialPay;
  final Function(String)? onChanged;
  final Function(bool)? onFocusChanged;

  SelectedBillsToPaidWidget(
      {Key? key,
      required this.itemCount,
      required this.billType,
      required this.billName,
      required this.billAmtDue,
      required this.billAmtFee,
      required this.minRange,
      required this.minMaxValidationMessage,
      required this.maxRange,
      this.allowPartialPay = false,
      this.onChanged,
      this.onFocusChanged})
      : super(key: key);

  ProviderBase provideBase() {
    return SelectedBillsToPaidWidgetViewModelProvider().provide();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SelectedBillsToPaidWidgetViewModel>(
      providerBase: provideBase(),
      onModelReady: (model) {
        model.amtController.text = this.billAmtDue != null && this.billAmtDue!.isNotEmpty
            ? double.parse(this.billAmtDue ?? "0.0").toStringAsFixed(3)
            : "0.0";

        if (double.parse(this.billAmtDue ?? "0.0") <= 0.0) {
          model.amtController.text = "0.0";
        }
      },
      builder: (BuildContext context, model, child) {
        return Padding(
          padding: const EdgeInsetsDirectional.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                              this.itemCount != null && this.itemCount!.isNotEmpty
                                  ? this.itemCount ?? ""
                                  : "",
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                this.billType != null && this.billType!.isNotEmpty ? this.billType ?? "" : "",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0.t),
                              ),
                              Text(
                                this.billName != null && this.billName!.isNotEmpty ? this.billName ?? "" : "",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.veryDarkGray2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0.t),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10.0.w,
                            ),
                            Focus(
                              onFocusChange: (hasFocus) {
                                this.onFocusChanged?.call(hasFocus);
                              },
                              child: AutoSizeTextField(
                                wrapWords: false,
                                fullwidth: false,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
                                ],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: false,
                                ),
                                controller: model!.amtController,
                                textAlign: TextAlign.center,
                                readOnly: this.allowPartialPay == false,
                                onChanged: (value) {
                                  this.onChanged?.call(value);
                                  // if (value.length > 0) {
                                  //   this.onChanged?.call(value);
                                  //   if (value.length > 1 && value[0].toString().contains("0")) {
                                  //     value = value.substring(1, value.length);
                                  //   }
                                  //   model.amtController.text = value;
                                  // } else {
                                  //   this.onChanged?.call("0");
                                  //   model.amtController.text = "0";
                                  // }
                                  model.amtController.selection = TextSelection.fromPosition(
                                      TextPosition(offset: model.amtController.text.length));
                                },
                                decoration:
                                    InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(0.0)),
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
                          this.allowPartialPay == true ? S.of(context).tapToEditAmt : "",
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.brightBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0.t),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              this.allowPartialPay == true
                  ? Container(
                      margin: EdgeInsetsDirectional.only(top: 8.0.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: StringUtils.isDirectionRTL(context) ? 4.0.w : 16.0.w, vertical: 8.0.h),
                      decoration: BoxDecoration(
                          color: AppColor.lightGray, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppSvg.asset(AssetUtils.infoFee, height: 16.h, width: 16.w),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              this.billAmtFee != null &&
                                      this.billAmtFee!.isNotEmpty &&
                                      double.parse(this.billAmtFee ?? "0.0") > 0.0
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.only(top: 4.0.h),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${S.of(context).fees} ",
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.gray5,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0.t),
                                          ),
                                          Text(
                                            this.billAmtFee != null && this.billAmtFee!.isNotEmpty
                                                ? double.parse(this.billAmtFee ?? "0.0").toStringAsFixed(3)
                                                : "0.0",
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.very_dark_gray1,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0.t),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              this.allowPartialPay == true
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.only(top: 4.0.h),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${S.of(context).pay} ${S.of(context).fromSingleLine.toLowerCase()} ",
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.gray5,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0.t),
                                          ),
                                          Text(
                                            "${minRange} ${S.of(context).JOD} ",
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.very_dark_gray1,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0.t),
                                          ),
                                          Text(
                                            "${S.of(context).to.toLowerCase()} ",
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.gray5,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0.t),
                                          ),
                                          Text(
                                            "${maxRange} ${S.of(context).JOD}",
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.very_dark_gray1,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0.t),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              this.allowPartialPay == true
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(top: 4.0),
                      child: Text(
                        minMaxValidationMessage ?? "",
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.soft_red,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0.t),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}

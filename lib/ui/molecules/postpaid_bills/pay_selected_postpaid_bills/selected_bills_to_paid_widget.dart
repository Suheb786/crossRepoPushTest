import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/pay_selected_postpaid_bills/selected_bills_to_paid_widget_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SelectedBillsToPaidWidget extends StatelessWidget {
  final String? itemCount;
  final String? billType;
  final String? billName;
  final String? billAmtDue;
  final bool? allowPartialPay;
  final Function(String)? onChanged;

  SelectedBillsToPaidWidget(
      {Key? key,
      required this.itemCount,
      required this.billType,
      required this.billName,
      required this.billAmtDue,
      this.allowPartialPay: false,
      this.onChanged})
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
      },
      builder: (BuildContext context, model, child) {
        return Padding(
          padding: const EdgeInsetsDirectional.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
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
                          this.itemCount != null && this.itemCount!.isNotEmpty ? this.itemCount ?? "" : "",
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
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10.0.w,
                        ),
                        Expanded(
                          child: AutoSizeTextField(
                            wrapWords: false,
                            fullwidth: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            ],
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            ),
                            controller: model!.amtController,
                            textAlign: TextAlign.center,
                            readOnly: this.allowPartialPay == false,
                            onChanged: (value) {
                              if (value.length > 0) {
                                this.onChanged?.call(value);
                                if (value.length > 1 && value[0].toString().contains("0")) {
                                  value = value.substring(1, value.length);
                                }
                                model.amtController.text = value;
                              } else {
                                this.onChanged?.call("0");
                                model.amtController.text = "0";
                              }
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
                          color: AppColor.gray5,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0.t),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

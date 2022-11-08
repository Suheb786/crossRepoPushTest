import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/pay_selected_postpaid_bills/selected_bills_to_paid_widget_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SelectedBillsToPaidWidget extends StatelessWidget {
  final String itemCount;
  final String billType;
  final String billName;
  final String billAmtDue;

  SelectedBillsToPaidWidget(
      {Key? key,
      required this.itemCount,
      required this.billType,
      required this.billName,
      required this.billAmtDue})
      : super(key: key);
  ProviderBase provideBase() {
    return SelectedBillsToPaidWidgetViewModelProvider().provide();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SelectedBillsToPaidWidgetViewModel>(
      providerBase: provideBase(),
      onModelReady: (model) {
        model.amtController.text = billAmtDue;
      },
      builder: (BuildContext context, model, child) {
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
                          this.itemCount,
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
                          this.billType,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0.t),
                        ),
                        Text(
                          this.billName,
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
                            controller: model!.amtController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
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
    );
  }
}

import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/payment_activity_filter_dialog/payment_activity_filter_dialog.dart';
import 'package:neo_bank/ui/molecules/payment/payment_activity_transacton_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaymentActivityTransactionPageView extends BasePageViewWidget<PaymentActivityTransactionViewModel> {
  PaymentActivityTransactionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 52),
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta!.isNegative) {
            } else {
              Navigator.pop(context);
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.0),
                child: Center(
                  child: Text(
                    S.of(context).paymentActivity,
                    style:
                        TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: 35),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 4,
                              width: 64,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4), color: AppColor.whiteGray),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 24.0, start: 24, end: 38),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColor.whiteGray,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).fromMe,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12,
                                              color: AppColor.gray,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(start: 12),
                                          child: AppSvg.asset(AssetUtils.dropDown),
                                        )
                                      ],
                                    ),
                                  ),
                                  AppStreamBuilder<String>(
                                      stream: model.paymentPeriodResponseStream,
                                      initialData:
                                          StringUtils.isDirectionRTL(context) ? "آخر 30 يوم" : 'Last 30 days',
                                      dataBuilder: (mContext, paymentPeriod) {
                                        return Padding(
                                          padding: EdgeInsetsDirectional.only(start: 8),
                                          child: InkWell(
                                            onTap: () {
                                              PaymentActivityFilterDialog.show(context,
                                                  type: FilterType.period, onSelected: (value) {
                                                Navigator.pop(context);
                                                model.updatePaymentPeriod(value);
                                              }, onDismissed: () {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: AppColor.whiteGray,
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    paymentPeriod!,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 12),
                                                    child: AppSvg.asset(AssetUtils.dropDown),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: 28, start: 24, end: 24),
                              child: AppStreamBuilder<Resource<PaymentActivityResponse>>(
                                  stream: model.paymentActivityTransactionResponse,
                                  initialData: Resource.none(),
                                  dataBuilder: (context, transaction) {
                                    return ListView.builder(
                                      itemBuilder: (context, index) {
                                        return transaction!.data!.paymentActivityContent!.length > 0
                                            ? PaymentActivityTransactionWidget(
                                                transactions:
                                                    transaction.data!.paymentActivityContent![index],
                                              )
                                            : Center(child: Text(S.of(context).noTransactionToDisplay));
                                      },
                                      shrinkWrap: true,
                                      itemCount: transaction!.data!.paymentActivityContent!.length,
                                    );
                                  }),
                            ),
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
      ),
    );
  }
}

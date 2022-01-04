import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/model/payment_activity_item.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PaymentActivityTransactionPageView
    extends BasePageViewWidget<PaymentActivityTransactionViewModel> {
  PaymentActivityTransactionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsets.only(top: 52),
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 4,
                              width: 64,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColor.whiteGray),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 24.0, left: 24, right: 38),
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).allTransaction,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 12),
                                          child:
                                              AppSvg.asset(AssetUtils.dropDown),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColor.whiteGray,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            S.of(context).allTime,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: AppSvg.asset(
                                                AssetUtils.dropDown),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 28, left: 24, right: 24),
                              child: AppStreamBuilder<
                                      List<PaymentActivityItem>>(
                                  stream: model.transactionListStream,
                                  initialData: model.transactionList,
                                  dataBuilder: (context, data) {
                                    return GroupedListView<PaymentActivityItem,
                                            String>(
                                        scrollDirection: Axis.vertical,
                                        elements: data!,
                                        order: GroupedListOrder.DESC,
                                        shrinkWrap: true,
                                        primary: false,
                                        padding: EdgeInsets.zero,
                                        floatingHeader: false,
                                        groupBy: (PaymentActivityItem element) {
                                          return element.createdAt!;
                                        },
                                        groupHeaderBuilder: (element) =>
                                            Container(
                                              color:
                                                  Theme.of(context).accentColor,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 16, bottom: 16),
                                                child: Text(
                                                  element.createdAt!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                        itemBuilder: (context, element) {
                                          return Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: Image.asset(
                                                      element.image!,
                                                      fit: BoxFit.fill),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 14),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        element.type == "Send"
                                                            ? "You sent ${element.amount}"
                                                            : "You requested ${element.amount}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        element.type == "Sent"
                                                            ? "to ${element.name}"
                                                            : "from ${element.name}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 12),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              element.time!,
                                                              style: TextStyle(
                                                                  color: AppColor
                                                                      .gray1,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 9),
                                                              child: Text(
                                                                element.status!,
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .canvasColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 44),
                                                  child: Divider(
                                                    thickness: 4,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
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

import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/bill_payments_transaction/bill_payments_transaction_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/filter_transaction_dialog/filter_transaction_dialog.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/bill_payment_transactions_widget.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_list.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transactions.dart';
import 'package:neo_bank/utils/time_utils.dart';

class BillPaymentsTransactionPageView extends BasePageViewWidget<BillPaymentsTransactionViewModel> {
  BillPaymentsTransactionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 52.0.h),
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity!.isNegative) {
            } else {
              Navigator.pop(context);
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).billsHistory,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0.t),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: 35.0.h),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 8.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 4.0.h,
                              width: 64.0.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4), color: AppColor.whiteGray),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 24.0.h, start: 24.0.w, end: 38.0.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppTextField(
                                    labelText: "",
                                    hintText: S.of(context).lookingFor,
                                    controller: model.searchController,
                                    onPressed: () {},
                                    onFieldSubmitted: (text) => model.onSearchTextChanged(text),
                                    suffixIcon: (value, data) {
                                      return Padding(
                                          padding: EdgeInsetsDirectional.only(start: 19.0.w),
                                          child:
                                              AppSvg.asset(AssetUtils.search, height: 16.0.h, width: 16.0.w));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 24.0.w),
                                  child: InkWell(
                                      onTap: () {
                                        FilterTransactionDialog.show(
                                          context,
                                          onDismissed: () => Navigator.pop(context),
                                          onSelected: (value) {
                                            print("value: $value");
                                            Navigator.pop(context);
                                            model.getFilteredData(value);
                                          },
                                        );
                                      },
                                      child: AppSvg.asset(AssetUtils.filter)),
                                )
                              ],
                            ),
                          ),
                          AppStreamBuilder<List<String>>(
                              stream: model.searchTextStream,
                              initialData: [],
                              dataBuilder: (context, textList) {
                                return Visibility(
                                  visible: textList!.length > 0,
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(top: 21.0.h, start: 24.0.w, end: 24.0.w),
                                    child: Container(
                                      height: 40.0.h,
                                      child: ListView.builder(
                                        itemCount: textList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.only(start: index == 0 ? 0 : 9.0.w),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColorDark,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              padding:
                                                  EdgeInsets.symmetric(horizontal: 9.0.w, vertical: 2.0.h),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    textList[index],
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        color: Theme.of(context).accentColor),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 9.0.w),
                                                    child: InkWell(
                                                      onTap: () {
                                                        model.updateSearchList(index);
                                                      },
                                                      child: AppSvg.asset(AssetUtils.close,
                                                          color: Theme.of(context).accentColor),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          AppStreamBuilder<Resource<BillPaymentsTransactionModel>>(
                              stream: model.getTransactionsStream,
                              initialData: Resource.none(),
                              dataBuilder: (context, transaction) {
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.0.w),
                                    child: transaction!.data!.billPaymentsTransactionData!
                                                .billPaymentsTransactionDataList!.length >
                                            0
                                        ? _transactionHistoryList(
                                            context,
                                            transaction.data?.billPaymentsTransactionData
                                                ?.billPaymentsTransactionDataList)
                                        // ? ListView.builder(
                                        //     itemBuilder: (context, index) {
                                        //       return BillPaymentsTransactionWidget(
                                        //         billPaymentsTransactionData:
                                        //             transaction.data!.billPaymentsTransactionData!,
                                        //       );
                                        //     },
                                        //     shrinkWrap: true,
                                        //     itemCount: transaction.data!.billPaymentsTransactionData!
                                        //         .billPaymentsTransactionDataList!.length,
                                        //     physics: AlwaysScrollableScrollPhysics(),
                                        //   )
                                        : Center(
                                            child: Text(S.of(context).noTransactionToDisplay),
                                          ),
                                  ),
                                );
                              }),
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

Widget _transactionHistoryList(BuildContext context, List<BillPaymentsTransactionList>? list) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'", 'en_US');
  DateFormat outputFormat = DateFormat("yyyy-MM-dd", 'en_US');
  DateFormat convertFormat = DateFormat("dd MMMM yyyy", 'en_US');
  List<BillPaymentsTransactionList>? reversedList =
      list != null && list.isNotEmpty ? List.from(list.reversed) : [];
  return reversedList != null && reversedList.isNotEmpty
      ? GroupedListView<BillPaymentsTransactionList, DateTime>(
          scrollDirection: Axis.vertical,
          elements: reversedList,
          shrinkWrap: true,
          order: GroupedListOrder.DESC,
          stickyHeaderBackgroundColor: Colors.transparent,
          floatingHeader: false,
          groupBy: (BillPaymentsTransactionList element) {
            DateTime date = inputFormat.parse(element.paymentDate!);
            return outputFormat.parse(inputFormat.format(date));
          },
          groupHeaderBuilder: (BillPaymentsTransactionList element) => Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: _title(
                    context,
                    convertFormat.format(inputFormat.parse(element.paymentDate!)),
                  ),
                ),
              ),
          itemBuilder: (_, BillPaymentsTransactionList element) {
            return _transactionListWidget(context, element, list);
          })
      : Center(child: Text(S.of(context).noTransactionToDisplay));
}

_transactionListWidget(
    BuildContext context, BillPaymentsTransactionList item, List<BillPaymentsTransactionList>? list) {
  var listLength = list?.length ?? 0;
  int firstIndex = list!.indexOf(list.first);
  int lastIndex = list.indexOf(list.last);
  var isLengthOne = listLength == 1 && firstIndex == 0;
  var isLengthMoreThanOne = listLength > 1 && listLength - 1 == lastIndex;
  return Container(
    padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: firstIndex == 0 ? Radius.circular(15) : Radius.zero,
        topRight: firstIndex == 0 ? Radius.circular(15) : Radius.zero,
        bottomLeft: lastIndex == list.length - 1 ? Radius.circular(15) : Radius.zero,
        bottomRight: lastIndex == list.length - 1 ? Radius.circular(15) : Radius.zero,
      ),
      color: Colors.grey,
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey,
      //     blurRadius: 2.0,
      //     spreadRadius: 0.0,
      //     offset: Offset(2.0, 2.0), // shadow direction: bottom right
      //   )
      // ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.nickname!,
                maxLines: 10,
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 12.0.t,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0.h),
                child: Text(
                  TimeUtils.getFormattedTimeForTransaction(item.paymentDate!.toString()),
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                      fontSize: 12.0.t,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        // SizedBox(
        //   width: 8,
        // ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  double.parse(item.amount ?? "0").toStringAsFixed(3),
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: AppColor.darkModerateLimeGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0.t),
                ),
                Text(
                  " ${S.of(context).JOD}",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.0.t,
                      color: Theme.of(context).inputDecorationTheme.hintStyle!.color),
                ),
              ],
            ),
            SizedBox(
              height: 4.0.h,
            ),
            Text(
              "Pay again",
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: AppColor.brightBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0.t),
            )
          ],
        )
      ],
    ), /*ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 17.0.h),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var item = element;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nickname!,
                    maxLines: 10,
                    style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 12.0.t,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0.h),
                    child: Text(
                      TimeUtils.getFormattedTimeForTransaction(item.paymentDate!.toString()),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                          fontSize: 12.0.t,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(
            //   width: 8,
            // ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      double.parse(item.amount ?? "0").toStringAsFixed(3),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: AppColor.darkModerateLimeGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0.t),
                    ),
                    Text(
                      " ${S.of(context).JOD}",
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0.t,
                          color: Theme.of(context).inputDecorationTheme.hintStyle!.color),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.0.h,
                ),
                Text(
                  "Pay again",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: AppColor.brightBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0.t),
                )
              ],
            )
          ],
        );
      },
      shrinkWrap: true,
      itemCount: */ /*transactions?.length ??*/ /* 0,
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0.h),
          child: Container(
            height: 1,
            color: AppColor.light_grayish_violet,
          ),
        );
      },
    ),*/
  );
}

_title(BuildContext context, String format) {
  return Text(
    format,
    style: TextStyle(
        fontFamily: StringUtils.appFont,
        fontSize: 15.0.t,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).primaryColorDark),
  );
}

class TimeLineHeaderWidget extends StatelessWidget {
  final String? header;

  const TimeLineHeaderWidget({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 16.0.w),
      color: AppColor.soft_red,
      child: Text(
        header!,
        style: TextStyle(
          color: AppColor.dark_gray_1,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

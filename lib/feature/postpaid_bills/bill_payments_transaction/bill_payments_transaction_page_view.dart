import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/bill_payments_transaction/bill_payments_transaction_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/bill_payment_transactions_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../di/payment/payment_modules.dart';
import '../../../ui/no_data_widget.dart';

class BillPaymentsTransactionPageView extends BasePageViewWidget<BillPaymentsTransactionViewModel> {
  BillPaymentsTransactionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 52.0.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0.h) + EdgeInsets.only(bottom: 16.0.h),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).billsHistory,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0.t),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 24.0.h),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 24.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 24.0.h, start: 24.0.w, end: 24.0.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppTextField(
                                      labelText: "",
                                      hintText: S.of(context).lookingFor,
                                      controller: model.searchController,
                                      onPressed: () {},
                                      onFieldSubmitted: (text) {
                                        model.allDataList = [];
                                        model.pageNo = 1;
                                        model.hasMoreData = true;
                                        if (text.trim().isNotEmpty) {
                                          // if ((!model.searchTextList.contains(text.trim().toLowerCase())))
                                          model.onSearchTransaction(searchText: text.trim());
                                        }
                                      },
                                      suffixIcon: (value, data) {
                                        return Padding(
                                            padding: EdgeInsetsDirectional.only(start: 19.0.w),
                                            child: AppSvg.asset(AssetUtils.search,
                                                height: 16.0.h, width: 16.0.w));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppStreamBuilder<List<String>>(
                                stream: model.searchTextStream,
                                initialData: [],
                                onData: (value) {
                                  value = value.toSet().toList();
                                  model.searchText = value.join(',');
                                  if (model.searchText.isNotEmpty && !model.searchText.contains(",")) {
                                    model.searchText = model.searchText + ",";
                                  }
                                  model.getTransactions(pageNo: model.pageNo, pageSize: model.pageSize);
                                },
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
                                                          color: Theme.of(context).colorScheme.secondary),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.only(start: 9.0.w),
                                                      child: InkWell(
                                                        onTap: () {
                                                          model.allDataList = [];
                                                          model.pageNo = 1;
                                                          model.hasMoreData = true;
                                                          model.updateSearchList(index);
                                                        },
                                                        child: AppSvg.asset(AssetUtils.close,
                                                            color: Theme.of(context).colorScheme.secondary),
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
                                      child: transaction != null &&
                                              transaction.data != null &&
                                              transaction.data!.billPaymentsTransactionData!.length > 0
                                          ? SingleChildScrollView(
                                              controller: model.scrollController,
                                              physics: AlwaysScrollableScrollPhysics(),
                                              child: ListView.builder(
                                                itemBuilder: (context, index) {
                                                  return BillPaymentsTransactionWidget(
                                                    billPaymentsTransactionData:
                                                        transaction.data!.billPaymentsTransactionData![index],
                                                  );
                                                },
                                                shrinkWrap: true,
                                                itemCount:
                                                    transaction.data!.billPaymentsTransactionData!.length,
                                                physics: NeverScrollableScrollPhysics(),
                                              ),
                                            )
                                          : Center(
                                              child: NoDataWidget(
                                                errorMessage: S.of(context).noTransactionToDisplay,
                                              ),
                                            ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: InkWell(
                      onTap: () {
                        ProviderScope.containerOf(context)
                            .read(paymentHomeViewModelProvider)
                            .animateBackToMainPage();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 48.h,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  spreadRadius: 0.1,
                                  offset: Offset(0, 4))
                            ]),
                        child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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

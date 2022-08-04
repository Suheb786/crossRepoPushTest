import 'package:domain/constants/enum/statement_type.dart';
import 'package:domain/model/card/get_debit_years_response.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dashboard/transactions_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/download_transaction_dialog/download_transaction_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/filter_transaction_dialog/filter_transaction_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AccountTransactionPageView extends BasePageViewWidget<AccountTransactionViewModel> {
  AccountTransactionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 52),
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
                padding: EdgeInsets.symmetric(horizontal: 48.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).transactionHistory,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    AppStreamBuilder<Resource<GetDebitYearsResponse>>(
                        stream: model.getDebitYearsStream,
                        initialData: Resource.none(),
                        dataBuilder: (context, debitYears) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                if (debitYears!.status == Status.SUCCESS) {
                                  DownloadTransactionDialog.show(context, years: debitYears.data!.years,
                                      onDismissed: () {
                                    Navigator.pop(context);
                                  }, onSelected: (value) {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, RoutePaths.DownloadTransaction,
                                        arguments: DownloadStatementArguments(
                                            statementType: StatementType.Debit, transactionDate: value));
                                  });
                                }
                              },
                              child: AppSvg.asset(AssetUtils.download),
                            ),
                          );
                        })
                  ],
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
                                          padding: EdgeInsetsDirectional.only(start: 19),
                                          child: AppSvg.asset(AssetUtils.search, height: 16, width: 16));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 24),
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
                                    padding: EdgeInsetsDirectional.only(top: 21, start: 24, end: 24),
                                    child: Container(
                                      height: 40,
                                      child: ListView.builder(
                                        itemCount: textList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 9),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColorDark,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    textList[index],
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        color: Theme.of(context).accentColor),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 9),
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
                          AppStreamBuilder<Resource<GetTransactionsResponse>>(
                              stream: model.getTransactionsStream,
                              initialData: Resource.none(),
                              dataBuilder: (context, transaction) {
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: transaction!.data!.transactionResponse!.length > 0
                                        ? ListView.builder(
                                            itemBuilder: (context, index) {
                                              return TransactionWidget(
                                                transactions: transaction.data!.transactionResponse![index],
                                              );
                                            },
                                            shrinkWrap: true,
                                            itemCount: transaction.data!.transactionResponse!.length,
                                            physics: AlwaysScrollableScrollPhysics(),
                                          )
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

class TimeLineHeaderWidget extends StatelessWidget {
  final String? header;

  const TimeLineHeaderWidget({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
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

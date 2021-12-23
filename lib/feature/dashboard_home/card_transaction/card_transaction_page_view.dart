import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_view_model.dart';
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

class CardTransactionPageView
    extends BasePageViewWidget<CardTransactionViewModel> {
  CardTransactionPageView(ProviderBase model) : super(model);

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
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).visaPlatinumCard,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {
                              DownloadTransactionDialog.show(context,
                                  onSelected: (value) {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, RoutePaths.DownloadTransaction,
                                    arguments: ["Card", value]);
                              });
                            },
                            child: AppSvg.asset(AssetUtils.download)))
                  ],
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppTextField(
                                    labelText: "",
                                    hintText: S.of(context).lookingFor,
                                    controller: model.searchController,
                                    onPressed: () {},
                                    onFieldSubmitted: (text) =>
                                        model.onSearchTextChanged(text),
                                    suffixIcon: (value, data) {
                                      return Padding(
                                          padding: EdgeInsets.only(left: 19),
                                          child: AppSvg.asset(AssetUtils.search,
                                              height: 16, width: 16));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 24),
                                  child: InkWell(
                                      onTap: () {
                                        FilterTransactionDialog.show(
                                          context,
                                          onDismissed: () =>
                                              Navigator.pop(context),
                                          onSelected: (value) {
                                            print("value: $value");
                                            Navigator.pop(context);
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
                                    padding: EdgeInsets.only(
                                        top: 21, left: 24, right: 24),
                                    child: Container(
                                      height: 40,
                                      child: ListView.builder(
                                        itemCount: textList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 9, vertical: 2),
                                            child: Row(
                                              children: [
                                                Text(
                                                  textList[index],
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 9),
                                                  child: InkWell(
                                                    onTap: () {
                                                      model.updateSearchList(
                                                          index);
                                                    },
                                                    child: AppSvg.asset(
                                                        AssetUtils.close,
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                  ),
                                                )
                                              ],
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
                                    padding:
                                        EdgeInsets.only(left: 24, right: 24),
                                    child: transaction!.data!
                                                .transactionResponse!.length >
                                            0
                                        ? ListView.builder(
                                            itemBuilder: (context, index) {
                                              return TransactionWidget(
                                                transactions: transaction.data!
                                                        .transactionResponse![
                                                    index],
                                              );
                                            },
                                            shrinkWrap: true,
                                            itemCount: transaction.data!
                                                .transactionResponse!.length,
                                          )
                                        : Center(
                                            child: Text(
                                                'No Transactions to display'),
                                          ),
                                  ),
                                );
                              }),
                          // Padding(
                          //   padding:
                          //       EdgeInsets.only(top: 24, left: 24, right: 24),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         "12 September",
                          //         style: TextStyle(
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.only(top: 16),
                          //         child: Card(
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(16)),
                          //           clipBehavior: Clip.antiAliasWithSaveLayer,
                          //           elevation: 2,
                          //           color: Theme.of(context)
                          //               .cardTheme
                          //               .copyWith(color: AppColor.white)
                          //               .color,
                          //           margin: EdgeInsets.zero,
                          //           shadowColor:
                          //               AppColor.black.withOpacity(0.32),
                          //           child: Container(
                          //             color: Theme.of(context).accentColor,
                          //             child: Column(
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 17, left: 24, right: 24),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai\nAED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(
                          //                                     top: 4),
                          //                             child: Text(
                          //                               "8:32PM",
                          //                               style: TextStyle(
                          //                                   color: Theme.of(
                          //                                           context)
                          //                                       .inputDecorationTheme
                          //                                       .hintStyle!
                          //                                       .color),
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.end,
                          //                         children: [
                          //                           Text(
                          //                             "-102.92",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14),
                          //                           ),
                          //                           Text(
                          //                             "JOD",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14,
                          //                                 color: Theme.of(
                          //                                         context)
                          //                                     .inputDecorationTheme
                          //                                     .hintStyle!
                          //                                     .color),
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 16),
                          //                   child: Divider(),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 17, left: 24, right: 24),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai\nAED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(
                          //                                     top: 4),
                          //                             child: Text(
                          //                               "8:32PM",
                          //                               style: TextStyle(
                          //                                   color: Theme.of(
                          //                                           context)
                          //                                       .inputDecorationTheme
                          //                                       .hintStyle!
                          //                                       .color),
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.end,
                          //                         children: [
                          //                           Text(
                          //                             "-102.92",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14),
                          //                           ),
                          //                           Text(
                          //                             "JOD",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14,
                          //                                 color: Theme.of(
                          //                                         context)
                          //                                     .inputDecorationTheme
                          //                                     .hintStyle!
                          //                                     .color),
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 16),
                          //                   child: Divider(),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 17, left: 24, right: 24),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai\nAED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(
                          //                                     top: 4),
                          //                             child: Text(
                          //                               "8:32PM",
                          //                               style: TextStyle(
                          //                                   color: Theme.of(
                          //                                           context)
                          //                                       .inputDecorationTheme
                          //                                       .hintStyle!
                          //                                       .color),
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.end,
                          //                         children: [
                          //                           Text(
                          //                             "-102.92",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14),
                          //                           ),
                          //                           Text(
                          //                             "JOD",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14,
                          //                                 color: Theme.of(
                          //                                         context)
                          //                                     .inputDecorationTheme
                          //                                     .hintStyle!
                          //                                     .color),
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 16),
                          //                   child: Divider(),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 17,
                          //                       left: 24,
                          //                       right: 24,
                          //                       bottom: 17),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai\nAED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(
                          //                                     top: 4),
                          //                             child: Text(
                          //                               "8:32PM",
                          //                               style: TextStyle(
                          //                                   color: Theme.of(
                          //                                           context)
                          //                                       .inputDecorationTheme
                          //                                       .hintStyle!
                          //                                       .color),
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.end,
                          //                         children: [
                          //                           Text(
                          //                             "-102.92",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14),
                          //                           ),
                          //                           Text(
                          //                             "JOD",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14,
                          //                                 color: Theme.of(
                          //                                         context)
                          //                                     .inputDecorationTheme
                          //                                     .hintStyle!
                          //                                     .color),
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding:
                          //       EdgeInsets.only(top: 24, left: 24, right: 24),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         "11 September",
                          //         style: TextStyle(
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.only(top: 16),
                          //         child: Card(
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(16)),
                          //           clipBehavior: Clip.antiAliasWithSaveLayer,
                          //           elevation: 2,
                          //           color: Theme.of(context)
                          //               .cardTheme
                          //               .copyWith(color: AppColor.white)
                          //               .color,
                          //           margin: EdgeInsets.zero,
                          //           shadowColor:
                          //               AppColor.black.withOpacity(0.32),
                          //           child: Container(
                          //             color: Theme.of(context).accentColor,
                          //             child: Column(
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 17, left: 24, right: 24),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai\nAED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(
                          //                                     top: 4),
                          //                             child: Text(
                          //                               "8:32PM",
                          //                               style: TextStyle(
                          //                                   color: Theme.of(
                          //                                           context)
                          //                                       .inputDecorationTheme
                          //                                       .hintStyle!
                          //                                       .color),
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.end,
                          //                         children: [
                          //                           Text(
                          //                             "-102.92",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14),
                          //                           ),
                          //                           Text(
                          //                             "JOD",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14,
                          //                                 color: Theme.of(
                          //                                         context)
                          //                                     .inputDecorationTheme
                          //                                     .hintStyle!
                          //                                     .color),
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 16),
                          //                   child: Divider(),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 17, left: 24, right: 24),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai\nAED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(
                          //                                     top: 4),
                          //                             child: Text(
                          //                               "8:32PM",
                          //                               style: TextStyle(
                          //                                   color: Theme.of(
                          //                                           context)
                          //                                       .inputDecorationTheme
                          //                                       .hintStyle!
                          //                                       .color),
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.end,
                          //                         children: [
                          //                           Text(
                          //                             "-102.92",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14),
                          //                           ),
                          //                           Text(
                          //                             "JOD",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14,
                          //                                 color: Theme.of(
                          //                                         context)
                          //                                     .inputDecorationTheme
                          //                                     .hintStyle!
                          //                                     .color),
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 16),
                          //                   child: Divider(),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 17, left: 24, right: 24),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai\nAED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(
                          //                                     top: 4),
                          //                             child: Text(
                          //                               "8:32PM",
                          //                               style: TextStyle(
                          //                                   color: Theme.of(
                          //                                           context)
                          //                                       .inputDecorationTheme
                          //                                       .hintStyle!
                          //                                       .color),
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.end,
                          //                         children: [
                          //                           Text(
                          //                             "-102.92",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14),
                          //                           ),
                          //                           Text(
                          //                             "JOD",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14,
                          //                                 color: Theme.of(
                          //                                         context)
                          //                                     .inputDecorationTheme
                          //                                     .hintStyle!
                          //                                     .color),
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 16),
                          //                   child: Divider(),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 17,
                          //                       left: 24,
                          //                       right: 24,
                          //                       bottom: 17),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai\nAED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(
                          //                                     top: 4),
                          //                             child: Text(
                          //                               "8:32PM",
                          //                               style: TextStyle(
                          //                                   color: Theme.of(
                          //                                           context)
                          //                                       .inputDecorationTheme
                          //                                       .hintStyle!
                          //                                       .color),
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.end,
                          //                         children: [
                          //                           Text(
                          //                             "-102.92",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14),
                          //                           ),
                          //                           Text(
                          //                             "JOD",
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 14,
                          //                                 color: Theme.of(
                          //                                         context)
                          //                                     .inputDecorationTheme
                          //                                     .hintStyle!
                          //                                     .color),
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // )
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

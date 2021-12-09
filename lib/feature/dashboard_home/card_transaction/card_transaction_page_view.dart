import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CardTransactionPageView
    extends BasePageViewWidget<CardTransactionViewModel> {
  CardTransactionPageView(ProviderBase model) : super(model);
  List transactionList = [
    "11 September",
    "12 September",
    "12 September",
    "11 September",
    "11 September",
    "12 September",
    "11 September",
    "12 September"
  ];

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsets.only(top: 52),
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta!.isNegative) {
            } else {
              // ProviderScope.containerOf(context)
              //     .read(homeViewModelProvider)
              //     .homeController
              //     .jumpToPage(0);
              Navigator.pop(context);
            }
          },
          child: Column(
            children: [
              Center(
                child: Text(
                  S.of(context).visaPlatinumCard,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Container(
                    padding: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16))),
                    child: SingleChildScrollView(
                      child: Column(
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
                                    readOnly: true,
                                    onPressed: () {},
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
                                  child: AppSvg.asset(AssetUtils.filter),
                                )
                              ],
                            ),
                          ),
                          // Expanded(
                          //   child: Padding(
                          //     padding: EdgeInsets.only(left: 24, right: 24),
                          //     child: GroupedListView<dynamic, String>(
                          //         scrollDirection: Axis.vertical,
                          //         elements: transactionList,
                          //         order: GroupedListOrder.DESC,
                          //         stickyHeaderBackgroundColor:
                          //             Theme.of(context).accentColor,
                          //         floatingHeader: false,
                          //         groupBy: (dynamic element) {
                          //           return element;
                          //         },
                          //         separator: Container(
                          //           height: 30,
                          //           width: double.infinity,
                          //           color: AppColor.vivid_red,
                          //         ),
                          //         groupHeaderBuilder: (dynamic element) =>
                          //             Container(
                          //               child: Padding(
                          //                 padding: EdgeInsets.only(top: 16,bottom: 16),
                          //                 child: Text(
                          //                   element,
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.w600,
                          //                       fontSize: 14),
                          //                 ),
                          //               ),
                          //             ),
                          //         itemBuilder: (_, dynamic element) {
                          //           return Column(
                          //             children: [
                          //               Padding(
                          //                 padding: EdgeInsets.only(
                          //                     top: 17, left: 17, right: 17),
                          //                 child: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Expanded(
                          //                       child: Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.start,
                          //                         children: [
                          //                           Text(
                          //                             "Host International Inc Dubai AED 533.03",
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                               fontSize: 12,
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding:
                          //                                 EdgeInsets.only(top: 4),
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
                          //                     ),
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.end,
                          //                       children: [
                          //                         Text(
                          //                           "-102.92",
                          //                           style: TextStyle(
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                               fontSize: 14),
                          //                         ),
                          //                         Text(
                          //                           "JOD",
                          //                           style: TextStyle(
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                               fontSize: 14,
                          //                               color: Theme.of(context)
                          //                                   .inputDecorationTheme
                          //                                   .hintStyle!
                          //                                   .color),
                          //                         ),
                          //                       ],
                          //                     )
                          //                   ],
                          //                 ),
                          //               )
                          //             ],
                          //           );
                          //         }),
                          //   ),
                          // ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 24, left: 24, right: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "12 September",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 2,
                                    color: Theme.of(context)
                                        .cardTheme
                                        .copyWith(color: AppColor.white)
                                        .color,
                                    margin: EdgeInsets.zero,
                                    shadowColor:
                                        AppColor.black.withOpacity(0.32),
                                    child: Container(
                                      color: Theme.of(context).accentColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17, left: 24, right: 24),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Host International Inc Dubai\nAED 533.03",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "-102.92",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "JOD",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Divider(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17, left: 24, right: 24),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Host International Inc Dubai\nAED 533.03",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "-102.92",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "JOD",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Divider(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17, left: 24, right: 24),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Host International Inc Dubai\nAED 533.03",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "-102.92",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "JOD",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Divider(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17,
                                                left: 24,
                                                right: 24,
                                                bottom: 17),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Host International Inc Dubai\nAED 533.03",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "-102.92",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "JOD",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 24, left: 24, right: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "11 September",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 2,
                                    color: Theme.of(context)
                                        .cardTheme
                                        .copyWith(color: AppColor.white)
                                        .color,
                                    margin: EdgeInsets.zero,
                                    shadowColor:
                                        AppColor.black.withOpacity(0.32),
                                    child: Container(
                                      color: Theme.of(context).accentColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17, left: 24, right: 24),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Host International Inc Dubai\nAED 533.03",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "-102.92",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "JOD",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Divider(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17, left: 24, right: 24),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Host International Inc Dubai\nAED 533.03",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "-102.92",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "JOD",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Divider(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17, left: 24, right: 24),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Host International Inc Dubai\nAED 533.03",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "-102.92",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "JOD",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Divider(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17,
                                                left: 24,
                                                right: 24,
                                                bottom: 17),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Host International Inc Dubai\nAED 533.03",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "-102.92",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "JOD",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
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

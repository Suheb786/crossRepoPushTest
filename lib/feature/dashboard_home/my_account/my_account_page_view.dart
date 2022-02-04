import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:share_plus/share_plus.dart';

class MyAccountPageView extends BasePageViewWidget<MyAccountViewModel> {
  // MyAccountPageView(ProviderBase model) : super(model);
  final GetDashboardDataContent cardData;

  MyAccountPageView(ProviderBase model, this.cardData) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Center(
        child: AspectRatio(
            aspectRatio: 0.62,
            child: Stack(
              children: [
                GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity!.isNegative) {
                      ProviderScope.containerOf(context)
                          .read(appHomeViewModelProvider)
                          .pageController
                          .next();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 2,
                      color: Theme.of(context).primaryColorDark,
                      margin: EdgeInsets.zero,
                      shadowColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.32),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AssetUtils.zigzagRed),
                                alignment: Alignment.topRight)),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(left: 27.0, bottom: 29),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   crossAxisAlignment:
                                //       CrossAxisAlignment.start,
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Expanded(
                                //       child: Padding(
                                //         padding: EdgeInsets.only(top: 30.0),
                                //         child: Column(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               S.of(context).myAccount,
                                //               style: TextStyle(
                                //                   fontWeight: FontWeight.w600,
                                //                   fontSize: 12,
                                //                   color: Theme.of(context)
                                //                       .accentColor),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   EdgeInsets.only(top: 66),
                                //               child: Text(
                                //                 cardData!.account!
                                //                             .accountTitle !=
                                //                         null
                                //                     ? cardData.account!
                                //                         .accountTitle!
                                //                         .toTitleCase()
                                //                     : '',
                                //                 style: TextStyle(
                                //                     fontSize: 16,
                                //                     fontWeight:
                                //                         FontWeight.w600,
                                //                     color: Theme.of(context)
                                //                         .accentColor),
                                //               ),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   EdgeInsets.only(top: 23),
                                //               child: Row(
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.center,
                                //                 mainAxisAlignment:
                                //                     MainAxisAlignment.start,
                                //                 children: [
                                //                   Text(
                                //                       cardData.account!
                                //                           .availableBalance!,
                                //                       style: TextStyle(
                                //                           fontSize: 20,
                                //                           fontWeight:
                                //                               FontWeight.w700,
                                //                           color: Theme.of(
                                //                                   context)
                                //                               .accentColor)),
                                //                   Padding(
                                //                     padding: EdgeInsets.only(
                                //                         top: 5, left: 5.0),
                                //                     child: Text("JOD",
                                //                         style: TextStyle(
                                //                             fontWeight:
                                //                                 FontWeight
                                //                                     .w600,
                                //                             fontSize: 10,
                                //                             color: Theme.of(
                                //                                     context)
                                //                                 .accentColor
                                //                                 .withOpacity(
                                //                                     0.4))),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   EdgeInsets.only(top: 4),
                                //               child: Text(
                                //                 S
                                //                     .of(context)
                                //                     .availableBalance,
                                //                 style: TextStyle(
                                //                     fontWeight:
                                //                         FontWeight.w600,
                                //                     fontSize: 10,
                                //                     color: Theme.of(context)
                                //                         .accentColor
                                //                         .withOpacity(0.4)),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //     Image.asset(AssetUtils.zigzagRed)
                                //   ],
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(top: 30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).myAccount,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 66,
                                        ),
                                        child: Text(
                                          cardData.account!.accountTitle != null
                                              ? cardData.account!.accountTitle!
                                                  .replaceAll(' ', '\n')
                                              : '',
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 23),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                cardData
                                                    .account!.availableBalance!,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context)
                                                        .accentColor)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, left: 5.0),
                                              child: Text("JOD",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10,
                                                      color: Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.4))),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                ProviderScope.containerOf(
                                                        context)
                                                    .read(
                                                        appHomeViewModelProvider)
                                                    .balenceUpdate();
                                              },
                                              child: Container(
                                                  height: 14,
                                                  width: 14,
                                                  child: Image.asset(
                                                      AssetUtils.refresh)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          S.of(context).availableBalance,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.4)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 29),
                                  child: Row(
                                    children: [
                                      Text(
                                        cardData.account!.accountNo ?? '',
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                                  text: cardData
                                                          .account!.accountNo ??
                                                      ''))
                                              .then((value) =>
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Account No. Copied'));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: AppSvg.asset(AssetUtils.copy),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    S.of(context).accountNo,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.4),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, right: 25),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cardData.account!.iban!,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                                  text:
                                                      cardData.account!.iban ??
                                                          ''))
                                              .then((value) =>
                                                  Fluttertoast.showToast(
                                                      msg: 'IBAN Copied'));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: AppSvg.asset(AssetUtils.copy),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6),
                                  child: Text(
                                    S.of(context).iban,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.4),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              RoutePaths
                                                  .AddMoneyOptionSelector);
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 105,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1!
                                                  .color),
                                          child: Center(
                                            child: Text(
                                              S.of(context).addMoney,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _shareFiles(model, context, cardData);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 33.0),
                                          child: AppSvg.asset(AssetUtils.share,
                                              color: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1!
                                                  .color,
                                              height: 24,
                                              width: 24),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: LottieBuilder.asset(
                    'assets/animation/Swipe_Up.json',
                    height: 71.0,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _shareFiles(MyAccountViewModel model, BuildContext context,
      GetDashboardDataContent cardData) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        'Hello! Here are my Blink account details: \n\n${cardData.account!.accountTitle ?? ''} \n${cardData.account!.iban ?? '-'}\n\nOpen your Blink account today.',
        subject: 'Share account info',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

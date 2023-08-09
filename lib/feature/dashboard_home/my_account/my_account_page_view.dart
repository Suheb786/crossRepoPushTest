import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';

class MyAccountPageView extends BasePageViewWidget<MyAccountViewModel> {
  final Account account;

  MyAccountPageView(ProviderBase model, this.account) : super(model);

  @override
  Widget build(BuildContext context, model) {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalSpacing, vertical: 44),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              color: Theme.of(context).primaryColorDark,
              margin: EdgeInsetsDirectional.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: AssetImage(AssetUtils.zigzagRed), alignment: AlignmentDirectional.topEnd, scale: 1, matchTextDirection: true),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).myAccount,
                        style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 12.0.t, color: Theme.of(context).colorScheme.secondary),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: screenHeight * 0.075),
                              Text(
                                account.accountTitle != null ? account.accountTitle!.replaceAll(' ', '\n') : '',
                                maxLines: 3,
                                style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 16.0.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
                              ),
                              SizedBox(height: screenHeight * 0.05),
                              Text.rich(
                                TextSpan(style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700), children: [
                                  TextSpan(text: account.availableBalance!, style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 20.0.t, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.secondary)),
                                  TextSpan(
                                      text: S.of(context).JOD,
                                      style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 10.0.t, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4))),
                                ]),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                S.of(context).availableBalance,
                                style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 10.0.t, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    account.accountNo ?? '',
                                    maxLines: 2,
                                    style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 12.0.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      ProviderScope.containerOf(context).read(appHomeViewModelProvider).balenceUpdate();
                                    },
                                    child: Container(
                                        height: 14.0.h,
                                        width: 14.0.w,
                                        child: Image.asset(
                                          AssetUtils.refresh,
                                          color: AppColor.brightBlue,
                                        )),
                                  ),
                                ],
                              ),
                              Text(
                                S.of(context).accountNo,
                                style: TextStyle(fontFamily: StringUtils.appFont, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4), fontSize: 10.0.t, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      account.iban!,
                                      style: TextStyle(fontFamily: StringUtils.appFont, overflow: TextOverflow.ellipsis, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 12.0.t),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: account.accountNo ?? '')).then((value) => Fluttertoast.showToast(msg: S.of(context).accountNoCopied));
                                    },
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(start: 8.0.w),
                                      child: AppSvg.asset(
                                        AssetUtils.copy,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                S.of(context).iban,
                                style: TextStyle(fontFamily: StringUtils.appFont, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4), fontSize: 10.0.t, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: screenHeight * 0.075),
                            ],
                          ),
                        ),
                      ),
                      Directionality(
                        textDirection: StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, RoutePaths.AddMoneyOptionSelector);
                              },
                              child: Container(
                                height: 40.0.h,
                                width: 105.0.w,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).textTheme.bodyLarge!.color!),
                                child: Center(
                                  child: Text(
                                    S.of(context).addMoney,
                                    style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 12.0.t, color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _shareFiles(model, context, account);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 33.0.w),
                                child: AppSvg.asset(AssetUtils.share, color: Theme.of(context).textTheme.bodyLarge!.color!, height: 24.0.h, width: 24.0.w),
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
          ),
        ],
      ),
    );

    /*return AppKeyBoardHide(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035, vertical: 44),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            color: Theme.of(context).primaryColorDark,
            margin: EdgeInsetsDirectional.zero,
            shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AssetUtils.zigzagRed), alignment: AlignmentDirectional.topEnd, scale: 1, matchTextDirection: true),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                          start: 27.0.w,
                        ) +
                        EdgeInsetsDirectional.symmetric(vertical: 32.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          S.of(context).myAccount,
                          style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 12.0.t, color: Theme.of(context).colorScheme.secondary),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  top: 66.0.h,
                                ),
                                child: Text(
                                  account.accountTitle != null ? account.accountTitle!.replaceAll(' ', '\n') : '',
                                  maxLines: 3,
                                  style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 16.0.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 23.0.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(account.availableBalance!, style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 20.0.t, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.secondary)),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(top: 5.0.h, start: 5.0.w),
                                      child: Text(S.of(context).JOD,
                                          style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 10.0.t, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4))),
                                    ),
                                    SizedBox(width: 10.0.w),
                                    InkWell(
                                      onTap: () {
                                        ProviderScope.containerOf(context).read(appHomeViewModelProvider).balenceUpdate();
                                      },
                                      child: Container(
                                          height: 14.0.h,
                                          width: 14.0.w,
                                          child: Image.asset(
                                            AssetUtils.refresh,
                                            color: AppColor.brightBlue,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 4.0.h),
                                child: Text(
                                  S.of(context).availableBalance,
                                  style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 10.0.t, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 29.0.h),
                                child: Row(
                                  children: [
                                    Text(
                                      account.accountNo ?? '',
                                      maxLines: 2,
                                      style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 12.0.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: account.accountNo ?? '')).then((value) => Fluttertoast.showToast(msg: S.of(context).accountNoCopied));
                                      },
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(start: 8.0.w),
                                        child: AppSvg.asset(
                                          AssetUtils.copy,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 5.0.h),
                                child: Text(
                                  S.of(context).accountNo,
                                  style: TextStyle(fontFamily: StringUtils.appFont, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4), fontSize: 10.0.t, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 20.0.h, end: 25.0.w),
                                child: Row(
                                  children: [
                                    Text(
                                      account.iban!,
                                      style: TextStyle(fontFamily: StringUtils.appFont, overflow: TextOverflow.ellipsis, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 12.0.t),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: account.iban ?? '')).then((value) => Fluttertoast.showToast(msg: S.of(context).ibanCopied));
                                      },
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(start: 8.0.w),
                                        child: AppSvg.asset(AssetUtils.copy),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 6.0.h),
                                child: Text(
                                  S.of(context).iban,
                                  style: TextStyle(fontFamily: StringUtils.appFont, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4), fontSize: 10.0.t, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Directionality(
                          textDirection: StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 15.0.h,
                              start: StringUtils.isDirectionRTL(context) ? 27.0.w : 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, RoutePaths.AddMoneyOptionSelector);
                                  },
                                  child: Container(
                                    height: 40.0.h,
                                    width: 105.0.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).textTheme.bodyLarge!.color!),
                                    child: Center(
                                      child: Text(
                                        S.of(context).addMoney,
                                        style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 12.0.t, color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _shareFiles(model, context, account);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 33.0.w),
                                    child: AppSvg.asset(AssetUtils.share, color: Theme.of(context).textTheme.bodyLarge!.color!, height: 24.0.h, width: 24.0.w),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );*/
  }

  void _shareFiles(MyAccountViewModel model, BuildContext context, Account account) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share('Hello! Here are my Blink account details: \n\n${account.accountTitle ?? ''} \n${account.iban ?? '-'}\n\nOpen your Blink account today.',
        subject: 'Share account info', sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

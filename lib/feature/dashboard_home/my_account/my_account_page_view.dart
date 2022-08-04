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
import 'package:neo_bank/utils/screen_size_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';

class MyAccountPageView extends BasePageViewWidget<MyAccountViewModel> {
  final Account account;

  MyAccountPageView(ProviderBase model, this.account) : super(model);

  @override
  Widget build(BuildContext context, model) {
    bool isSmallDevices = model.deviceSize.height < ScreenSizeBreakPoints.SMALL_DEVICE_HEIGHT ||
        model.deviceSize.height < ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT;
    return AppKeyBoardHide(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                margin: EdgeInsetsDirectional.all(15),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  color: Theme.of(context).primaryColorDark,
                  margin: EdgeInsetsDirectional.zero,
                  shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetUtils.zigzagRed),
                          alignment: AlignmentDirectional.topEnd,
                          scale: isSmallDevices ? 1.3 : 1,
                          matchTextDirection: true),
                    ),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Padding(
                          padding: EdgeInsetsDirectional.only(start: isSmallDevices ? 20 : 27.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: isSmallDevices ? 21 : 30.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).myAccount,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isSmallDevices ? 10 : 12,
                                              color: Theme.of(context).accentColor),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            top: isSmallDevices ? 40 : 66,
                                          ),
                                          child: Text(
                                            account.accountTitle != null
                                                ? account.accountTitle!.replaceAll(' ', '\n')
                                                : '',
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: isSmallDevices ? 10 : 16,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).accentColor),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(top: 23),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(account.availableBalance!,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: isSmallDevices ? 12 : 20,
                                                      fontWeight: FontWeight.w700,
                                                      color: Theme.of(context).accentColor)),
                                              Padding(
                                                padding: EdgeInsetsDirectional.only(top: 5, start: 5.0),
                                                child: Text(S.of(context).JOD,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 10,
                                                        color:
                                                            Theme.of(context).accentColor.withOpacity(0.4))),
                                              ),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  ProviderScope.containerOf(context)
                                                      .read(appHomeViewModelProvider)
                                                      .balenceUpdate();
                                                },
                                                child: Container(
                                                    height: 14,
                                                    width: 14,
                                                    child: Image.asset(
                                                      AssetUtils.refresh,
                                                      color: AppColor.brightBlue,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(top: 4),
                                          child: Text(
                                            S.of(context).availableBalance,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w600,
                                                fontSize: isSmallDevices ? 8 : 10,
                                                color: Theme.of(context).accentColor.withOpacity(0.4)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 29),
                                    child: Row(
                                      children: [
                                        Text(
                                          account.accountNo ?? '',
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: isSmallDevices ? 10 : 12,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).accentColor),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(text: account.accountNo ?? ''))
                                                .then((value) => Fluttertoast.showToast(
                                                    msg: S.of(context).accountNoCopied));
                                          },
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(start: 8),
                                            child: AppSvg.asset(
                                              AssetUtils.copy,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 5),
                                    child: Text(
                                      S.of(context).accountNo,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).accentColor.withOpacity(0.4),
                                          fontSize: isSmallDevices ? 8 : 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 20, end: 25),
                                    child: Row(
                                      children: [
                                        Text(
                                          account.iban!,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              overflow: TextOverflow.ellipsis,
                                              color: Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isSmallDevices ? 9 : 12),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(text: account.iban ?? '')).then(
                                                (value) =>
                                                    Fluttertoast.showToast(msg: S.of(context).ibanCopied));
                                          },
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(start: 8),
                                            child: AppSvg.asset(AssetUtils.copy),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 6),
                                    child: Text(
                                      S.of(context).iban,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).accentColor.withOpacity(0.4),
                                          fontSize: isSmallDevices ? 8 : 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Spacer(),
                                  Directionality(
                                    textDirection: StringUtils.isDirectionRTL(context)
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        top: 15.0,
                                        start: StringUtils.isDirectionRTL(context) ? 27 : 0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context, RoutePaths.AddMoneyOptionSelector);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 105,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Theme.of(context).accentTextTheme.bodyText1!.color),
                                              child: Center(
                                                child: Text(
                                                  S.of(context).addMoney,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: isSmallDevices ? 10 : 12,
                                                      color: Theme.of(context).accentColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _shareFiles(model, context, account);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(right: 33.0),
                                              child: AppSvg.asset(AssetUtils.share,
                                                  color: Theme.of(context).accentTextTheme.bodyText1!.color,
                                                  height: 24,
                                                  width: 24),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: isSmallDevices ? 30 : 50),
                                ],
                              ),
                            ),
                          ));
                    }),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  AppSvg.asset(AssetUtils.swipeUp),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 6),
                    child: Text(
                      S.of(context).swipeUpToViewTransaction,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: isSmallDevices ? 10 : 12,
                          color: AppColor.dark_gray_1),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _shareFiles(MyAccountViewModel model, BuildContext context, Account account) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        'Hello! Here are my Blink account details: \n\n${account.accountTitle ?? ''} \n${account.iban ?? '-'}\n\nOpen your Blink account today.',
        subject: 'Share account info',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_view_model.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class MyAccountPageView extends BasePageViewWidget<MyAccountViewModel> {
  MyAccountPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          ProviderScope.containerOf(context)
              .read(appHomeViewModelProvider)
              .pageController
              .next();
        },
        onVerticalDragEnd: (details) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AccountTransactionPage()));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).primaryColorDark,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Padding(
            padding: EdgeInsets.only(left: 27.0, bottom: 29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Account",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Theme.of(context).accentColor),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 66),
                                child: Text(
                                  "Zein Malhas",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 23),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("0.00",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Theme.of(context).accentColor)),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Text("JOD",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.4))),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  "AVAILABLE BALANCE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.4)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 29),
                                child: Text(
                                  "8451 1353 1245 3421",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "ACCOUNT NO.",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.4),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(AssetUtils.zigzagRed)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "JOD12031531451345134123456731",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        "IBAN",
                        style: TextStyle(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 36,
                      width: 105,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .color),
                      child: Center(
                        child: Text(
                          "Add money",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 33.0),
                      child:
                          AppSvg.asset(AssetUtils.share, height: 24, width: 24),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

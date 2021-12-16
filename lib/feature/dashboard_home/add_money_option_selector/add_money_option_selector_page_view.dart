import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/add_money_option_selector/add_money_option_selector_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/dashboard/add_money_selector_option_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:share_plus/share_plus.dart';

class AddMoneyOptionSelectorPageView
    extends BasePageViewWidget<AddMoneyOptionSelectorViewModel> {
  AddMoneyOptionSelectorPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 62, horizontal: 40),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).waysYocCanAddMoneyToAccount,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 46,
            ),
            AddMoneySelectorOptionsWidget(
              image: AssetUtils.requestMoney,
              title: S.of(context).requestMoneyFromOtherBank,
              desc: S.of(context).requestMoneyFromOtherBankDesc,
              buttonText: S.of(context).requestMoney,
            ),
            SizedBox(
              height: 26,
            ),
            AddMoneySelectorOptionsWidget(
              image: AssetUtils.receiveMoneyOther,
              title: S.of(context).receiveMoneyFromOthers,
              desc: S.of(context).receiveMoneyFromOthersDesc,
              buttonText: S.of(context).shareAccountInfo,
              onTap: () {
                _shareFiles(model, context);
              },
            ),
            SizedBox(
              height: 26,
            ),
            AddMoneySelectorOptionsWidget(
              image: AssetUtils.dollar,
              title: S.of(context).depositViaATM,
              desc: S.of(context).depositViaATMDesc,
              buttonText: S.of(context).locateATM,
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.LocateATM);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Row(
                children: <Widget>[
                  AppDivider(
                    color: Theme.of(context).accentColor.withOpacity(0.3),
                    indent: 0,
                    endIndent: 8,
                  ),
                  Text(
                    S.of(context).or,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                  AppDivider(
                    color: Theme.of(context).accentColor.withOpacity(0.3),
                    endIndent: 0,
                    indent: 8,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 32),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: AssetImage(
                    AssetUtils.swigglePng,
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AssetUtils.blink,
                    height: 28,
                    width: 60,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      height: 36,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .color,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          S.of(context).getMyCreditCard,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).accentColor),
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
    );
  }

  void _shareFiles(
      AddMoneyOptionSelectorViewModel model, BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        'Hello! Here’s my blink account details:\n\nZein Malhas \nJOD120315314513451341234567312\n\nGet your blink account today. Blink now!',
        subject: 'Share account info',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

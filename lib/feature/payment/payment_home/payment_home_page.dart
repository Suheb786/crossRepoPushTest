import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_page_view.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class PaymentHomePage extends BasePage<PaymentHomeViewModel> {
  @override
  PaymentHomePageState createState() => PaymentHomePageState();
}

class PaymentHomePageState
    extends BaseStatefulPage<PaymentHomeViewModel, PaymentHomePage> {
  @override
  ProviderBase provideBase() {
    return paymentHomeViewModelProvider;
  }

  @override
  Widget? buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: ConvexAppBar(
        elevation: 0,
        style: TabStyle.fixedCircle,
        backgroundColor: Theme.of(context).accentColor,
        items: [
          TabItem(icon: AppSvg.asset(AssetUtils.house), title: " "),
          TabItem(
            icon: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  shape: BoxShape.circle),
              child: Center(
                child: AppSvg.asset(AssetUtils.logoWhite),
              ),
            ),
          ),
          TabItem(
              icon: Container(child: AppSvg.asset(AssetUtils.headphoneBlack)),
              title: " "),
        ],
        initialActiveIndex: 1,
        onTap: (i) => print("got index $i"),
      ),
    );
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, PaymentHomeViewModel model) {
    return PaymentHomePageView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_page.dart';
import 'package:neo_bank/feature/dashboard_home/home/home_view_model.dart';

class HomePageView extends BasePageViewWidget<HomeViewModel> {
  HomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: model.homeController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        AppHomePage(),
        AccountTransactionPage(),
        //CardTransactionPage()
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/my_dashboard/get_card/get_card_page_view.dart';
import 'package:neo_bank/feature/my_dashboard/get_card/get_card_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class GetCardPage extends BasePage<GetCardViewModel> {
  @override
  JobAndIncomePageState createState() => JobAndIncomePageState();
}

class JobAndIncomePageState
    extends BaseStatefulPage<GetCardViewModel, GetCardPage> {
  @override
  ProviderBase provideBase() {
    return getCardViewModelProvider;
  }

  @override
  Widget? buildBottomNavigationBar() {
    return BottomAppBar(
      notchMargin: 0,
      elevation: 0,
      clipBehavior: Clip.none,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 65),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AssetUtils.house),
            Image.asset(AssetUtils.headphoneBlack),
          ],
        ),
      ),
    );
  }

  @override
  Widget? buildFloatingActionButton() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        shape: BoxShape.circle
      ),
      child: Center(
        child: Image.asset(AssetUtils.logoWhite),
      ),
    );
  }


  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, GetCardViewModel model) {
    return GetCardPageView(provideBase());
  }
}
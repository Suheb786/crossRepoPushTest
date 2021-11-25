import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/get_card/get_card_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/get_card/get_card_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class GetCardPage extends BasePage<GetCardViewModel> {
  @override
  GetCardPageState createState() => GetCardPageState();
}

class GetCardPageState extends BaseStatefulPage<GetCardViewModel, GetCardPage> {
  @override
  ProviderBase provideBase() {
    return getCardViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, GetCardViewModel model) {
    return GetCardPageView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/card_detail/card_detail_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/card_detail/card_detail_view_model.dart';

class CardDetailPage extends BasePage<CardDetailViewModel> {
  @override
  CardDetailPageState createState() => CardDetailPageState();
}

class CardDetailPageState
    extends BaseStatefulPage<CardDetailViewModel, CardDetailPage> {
  @override
  ProviderBase provideBase() {
    return cardDetailViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, CardDetailViewModel model) {
    return CardDetailPageView(provideBase());
  }
}

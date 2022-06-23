import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/create_pin/supp_create_pin_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/create_pin/supp_create_pin_page_view_model.dart';

class SuppCreatePinPage extends BasePage<SuppCreatePinPageViewModel> {
  @override
  SuppCreatePinPageState createState() => SuppCreatePinPageState();
}

class SuppCreatePinPageState
    extends BaseStatefulPage<SuppCreatePinPageViewModel, SuppCreatePinPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  SuppCreatePinPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return createReplacementPinViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, SuppCreatePinPageViewModel model) {
    return SuppCreatePinPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/create_pin/create_replacement_pin_page_view.dart';
import 'package:neo_bank/feature/debit_card_replacement/create_pin/create_replacement_pin_page_view_model.dart';

class CreateReplacementPinPage
    extends BasePage<CreateReplacementPinPageViewModel> {
  @override
  CreateReplacementPinPageState createState() =>
      CreateReplacementPinPageState();
}

class CreateReplacementPinPageState extends BaseStatefulPage<
        CreateReplacementPinPageViewModel, CreateReplacementPinPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CreateReplacementPinPageState() : super(subscribeVisibilityEvents: true);

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
  Widget buildView(
      BuildContext context, CreateReplacementPinPageViewModel model) {
    return CreateReplacementPinPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

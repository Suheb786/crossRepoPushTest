import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/card_delivery/create_pin/create_pin_page_view.dart';
import 'package:neo_bank/feature/card_delivery/create_pin/create_pin_page_view_model.dart';

class CreatePinPage extends BasePage<CreatePinPageViewModel> {
  @override
  CreatePinPageState createState() => CreatePinPageState();
}

class CreatePinPageState extends BaseStatefulPage<CreatePinPageViewModel, CreatePinPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CreatePinPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return createPinViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, CreatePinPageViewModel model) {
    return CreatePinPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/change_card_pin/enter_new_pin_for_card/enter_new_pin_for_card_page_view.dart';
import 'package:neo_bank/feature/change_card_pin/enter_new_pin_for_card/enter_new_pin_for_card_page_view_model.dart';

class EnterNewPinForCardPage extends BasePage<EnterNewPinForCardPageViewModel> {
  @override
  EnterNewPinForCardPageState createState() => EnterNewPinForCardPageState();
}

class EnterNewPinForCardPageState extends BaseStatefulPage<
        EnterNewPinForCardPageViewModel, EnterNewPinForCardPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  EnterNewPinForCardPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterNewCardPinViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return ProviderScope.containerOf(context)
                .read(changeCardPinViewModelProvider)
                .cardType ==
            CardType.DEBIT
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, EnterNewPinForCardPageViewModel model) {
    return EnterNewPinForCardPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

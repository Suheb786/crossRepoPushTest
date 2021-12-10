import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/card_delivery/visa_card/visa_card_page_view.dart';
import 'package:neo_bank/feature/card_delivery/visa_card/visa_card_page_view_model.dart';

class VisaCardPage extends BasePage<VisaCardPageViewModel> {
  @override
  VisaCardPageState createState() => VisaCardPageState();
}

class VisaCardPageState
    extends BaseStatefulPage<VisaCardPageViewModel, VisaCardPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  VisaCardPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return visaCardViewModelProvider;
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
  Widget buildView(BuildContext context, VisaCardPageViewModel model) {
    return VisaCardPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/visa_card/supp_pin_set_visa_card_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/visa_card/supp_pin_set_visa_card_page_view_model.dart';

class SuppPinSetVisaCardPage extends BasePage<SuppPinSetVisaCardPageViewModel> {
  @override
  SuppPinSetVisaCardPageState createState() => SuppPinSetVisaCardPageState();
}

class SuppPinSetVisaCardPageState
    extends BaseStatefulPage<SuppPinSetVisaCardPageViewModel, SuppPinSetVisaCardPage>
    with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return suppPinSetVisaCardModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, SuppPinSetVisaCardPageViewModel model) {
    return SuppPinSetVisaCardPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}

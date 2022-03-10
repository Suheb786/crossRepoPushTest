import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/visa_card/replacement_visa_card_page_view.dart';
import 'package:neo_bank/feature/debit_card_replacement/visa_card/replacement_visa_card_page_view_model.dart';

class ReplacementVisaCardPage
    extends BasePage<ReplacementVisaCardPageViewModel> {
  @override
  ReplacementVisaCardPageState createState() => ReplacementVisaCardPageState();
}

class ReplacementVisaCardPageState extends BaseStatefulPage<
    ReplacementVisaCardPageViewModel,
    ReplacementVisaCardPage> with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return replacementVisaCardViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(
      BuildContext context, ReplacementVisaCardPageViewModel model) {
    return ReplacementVisaCardPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9/fatca_us_relevant_w9_page_view.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9/fatca_us_relevant_w9_page_view_model.dart';

class FatcaUSRelevantW9Page extends BasePage<FatcaUSRelevantW9PageViewModel> {
  @override
  FatcaUSRelevantW9PageState createState() => FatcaUSRelevantW9PageState();
}

class FatcaUSRelevantW9PageState extends BaseStatefulPage<
    FatcaUSRelevantW9PageViewModel,
    FatcaUSRelevantW9Page> with AutomaticKeepAliveClientMixin {
  FatcaUSRelevantW9PageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return fatcaUSRelevantW9PageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, FatcaUSRelevantW9PageViewModel model) {
    return FatcaUSRelevantW9PageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}

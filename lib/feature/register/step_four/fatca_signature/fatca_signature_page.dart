import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_signature/fatca_signature_page_view.dart';
import 'package:neo_bank/feature/register/step_four/fatca_signature/fatca_signature_page_view_model.dart';

class FatcaSignaturePage extends BasePage<FatcaSignaturePageViewModel> {
  @override
  FatcaSignaturePageState createState() => FatcaSignaturePageState();
}

class FatcaSignaturePageState
    extends BaseStatefulPage<FatcaSignaturePageViewModel, FatcaSignaturePage>
    with AutomaticKeepAliveClientMixin {
  FatcaSignaturePageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return fatcaSignaturePageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, FatcaSignaturePageViewModel model) {
    return FatcaSignaturePageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}

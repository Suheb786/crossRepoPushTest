import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/steptwo/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/feature/register/steptwo/confirm_detail/confirm_detail_view.dart';
import 'package:riverpod/src/framework.dart';

class ConfirmDetailPage extends BasePage<ConfirmDetailViewModel> {
  @override
  ConfirmDetailPageState createState() => ConfirmDetailPageState();
}

class ConfirmDetailPageState
    extends BaseStatefulPage<ConfirmDetailViewModel, ConfirmDetailPage> {
  @override
  ProviderBase provideBase() {
    return confirmDetailViewModelProvider;
  }

  @override
  void onModelReady(ConfirmDetailViewModel model) {}

  @override
  Widget buildView(BuildContext context, ConfirmDetailViewModel model) {
    return ConfirmDetailView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_view.dart';

class ConfirmDetailPage extends BasePage<ConfirmDetailViewModel> {
  @override
  ConfirmDetailPageState createState() => ConfirmDetailPageState();
}

class ConfirmDetailPageState extends BaseStatefulPage<ConfirmDetailViewModel, ConfirmDetailPage> {
  @override
  ProviderBase provideBase() {
    return confirmDetailViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ConfirmDetailViewModel model) {
    return ConfirmDetailView(provideBase());
  }
}

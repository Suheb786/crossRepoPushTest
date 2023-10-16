import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_creation_success/cliq_id_creation_success_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_creation_success/cliq_id_creation_success_page_view_model.dart';

class CliqIdCreationSuccessPage extends BasePage<CliqIdCreationSuccessPageViewModel> {
  final CliqIdCreationSuccessPageArguments arguments;

  CliqIdCreationSuccessPage(this.arguments);

  @override
  CliqIdCreationSuccessPageState createState() => CliqIdCreationSuccessPageState();
}

class CliqIdCreationSuccessPageState
    extends BaseStatefulPage<CliqIdCreationSuccessPageViewModel, CliqIdCreationSuccessPage> {
  @override
  ProviderBase provideBase() {
    return cliqIdCreationSuccessViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, CliqIdCreationSuccessPageViewModel model) {
    return CliqIdCreationSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(CliqIdCreationSuccessPageViewModel model, {param}) {
    ProviderScope.containerOf(context).read(cliqIdListViewModelProvider).getAlias(true);
    Navigator.pop(context);
    return super.onBackPressed(model);
  }
}

class CliqIdCreationSuccessPageArguments {
  final String cliqType;
  final String cliqName;

  CliqIdCreationSuccessPageArguments({required this.cliqType, required this.cliqName});
}

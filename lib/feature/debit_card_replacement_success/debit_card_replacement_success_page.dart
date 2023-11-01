import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page_view.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page_view_model.dart';

import '../../di/dashboard/dashboard_modules.dart';
import '../../main/navigation/route_paths.dart';

class DebitCardReplacementSuccessPage extends BasePage<DebitCardReplacementSuccessPageViewModel> {
  final DebitCardReplacementSuccessPageArgs _debitCardReplacementArguments;

  DebitCardReplacementSuccessPage(this._debitCardReplacementArguments);

  @override
  DebitCardReplacementSuccessPageState createState() => DebitCardReplacementSuccessPageState();
}

class DebitCardReplacementSuccessPageState
    extends BaseStatefulPage<DebitCardReplacementSuccessPageViewModel, DebitCardReplacementSuccessPage> {
  @override
  ProviderBase provideBase() {
    return cardReplacementSuccessViewModelProvider.call(widget._debitCardReplacementArguments);
  }

  @override
  Widget buildView(BuildContext context, DebitCardReplacementSuccessPageViewModel model) {
    return DebitCardReplacementSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(DebitCardReplacementSuccessPageViewModel model, {param}) {
    if (model.debitCardReplacementArguments.type == DebitReplacementEnum.Normal) {
      Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
      ProviderScope.containerOf(context)
          .read(appHomeViewModelProvider)
          .showSettingPage(false);
      ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    } else {
      Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
      ProviderScope.containerOf(context)
          .read(appHomeViewModelProvider)
          .showSettingPage(false);
      ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    }
    return super.onBackPressed(model);
  }
}

class DebitCardReplacementSuccessPageArgs {
  final DebitReplacementEnum type;

  DebitCardReplacementSuccessPageArgs({required this.type});
}

import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_mobile_number_success/dc_change_mobile_number_success_page_view.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_mobile_number_success/dc_change_mobile_number_success_view_model.dart';

import '../../../di/dashboard/dashboard_modules.dart';
import '../../../main/navigation/route_paths.dart';

class DcChangeMobileNumberSuccessPage extends BasePage<DcChangeMobileNumberSuccessViewModel> {
  final DCChangeLinkedMobileNumberArguments _arguments;

  DcChangeMobileNumberSuccessPage(this._arguments);

  @override
  DcChangeMobileNumberSuccessPageState createState() => DcChangeMobileNumberSuccessPageState();
}

class DcChangeMobileNumberSuccessPageState
    extends BaseStatefulPage<DcChangeMobileNumberSuccessViewModel, DcChangeMobileNumberSuccessPage> {
  @override
  ProviderBase provideBase() {
    return dcChangeMobileNumberSuccessViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return widget._arguments.cardType == CardType.DEBIT
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, DcChangeMobileNumberSuccessViewModel model) {
    return DcChangeMobileNumberSuccessPageView(provideBase(), widget._arguments);
  }

  @override
  Future<bool> onBackPressed(DcChangeMobileNumberSuccessViewModel model, {param}) {
    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/covert_purchase_to_installements/covert_purchase_to_installments_page_view.dart';
import 'package:neo_bank/feature/covert_purchase_to_installements/covert_purchase_to_installments_page_view_model.dart';

class ConvertPurchaseToInstallmentsPage extends BasePage<ConvertPurchaseToInstallmentsPageViewModel> {
  @override
  ConvertPurchaseToInstallmentsPageState createState() => ConvertPurchaseToInstallmentsPageState();
}

class ConvertPurchaseToInstallmentsPageState
    extends BaseStatefulPage<ConvertPurchaseToInstallmentsPageViewModel, ConvertPurchaseToInstallmentsPage> {
  @override
  ProviderBase provideBase() {
    return convertPurchaseToInstallmentsPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ConvertPurchaseToInstallmentsPageViewModel model) {
    return ConvertPurchaseToInstallmentsPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}

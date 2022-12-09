import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';

import 'new_bills_page_view.dart';
import 'new_bills_page_view_model.dart';

class NewBillsPage extends BasePage<NewBillsPageViewModel> {
  @override
  NewBillsPageState createState() => NewBillsPageState();
}

class NewBillsPageState extends BaseStatefulPage<NewBillsPageViewModel, NewBillsPage> {
  @override
  ProviderBase provideBase() {
    return newBillsPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, NewBillsPageViewModel model) {
    return NewBillsPageView(provideBase());
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }
}

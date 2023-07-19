import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';

import 'evoucher_detail_page_view_model.dart';
import 'evoucher_detail_page_view.dart';

class EVoucherDetailPage extends BasePage<EVoucherDetailViewModel> {
  String orderIdentifier;

  EVoucherDetailPage(this.orderIdentifier);

  @override
  EVoucherDetailState createState() => EVoucherDetailState();
}

class EVoucherDetailState extends BaseStatefulPage<EVoucherDetailViewModel, EVoucherDetailPage> {
  @override
  ProviderBase provideBase() {
    return evoucherDetailViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  void onModelReady(EVoucherDetailViewModel model) {
    model.orderIdentifier = widget.orderIdentifier;
    model.getSelectedVoucherAndCallDetailApi();
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, EVoucherDetailViewModel model) {
    return EvoucherDetailView(provideBase());
  }
}

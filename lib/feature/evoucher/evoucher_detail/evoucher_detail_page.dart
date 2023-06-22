import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';

import 'evoucher_detail_model.dart';
import 'evoucher_detail_view.dart';

class EvoucherDetailPage extends BasePage<EvoucherDetailViewModel> {
  @override
  EvoucherDetailState createState() => EvoucherDetailState();
}

class EvoucherDetailState extends BaseStatefulPage<EvoucherDetailViewModel, EvoucherDetailPage> {
  @override
  ProviderBase provideBase() {
    return evoucherDetailViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, EvoucherDetailViewModel model) {
    return EvoucherDetailView(provideBase());
  }
}

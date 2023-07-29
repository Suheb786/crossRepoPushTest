// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/model/e_voucher/get_voucher_details.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';

import 'evoucher_detail_page_view.dart';
import 'evoucher_detail_page_view_model.dart';

class EVoucherDetailPage extends BasePage<EVoucherDetailViewModel> {
  final EvoucherDetailPageArgument argument;
  EVoucherDetailPage({
    required this.argument,
  });
  @override
  EVoucherDetailState createState() => EVoucherDetailState();
}

class EVoucherDetailState extends BaseStatefulPage<EVoucherDetailViewModel, EVoucherDetailPage> {
  @override
  ProviderBase provideBase() {
    return evoucherDetailViewModelProvider.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  void onModelReady(EVoucherDetailViewModel model) {
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, EVoucherDetailViewModel model) {
    return EvoucherDetailView(provideBase());
  }
}

class EvoucherDetailPageArgument {
  final GetVoucherDetails? selectedVoucherData;
  final VoucherDetail? voucherDetail;
  EvoucherDetailPageArgument({required this.selectedVoucherData, required this.voucherDetail});
}

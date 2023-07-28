import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view_model.dart';

class ShareVoucherPage extends BasePage<ShareVoucherPageViewModel> {
  final ShareVoucherPageArgument argument;

  ShareVoucherPage(this.argument);
  @override
  ShareVoucherPageState createState() => ShareVoucherPageState();
}

class ShareVoucherPageState extends BaseStatefulPage<ShareVoucherPageViewModel, ShareVoucherPage> {
  @override
  ProviderBase provideBase() {
    return shareVoucherViewModelProvider.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, ShareVoucherPageViewModel model) {
    return ShareVoucherPageView(provideBase());
  }
}

class ShareVoucherPageArgument {
  final VoucherDetail? voucherDetail;

  ShareVoucherPageArgument(this.voucherDetail);
}

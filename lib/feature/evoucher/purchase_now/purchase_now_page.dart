import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/di/splash/splash_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_view.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';



class PurchaseNowDetailPage extends BasePage<PurchaseNowDetailViewModel> {
  @override
  EvoucherDetailState createState() => EvoucherDetailState();
}

class EvoucherDetailState
    extends BaseStatefulPage<PurchaseNowDetailViewModel, PurchaseNowDetailPage> {
  @override
  ProviderBase provideBase() {
    return purchaseNowDetailViewModelProvider;
  }



  @override
  Widget buildView(BuildContext context, PurchaseNowDetailViewModel model) {
    return PurchaseNowDetailView(provideBase());
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/evoucher/evoucher_detail/evoucher_detail_model.dart';
import 'package:neo_bank/feature/evoucher/evoucher_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';

final evoucherViewModelProvider =
    ChangeNotifierProvider.autoDispose<EvoucherViewModel>(
  (ref) => EvoucherViewModel(),
);

final evoucherDetailViewModelProvider =
    ChangeNotifierProvider.autoDispose<EvoucherDetailViewModel>(
  (ref) => EvoucherDetailViewModel(),
);


final purchaseNowDetailViewModelProvider =
    ChangeNotifierProvider.autoDispose<PurchaseNowDetailViewModel>(
  (ref) => PurchaseNowDetailViewModel(),
);
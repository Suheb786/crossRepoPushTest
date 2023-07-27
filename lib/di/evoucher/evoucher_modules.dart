import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/evouchers/evoucher_usecase.dart';
import 'package:neo_bank/feature/evoucher/enter_code_evoucher_puchase/enter_code_evoucher_puchase_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/evoucher/evoucher_view_model.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/evoucher_detail/evoucher_detail_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/enter_otp_for_evoucher_category_puchase/enter_otp_for_evoucher_category_puchase_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/evoucher_settlement_select_account/evoucher_settlement_account_page_view_model.dart.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/categories_filter/categories_filter_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/region_filter/region_filter_dialog_view_model.dart';

import '../../feature/evoucher/evoucher_category_listing/evoucher_category_listing_page.dart';
import '../../feature/evoucher/purchase_evoucher_without_region/otp_purchase_evoucher_without_region/otp_purchase_evoucher_without_region_page_view_model.dart';
import '../../feature/evoucher/purchase_evoucher_without_region/purchase_evoucher_without_region_page.dart';
import '../../feature/evoucher/purchase_evoucher_without_region/purchase_evoucher_without_region_page_view_model.dart';
import '../../feature/evoucher/purchase_evoucher_without_region/settlement_amount/settlement_amount_page_view_model.dart';
import '../../feature/evoucher/purchase_now/purchase_now_page.dart';

final evoucherViewModelProvider = ChangeNotifierProvider.autoDispose<EvoucherViewModel>(
  (ref) => EvoucherViewModel(
    eVoucherCategoriesUseCase: ref.read(eVoucherCategoriesUseCaseProvider),
    eVoucherHistoryUseCase: ref.read(eVoucherHistoryUseCaseProvider),
    eVoucherItemFilterUseCase: ref.read(eVoucherItemFilterUseCaseProvider),
  ),
);

final evoucherDetailViewModelProvider = ChangeNotifierProvider.autoDispose<EVoucherDetailViewModel>(
  (ref) => EVoucherDetailViewModel(ref.read(eVoucherDetailsPageUseCase)),
);

final purchaseNowDetailViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<PurchaseNowDetailViewModel, PurchaseNowArgument>(
  (ref, args) => PurchaseNowDetailViewModel(ref.read(getSettlementAmountUseCaseProvider), args),
);

///e-vouchers filter dialog
final eVouchersDialogViewModelProvider = ChangeNotifierProvider.autoDispose<EVouchersFilterDialogViewModel>(
    (ref) => EVouchersFilterDialogViewModel(
          ref.read(eVoucherRegionByCategoriesUseCaseProvider),
          ref.read(eVoucherFilterValidationUseCaseProvider),
          ref.read(eVoucherMinMaxValueUseCaseProvider),
        ));

///e-vouchers category listing view model
final eVouchersCategoryListingViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<EVoucherCategoryListingPageViewModel, CategoryListArgument>(
        (ref, arg) => EVoucherCategoryListingPageViewModel(
              arg,
              ref.read(eVoucherByCategoryPageUseCase),
              ref.read(eVoucherItemFilterUseCaseProvider),
            ));

///purchase e-vouchers view model
final purchaseEVouchersViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<PurchaseEVoucherPageViewModel, PurchaseEVoucherPageArgument>(
        (ref, args) => PurchaseEVoucherPageViewModel(args));

///PurchaseEVoucherWithoutRegionPageViewModel
final purchaseEVoucherWithoutRegionPageViewModel = ChangeNotifierProvider.autoDispose
    .family<PurchaseEVoucherWithoutRegionPageViewModel, PurchaseEVoucherWithoutRegionPageArgument>(
        (ref, args) => PurchaseEVoucherWithoutRegionPageViewModel(args));

///select region amount view model
final selectAmountRegionViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<SelectRegionAmountPageViewModel, PurchaseEVoucherPageArgument>(
        (ref, args) => SelectRegionAmountPageViewModel(
              ref.read(selectRegionAmountUseCaseProvider),
              args,
              ref.read(getSettlementAmountUseCaseProvider),
            ));

///settlement
final evoucherSettlementAccountViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<EvoucherSettlementAccountPageViewModel, PurchaseEVoucherPageArgument>((ref, arg) =>
        EvoucherSettlementAccountPageViewModel(
            ref.read(selectAccountUseCaseProvider), arg, ref.read(eVoucherOtpCaseProvider)));

///settlement account
final settlementAccountViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<SettlementAmountPageViewModel, PurchaseEVoucherWithoutRegionPageArgument>((ref, arg) =>
        SettlementAmountPageViewModel(
            ref.read(selectAccountUseCaseProvider), arg, ref.read(eVoucherOtpCaseProvider)));

///e-vouchers categories dialog
final categoriesFilterDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<CategoriesFilterDialogViewModel>(
        (ref) => CategoriesFilterDialogViewModel());

///e-vouchers region by categories dialog
final regionFilterDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<RegionFilterDialogViewModel>((ref) => RegionFilterDialogViewModel());

///enter otp for category evoucher purchase view model
final enterOtpForEVoucherCategoryPurchaseViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<EnterOtpForEVoucherCategoryPurchasePageViewModel, PurchaseEVoucherPageArgument>((ref, arg) =>
        EnterOtpForEVoucherCategoryPurchasePageViewModel(
            ref.read(enterOtpForEVoucherCategoryPurchaseUseCaseUseCaseProvider),
            arg,
            ref.read(placeOrderUseCaseProvider),
            ref.read(eVoucherOtpCaseProvider)));

///otpPurchaseEvoucherWithoutRegionPageViewModelProvider
final otpPurchaseEvoucherWithoutRegionPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<OtpPurchaseEvoucherWithoutRegionPageViewModel, PurchaseEVoucherWithoutRegionPageArgument>(
        (ref, arg) => OtpPurchaseEvoucherWithoutRegionPageViewModel(
            ref.read(enterOtpForEVoucherCategoryPurchaseUseCaseUseCaseProvider),
            arg,
            ref.read(placeOrderUseCaseProvider),
            ref.read(eVoucherOtpCaseProvider)));

///purchase voucher success view model
final purchaseVoucherViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<PurchaseVoucherSuccessPageViewModel, PurchaseVoucherSuccessArgument>(
        (ref, arg) => PurchaseVoucherSuccessPageViewModel(arg));

///share voucher view model
final shareVoucherViewModelProvider =
    ChangeNotifierProvider.autoDispose<ShareVoucherPageViewModel>((ref) => ShareVoucherPageViewModel());

///enter code evoucher purchase view model
final enterCodeEVoucherPurchaseViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterCodeEVoucherPurchasePageViewModel>(
        (ref) => EnterCodeEVoucherPurchasePageViewModel(ref.read(enterCodeEVoucherPurchaseUseCaseProvider)));

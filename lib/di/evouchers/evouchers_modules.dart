import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/evouchers/evoucher_usecase.dart';
import 'package:neo_bank/feature/evouchers/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/feature/evouchers/purchase_evoucher/purchase_evoucher_page_view_model.dart';
import 'package:neo_bank/feature/evouchers/purchase_evoucher/select_account/select_account_page_view_model.dart';
import 'package:neo_bank/feature/evouchers/purchase_evoucher/select_region_amount/select_region_amount_page_view_model.dart';
import 'package:neo_bank/feature/evouchers/purchase_voucher_success/purchase_voucher_success_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog_view_model.dart';

///e-vouchers filter dialog
final eVouchersDialogViewModelProvider = ChangeNotifierProvider.autoDispose<EVouchersFilterDialogViewModel>(
    (ref) => EVouchersFilterDialogViewModel());

///e-vouchers category listing view model
final eVouchersCategoryListingViewModelProvider =
    ChangeNotifierProvider.autoDispose<EVoucherCategoryListingPageViewModel>(
        (ref) => EVoucherCategoryListingPageViewModel());

///purchase e-vouchers view model
final purchaseEVouchersViewModelProvider = ChangeNotifierProvider.autoDispose<PurchaseEVoucherPageViewModel>(
    (ref) => PurchaseEVoucherPageViewModel());

///select region amount view model
final selectAmountRegionViewModelProvider =
    ChangeNotifierProvider.autoDispose<SelectRegionAmountPageViewModel>(
        (ref) => SelectRegionAmountPageViewModel(ref.read(selectRegionAmountUseCaseProvider)));

///select  account view model
final selectAccountViewModelProvider = ChangeNotifierProvider.autoDispose<SelectAccountPageViewModel>(
    (ref) => SelectAccountPageViewModel(ref.read(selectAccountUseCaseProvider)));

///purchase voucher success view model
final purchaseVoucherViewModelProvider =
    ChangeNotifierProvider.autoDispose<PurchaseVoucherSuccessPageViewModel>(
        (ref) => PurchaseVoucherSuccessPageViewModel());

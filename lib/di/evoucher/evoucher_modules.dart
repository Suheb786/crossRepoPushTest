import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/evouchers/evoucher_usecase.dart';
import 'package:neo_bank/feature/evoucher/enter_code_evoucher_puchase/enter_code_evoucher_puchase_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/evoucher_detail/evoucher_detail_model.dart';
import 'package:neo_bank/feature/evoucher/evoucher/evoucher_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/enter_otp_for_evoucher_category_puchase/enter_otp_for_evoucher_category_puchase_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_account/select_account_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/share_voucher/share_voucher_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog_view_model.dart';

final evoucherViewModelProvider = ChangeNotifierProvider.autoDispose<EvoucherViewModel>(
  (ref) => EvoucherViewModel(ref.read(landingPageUseCase)),
);

final evoucherDetailViewModelProvider = ChangeNotifierProvider.autoDispose<EvoucherDetailViewModel>(
  (ref) => EvoucherDetailViewModel(),
);

final purchaseNowDetailViewModelProvider = ChangeNotifierProvider.autoDispose<PurchaseNowDetailViewModel>(
  (ref) => PurchaseNowDetailViewModel(),
);

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

///enter otp for category evoucher purchase view model
final enterOtpForEVoucherCategoryPurchaseViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterOtpForEVoucherCategoryPurchasePageViewModel>((ref) =>
        EnterOtpForEVoucherCategoryPurchasePageViewModel(
            ref.read(enterOtpForEVoucherCategoryPurchaseUseCaseUseCaseProvider)));

///purchase voucher success view model
final purchaseVoucherViewModelProvider =
    ChangeNotifierProvider.autoDispose<PurchaseVoucherSuccessPageViewModel>(
        (ref) => PurchaseVoucherSuccessPageViewModel());

///share voucher view model
final shareVoucherViewModelProvider =
    ChangeNotifierProvider.autoDispose<ShareVoucherPageViewModel>((ref) => ShareVoucherPageViewModel());

///enter code evoucher purchase view model
final enterCodeEVoucherPurchaseViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterCodeEVoucherPurchasePageViewModel>(
        (ref) => EnterCodeEVoucherPurchasePageViewModel(ref.read(enterCodeEVoucherPurchaseUseCaseProvider)));

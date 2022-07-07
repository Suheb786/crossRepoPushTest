import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/evouchers/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog_view_model.dart';

///e-vouchers filter dialog
final eVouchersDialogViewModelProvider = ChangeNotifierProvider.autoDispose<EVouchersFilterDialogViewModel>(
    (ref) => EVouchersFilterDialogViewModel());

///e-vouchers category listing view model
final eVouchersCategoryListingViewModelProvider =
    ChangeNotifierProvider.autoDispose<EVoucherCategoryListingPageViewModel>(
        (ref) => EVoucherCategoryListingPageViewModel());

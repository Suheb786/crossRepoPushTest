import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/evouchers/enter_code_evoucher_purchase_usecase.dart';
import 'package:domain/usecase/evouchers/enter_otp_for_evoucher_category_purchase_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_by_category_usecase.dart';
import 'package:domain/usecase/evouchers/select_account_usecase.dart';
import 'package:domain/usecase/evouchers/select_region_amount_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_landing_page_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_details_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[SelectRegionAmountUseCase] provider
final selectRegionAmountUseCaseProvider = Provider.autoDispose<SelectRegionAmountUseCase>(
  (ref) => SelectRegionAmountUseCase(),
);

///[SelectAccountUseCase] provider
final selectAccountUseCaseProvider = Provider.autoDispose<SelectAccountUseCase>(
  (ref) => SelectAccountUseCase(),
);

///[EnterCodeEVoucherPurchaseUseCase] provider
final enterCodeEVoucherPurchaseUseCaseProvider = Provider.autoDispose<EnterCodeEVoucherPurchaseUseCase>(
  (ref) => EnterCodeEVoucherPurchaseUseCase(),
);

///[EnterOtpForEVoucherCategoryPurchaseUseCase] provider
final enterOtpForEVoucherCategoryPurchaseUseCaseUseCaseProvider =
    Provider.autoDispose<EnterOtpForEVoucherCategoryPurchaseUseCase>(
  (ref) => EnterOtpForEVoucherCategoryPurchaseUseCase(),
);

///[EVoucherLandingPageUseCase] provider
final eVoucherLandingPageUseCase = Provider.autoDispose<EVoucherLandingPageUseCase>(
  (ref) => EVoucherLandingPageUseCase(ref.read(eVoucherRepositoryProvider)),
);

///[EVoucherByCategoryPageUseCase] provider
final eVoucherByCategoryPageUseCase = Provider.autoDispose<EVoucherByCategoryPageUseCase>(
        (ref) => EVoucherByCategoryPageUseCase(ref.read(eVoucherRepositoryProvider)),
);

///[EVoucherDetailsPageUseCase] provider
final eVoucherDetailsPageUseCase = Provider.autoDispose<EVoucherDetailsPageUseCase>(
        (ref) => EVoucherDetailsPageUseCase(ref.read(eVoucherRepositoryProvider)),
);
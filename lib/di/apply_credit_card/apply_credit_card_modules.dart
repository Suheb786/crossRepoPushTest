import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/apply_credit_card/apply_credit_card_usecase_provider.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/feature/apply_credit_card_home/apply_credit_card_home_view_model.dart';
import 'package:neo_bank/feature/credit_card_activation_status/credit_card_activation_status_page_view_model.dart';
import 'package:neo_bank/feature/set_credit_limit/set_credit_limit_view_model.dart';
import 'package:neo_bank/feature/supplementary_credit_card_activation_status/supplementary_credit_card_activation_status_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card_activation_status/supplementary_credit_card_activation_status_page_view_model.dart';

final applyCreditCardHomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<ApplyCreditCardHomeViewModel>(
  (ref) => ApplyCreditCardHomeViewModel(),
);

final setCreditLimitViewModelProvider =
    ChangeNotifierProvider.autoDispose<SetCreditLimitViewModel>(
  (ref) => SetCreditLimitViewModel(ref.read(setCreditLimitUseCaseProvider),
      ref.read(getLoanValueUseCaseProvider)),
);

final creditCardActivationViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreditCardActivationStatusPageViewModel>(
  (ref) => CreditCardActivationStatusPageViewModel(
      ref.read(getCardApplicationUseCaseProvider),
      ref.read(creditCardRequestUseCaseProvider),
      ref.read(linkCardStepUseCaseProvider)),
);

final supplementaryCreditCardActivationViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<
        SupplementaryCreditCardActivationStatusPageViewModel,
        SupplementaryCreditCardActivationArguments>(
  (ref, args) => SupplementaryCreditCardActivationStatusPageViewModel(
      ref.read(getSupplementaryCreditCardApplicationUseCaseProvider),
      ref.read(supplementaryCreditCardStepTwoUseCaseProvider),
      ref.read(supplementaryCreditCardStepThreeUseCaseProvider),
      args),
);

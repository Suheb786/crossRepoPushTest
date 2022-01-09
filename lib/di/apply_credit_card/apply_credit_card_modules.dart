import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/apply_credit_card/apply_credit_card_usecase_provider.dart';
import 'package:neo_bank/feature/apply_credit_card_home/apply_credit_card_home_view_model.dart';
import 'package:neo_bank/feature/set_credit_limit/set_credit_limit_view_model.dart';

final applyCreditCardHomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<ApplyCreditCardHomeViewModel>(
  (ref) => ApplyCreditCardHomeViewModel(),
);

final setCreditLimitViewModelProvider =
    ChangeNotifierProvider.autoDispose<SetCreditLimitViewModel>(
  (ref) => SetCreditLimitViewModel(ref.read(setCreditLimitUseCaseProvider)),
);

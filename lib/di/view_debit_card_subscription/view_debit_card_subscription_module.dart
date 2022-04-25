import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/view_debit_card_subscription/view_debit_card_subscription_page.dart';
import 'package:neo_bank/feature/view_debit_card_subscription/view_debit_card_subscription_view_model.dart';

final viewDebitCardSubscriptionViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<
        ViewDebitCardSubscriptionViewModel, ViewDebitCardSubscriptionArguments>(
  (ref, args) => ViewDebitCardSubscriptionViewModel(args),
);

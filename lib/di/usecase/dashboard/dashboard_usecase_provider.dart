import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/dashboard/account_transaction_usecase.dart';
import 'package:domain/usecase/dashboard/card_transaction_usecase.dart';
import 'package:domain/usecase/dashboard/credit_card_delivered_usecase.dart';
import 'package:domain/usecase/dashboard/credit_card_verification_success_usecase.dart';
import 'package:domain/usecase/dashboard/debit_card_delivered_usecase.dart';
import 'package:domain/usecase/dashboard/debit_card_timeline_usecase.dart';
import 'package:domain/usecase/dashboard/debit_card_verification_success_usecase.dart';
import 'package:domain/usecase/dashboard/get_atms_usecase.dart';
import 'package:domain/usecase/dashboard/get_card_usecase.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:domain/usecase/dashboard/get_debit_card_transactions_usecase.dart';
import 'package:domain/usecase/dashboard/my_account_usecase.dart';
import 'package:domain/usecase/dashboard/my_debit_card_usecase.dart';
import 'package:domain/usecase/dashboard/placeholder_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GetCardUseCase] provider
final getCardUseCaseProvider = Provider.autoDispose<GetCardUseCase>(
  (ref) => GetCardUseCase(),
);

///[MyAccountUseCase] provider
final myAccountUseCaseProvider = Provider.autoDispose<MyAccountUseCase>(
  (ref) => MyAccountUseCase(),
);

///[<MyDebitCardUseCase>] provider
final myDebitCardUseCaseProvider = Provider.autoDispose<MyDebitCardUseCase>(
  (ref) => MyDebitCardUseCase(),
);

///[<MyDebitCardUseCase>] provider
final placeholderUseCaseProvider = Provider.autoDispose<PlaceholderUseCase>(
  (ref) => PlaceholderUseCase(),
);

///[<CardDeliveredUseCase>] provider
final cardDeliveredUseCaseProvider =
    Provider.autoDispose<DebitCardDeliveredUseCase>(
  (ref) => DebitCardDeliveredUseCase(),
);

///[<DebitCardVerificationSuccessUseCase>] provider
final debitCardVerificationSuccessUseCaseProvider =
    Provider.autoDispose<DebitCardVerificationSuccessUseCase>(
  (ref) => DebitCardVerificationSuccessUseCase(),
);

///[<CardTransactionUseCase>] provider
final cardTransactionUseCaseProvider =
    Provider.autoDispose<CardTransactionUseCase>(
  (ref) => CardTransactionUseCase(),
);

///[<CreditCardDeliveredUseCase>] provider
final creditCardDeliveredUseCaseProvider =
    Provider.autoDispose<CreditCardDeliveredUseCase>(
  (ref) => CreditCardDeliveredUseCase(),
);

///[<CreditCardVerificationSuccessUseCase>] provider
final creditCardVerificationSuccessUseCaseProvider =
    Provider.autoDispose<CreditCardVerificationSuccessUseCase>(
  (ref) => CreditCardVerificationSuccessUseCase(),
);

///[<AccountTransactionUseCase>] provider
final accountTransactionUseCaseProvider =
    Provider.autoDispose<AccountTransactionUseCase>(
  (ref) => AccountTransactionUseCase(),
);

///[<DebitCardTimeLineUseCase>] provider
final debitCardTimeLineUseCaseProvider =
    Provider.autoDispose<DebitCardTimeLineUseCase>(
  (ref) => DebitCardTimeLineUseCase(),
);

///[GetAtmsUseCase] provider
final getAtmUseCaseProvider = Provider.autoDispose<GetAtmsUseCase>(
  (ref) => GetAtmsUseCase(ref.read(dashboardRepositoryProvider)),
);

///[GetDashboardDataUseCase] provider
final getDashboardDataUseCaseProvider =
    Provider.autoDispose<GetDashboardDataUseCase>(
  (ref) => GetDashboardDataUseCase(ref.read(dashboardRepositoryProvider)),
);

///[GetDebitCardTransactionsUseCase] provider
final getDebitCardTransactionUseCaseProvider =
    Provider.autoDispose<GetDebitCardTransactionsUseCase>(
  (ref) =>
      GetDebitCardTransactionsUseCase(ref.read(dashboardRepositoryProvider)),
);

import 'package:domain/usecase/manage_cliq/approve_RTP_request_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/activity/activity_usecase_provider.dart';
import 'package:neo_bank/di/usecase/manage_cliq_id/manage_cliq_id_usecase.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_view_model.dart';
import 'package:neo_bank/feature/activity/notification/notification_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';

final notificationViewModelProvider =
    ChangeNotifierProvider.autoDispose<NotificationViewModel>(
  (ref) => NotificationViewModel(ref.read(notificationUseCaseProvider)),
);

final activityHomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<ActivityHomeViewModel>(
  (ref) => ActivityHomeViewModel(
    ref.read(paymentActivityTransactionUseCaseProvider),
    ref.read(notificationUseCaseProvider),
    ref.read(requestMoneyActivityUseCaseProvider),
  ),
);

final paymentActivityViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentActivityViewModel>(
  (ref) => PaymentActivityViewModel(),
);

final paymentActivityTransactionViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentActivityTransactionViewModel>(
  (ref) => PaymentActivityTransactionViewModel(
      ref.read(paymentActivityTransactionUseCaseProvider),
      ref.read(requestMoneyActivityUseCaseProvider),
      ref.read(approveRTPRequestUseCaseProivder)),
);

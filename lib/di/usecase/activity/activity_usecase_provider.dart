import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/activity/notification_usecase.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:domain/usecase/activity/payment_activity_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[NotificationUseCase] provider
final notificationUseCaseProvider = Provider.autoDispose<NotificationUseCase>(
    (ref) => NotificationUseCase(ref.read(activityRepositoryProvider)));

///[PaymentActivityUseCase] provider
final paymentActivityUseCaseProvider =
    Provider.autoDispose<PaymentActivityUseCase>((ref) => PaymentActivityUseCase());

///[PaymentActivityTransactionUseCase] provider
final paymentActivityTransactionUseCaseProvider = Provider.autoDispose<PaymentActivityTransactionUseCase>(
    (ref) => PaymentActivityTransactionUseCase(ref.read(paymentRepositoryProvider)));

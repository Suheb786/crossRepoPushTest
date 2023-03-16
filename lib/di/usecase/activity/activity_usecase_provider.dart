import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/activity/activity_otp_validation_usecase.dart';
import 'package:domain/usecase/activity/notification_usecase.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:domain/usecase/activity/payment_activity_usecase.dart';
import 'package:domain/usecase/activity/reason_to_reject_validation_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domain/usecase/activity/return_payment_transaction_usecase.dart';
import 'package:domain/usecase/activity/return_payment_OTP_usecase.dart';

///[NotificationUseCase] provider
final notificationUseCaseProvider = Provider.autoDispose<NotificationUseCase>(
    (ref) => NotificationUseCase(ref.read(activityRepositoryProvider)));

///[PaymentActivityUseCase] provider
final paymentActivityUseCaseProvider =
    Provider.autoDispose<PaymentActivityUseCase>((ref) => PaymentActivityUseCase());

///[PaymentActivityTransactionUseCase] provider
final paymentActivityTransactionUseCaseProvider = Provider.autoDispose<PaymentActivityTransactionUseCase>(
    (ref) => PaymentActivityTransactionUseCase(ref.read(paymentRepositoryProvider)));

///[ReturnPaymentActivityTransactionUseCase] provider
final returnPaymentActivityTransactionUseCaseProvider =
    Provider.autoDispose<ReturnPaymentTransactionUsecase>((ref) => ReturnPaymentTransactionUsecase());

///[ReturnPaymentActivityOTPUseCase] provider
final returnPaymentActivityOTPUseCaseProvider =
    Provider.autoDispose<ReturnPaymentOTPUseCase>((ref) => ReturnPaymentOTPUseCase());
final activityOtpValidationUseCaseProvider = Provider.autoDispose<ActivityOtpValidationUseCase>(
  (ref) => ActivityOtpValidationUseCase(),
);

final reasonToRejectValidationUseCaseProvider = Provider.autoDispose<ReasonToRejectValidationUseCase>(
  (ref) => ReasonToRejectValidationUseCase(),
);

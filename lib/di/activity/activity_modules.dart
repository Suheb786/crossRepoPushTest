import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/activity/activity_usecase_provider.dart';
import 'package:neo_bank/di/usecase/manage_cliq_id/manage_cliq_id_usecase.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_view_model.dart';
import 'package:neo_bank/feature/activity/notification/notification_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/accept_request_money_otp_screen/accept_request_money_otp_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/accept_request_money_otp_screen/accept_request_money_otp_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_otp_screen/reject_request_payment_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/select_reject_reason/select_reject_reason_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_otp/return_payment_otp_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_reason_selection/return_payment_reason_selection_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_transaction_slider_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/reject_reason_inward_request/reject_reason_inward_request_dialog_view_model.dart';

final notificationViewModelProvider = ChangeNotifierProvider.autoDispose<NotificationViewModel>(
  (ref) => NotificationViewModel(ref.read(notificationUseCaseProvider)),
);

final activityHomeViewModelProvider = ChangeNotifierProvider.autoDispose<ActivityHomeViewModel>(
  (ref) => ActivityHomeViewModel(
    ref.read(paymentActivityTransactionUseCaseProvider),
    ref.read(notificationUseCaseProvider),
    ref.read(requestMoneyActivityUseCaseProvider),
  ),
);

final paymentActivityViewModelProvider = ChangeNotifierProvider.autoDispose<PaymentActivityViewModel>(
  (ref) => PaymentActivityViewModel(),
);

final paymentActivityTransactionViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentActivityTransactionViewModel>(
  (ref) => PaymentActivityTransactionViewModel(ref.read(paymentActivityTransactionUseCaseProvider),
      ref.read(requestMoneyActivityUseCaseProvider), ref.read(approveRTPOtpUseCaseProivder)),
);

final returnPaymentTransactionSliderPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ReturnPaymentTransactionSliderPageViewModel>(
        (ref) => ReturnPaymentTransactionSliderPageViewModel());

final returnPaymentOtpPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ReturnPaymentOtpPageViewModel>(
  (ref) => ReturnPaymentOtpPageViewModel(
    ref.read(returnPaymentActivityOTPUseCaseProvider),
    ref.read(returnRTPrequestOTPUseCaseProivder),
    ref.read(returnRTPrequestUseCaseProivder),
  ),
);

final acceptRequestMoneyOtpPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<AcceptRequestMoneyOtpPageViewModel, AcceptRequestMoneyOtpPageArgument>(
  (ref, args) => AcceptRequestMoneyOtpPageViewModel(args, ref.read(activityOtpValidationUseCaseProvider),
      ref.read(approveRTPRequestUseCaseProivder), ref.read(approveRTPOtpUseCaseProivder)),
);

final rejectRequestPaymentPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<RejectRequestPaymentPageViewModel>(
  (ref) => RejectRequestPaymentPageViewModel(),
);

final selectRejectReasonPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<SelectRejectReasonPageViewModel>(
  (ref) => SelectRejectReasonPageViewModel(ref.read(reasonToRejectValidationUseCaseProvider),
      ref.read(rejectionReasonInwardUseCaseProvider), ref.read(requestToPayResultOtpUseCaseProivder)),
);

final rejectRequestPaymentOtpPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<RejectRequestPaymentOtpPageViewModel>(
  (ref) => RejectRequestPaymentOtpPageViewModel(ref.read(activityOtpValidationUseCaseProvider),
      ref.read(requestToPayResultUseCaseProvider), ref.read(requestToPayResultOtpUseCaseProivder)),
);

final creditConfirmationPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreditConfirmationPaymentActivityViewModel>(
  (ref) => CreditConfirmationPaymentActivityViewModel(),
);

final paymentTransationSuccessPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<PaymentTransationSuccessPageViewModel, PaymentTransationSuccessArgument>(
  (ref, arg) => PaymentTransationSuccessPageViewModel(arg),
);

final rejectReasonInwardRequestDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<RejectReasonInwardRequestDialogViewModel>(
  (ref) => RejectReasonInwardRequestDialogViewModel(),
);

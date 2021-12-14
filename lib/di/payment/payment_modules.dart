import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_view_model.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/feature/payment/payment_to_new_recipient/payment_to_new_recipient_view_model.dart';
import 'package:neo_bank/feature/payment/request_amount_from_contact/request_amount_from_contact_view_model.dart';
import 'package:neo_bank/feature/payment/request_money/request_money_view_model.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_view_model.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_view_model.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_view_model.dart';
import 'package:neo_bank/feature/payment/send_money/send_money_view_model.dart';
import 'package:neo_bank/feature/payment/send_to_new_recipient/send_to_new_recipient_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/edit_transaction_purpose_dialog/edit_transaction_purpose_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog_view_model.dart';

final paymentHomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentHomeViewModel>(
  (ref) => PaymentHomeViewModel(),
);

final addSendMoneyContactViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddSendMoneyContactViewModel>(
  (ref) => AddSendMoneyContactViewModel(
      ref.read(addSendMoneyContactUseCaseProvider)),
);

final addRequestMoneyContactViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddRequestMoneyContactViewModel>(
  (ref) => AddRequestMoneyContactViewModel(
      ref.read(addRequestMoneyContactUseCaseProvider)),
);

final sendAmountToContactViewModelProvider =
    ChangeNotifierProvider.autoDispose<SendAmountToContactViewModel>(
  (ref) => SendAmountToContactViewModel(
      ref.read(sendAmountToContactUseCaseProvider)),
);

final sendAmountToContactSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<SendAmountToContactSuccessViewModel>(
  (ref) => SendAmountToContactSuccessViewModel(
      ref.read(sendAmountToContactSuccessUseCaseProvider)),
);

final requestAmountFromContactViewModelProvider =
    ChangeNotifierProvider.autoDispose<RequestAmountFromContactViewModel>(
  (ref) => RequestAmountFromContactViewModel(
      ref.read(requestAmountFromContactUseCaseProvider)),
);

final requestAmountFromContactSuccessViewModelProvider = ChangeNotifierProvider
    .autoDispose<RequestAmountFromContactSuccessViewModel>(
  (ref) => RequestAmountFromContactSuccessViewModel(
      ref.read(requestAmountFromContactSuccessUseCaseProvider)),
);

final sendMoneyViewModelProvider =
    ChangeNotifierProvider.autoDispose<SendMoneyViewModel>(
  (ref) => SendMoneyViewModel(ref.read(sendMoneyUseCaseProvider)),
);

final requestMoneyViewModelProvider =
    ChangeNotifierProvider.autoDispose<RequestMoneyViewModel>(
  (ref) => RequestMoneyViewModel(ref.read(requestMoneyUseCaseProvider)),
);

final sendToNewRecipientViewModelProvider =
    ChangeNotifierProvider.autoDispose<SendToNewRecipientViewModel>(
  (ref) =>
      SendToNewRecipientViewModel(ref.read(sendToNewRecipientUseCaseProvider)),
);

final enterOtpViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterOtpViewModel>(
  (ref) => EnterOtpViewModel(ref.read(enterOtpUseCaseProvider)),
);

final paymentToNewRecipientViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentToNewRecipientViewModel>(
  (ref) => PaymentToNewRecipientViewModel(),
);

///edit transaction purpose dialog view model provider
final editTransactionPurposeDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<EditTransactionPurposeDialogViewModel>(
        (ref) => EditTransactionPurposeDialogViewModel());

///transaction purpose Detail dialog view model provider
final purposeDetailDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<PurposeDetailDialogViewModel>(
        (ref) => PurposeDetailDialogViewModel());

///transaction purpose dialog view model provider
final purposeDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<PurposeDialogViewModel>(
        (ref) => PurposeDialogViewModel());

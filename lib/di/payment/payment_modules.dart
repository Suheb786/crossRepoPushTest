import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/payment/transfer_success_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_view_model.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/feature/payment/payment_to_new_recipient/payment_to_new_recipient_view_model.dart';
import 'package:neo_bank/feature/payment/request_amount_from_contact/request_amount_from_contact_view_model.dart';
import 'package:neo_bank/feature/payment/request_from_new_recipient/request_from_new_recipient_view_model.dart';
import 'package:neo_bank/feature/payment/request_money/request_money_view_model.dart';
import 'package:neo_bank/feature/payment/request_money_failure/request_money_failure_view_model.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_view_model.dart';
import 'package:neo_bank/feature/payment/request_payment_from_new_recipient/request_payment_from_new_recipient_view_model.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_view_model.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_view_model.dart';
import 'package:neo_bank/feature/payment/send_money/send_money_view_model.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_view_model.dart';
import 'package:neo_bank/feature/payment/send_to_new_recipient/send_to_new_recipient_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/edit_transaction_purpose_dialog/edit_transaction_purpose_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/iban_dialog/iban_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog_view_model.dart';

final paymentHomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentHomeViewModel>(
  (ref) => PaymentHomeViewModel(ref.read(getBeneficiaryUseCaseProvider)),
);

final addSendMoneyContactViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddSendMoneyContactViewModel>(
  (ref) => AddSendMoneyContactViewModel(
      ref.read(addSendMoneyContactUseCaseProvider)),
);

final addRequestMoneyContactViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddRequestMoneyContactViewModel>(
  (ref) => AddRequestMoneyContactViewModel(),
);

final sendAmountToContactViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<SendAmountToContactViewModel, Beneficiary>(
  (ref, args) => SendAmountToContactViewModel(
      ref.read(sendAmountToContactUseCaseProvider),
      args,
      ref.read(checkSendMoneyUseCaseProvider),
      ref.read(transferUseCaseProvider)),
);

final sendAmountToContactSuccessViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<SendAmountToContactSuccessViewModel, TransferSuccessContent>(
      (ref, args) =>
      SendAmountToContactSuccessViewModel(
          ref.read(sendAmountToContactSuccessUseCaseProvider), args),
);

final requestAmountFromContactViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<RequestAmountFromContactViewModel, Beneficiary>(
      (ref, args) =>
      RequestAmountFromContactViewModel(
          ref.read(requestAmountFromContactUseCaseProvider),
          ref.read(getAccountByAliasUseCaseProvider), args),
);

final requestAmountFromContactSuccessViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<RequestAmountFromContactSuccessViewModel, List<String>>(
  (ref, args) => RequestAmountFromContactSuccessViewModel(
      ref.read(requestAmountFromContactSuccessUseCaseProvider), args),
);

final requestMoneyFailureViewModelProvider =
    ChangeNotifierProvider.autoDispose<RequestMoneyFailureViewModel>(
  (ref) => RequestMoneyFailureViewModel(
      ref.read(requestMoneyFailureUseCaseProvider)),
);

final sendMoneyFailureViewModelProvider =
    ChangeNotifierProvider.autoDispose<SendMoneyFailureViewModel>(
  (ref) => SendMoneyFailureViewModel(ref.read(sendMoneyFailureUseCaseProvider)),
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
  (ref) => SendToNewRecipientViewModel(
      ref.read(sendToNewRecipientUseCaseProvider),
      ref.read(uploadDocumentUseCaseProvider),
      ref.read(checkSendMoneyUseCaseProvider),
      ref.read(transferVerifyUseCaseProvider)),
);

final enterOtpViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterOtpViewModel>(
  (ref) => EnterOtpViewModel(
      ref.read(enterOtpUseCaseProvider), ref.read(transferUseCaseProvider)),
);

final requestFromNewRecipientViewModelProvider =
    ChangeNotifierProvider.autoDispose<RequestFromNewRecipientViewModel>(
  (ref) => RequestFromNewRecipientViewModel(
      ref.read(requestFromNewRecipientUseCaseProvider),
      ref.read(uploadDocumentUseCaseProvider),
      ref.read(getAccountByAliasUseCaseProvider)),
);

final paymentToNewRecipientViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentToNewRecipientViewModel>(
  (ref) => PaymentToNewRecipientViewModel(),
);

final requestPaymentFromNewRecipientViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<RequestPaymentFromNewRecipientViewModel, String>(
  (ref, args) => RequestPaymentFromNewRecipientViewModel(args),
);

///edit transaction purpose dialog view model provider
final editTransactionPurposeDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<EditTransactionPurposeDialogViewModel>(
        (ref) => EditTransactionPurposeDialogViewModel());

///iban dialog view model provider
final ibanDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<IbanDialogViewModel>(
        (ref) => IbanDialogViewModel());

///transaction purpose Detail dialog view model provider
final purposeDetailDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<PurposeDetailDialogViewModel>(
        (ref) => PurposeDetailDialogViewModel());

///transaction purpose dialog view model provider
final purposeDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<PurposeDialogViewModel>(
        (ref) => PurposeDialogViewModel());

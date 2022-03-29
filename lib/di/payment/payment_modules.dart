import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/payment/transfer_success_content.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_pay_back_success/credit_card_pay_back_success_page.dart';
import 'package:neo_bank/feature/credit_card_pay_back_success/credit_card_pay_back_success_page_view_model.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/all_contact_page/all_contact_page.dart';
import 'package:neo_bank/feature/payment/all_contact_page/all_contact_page_view_model.dart';
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
import 'package:neo_bank/feature/request_money_via_qr/qr_screen/qr_screen_page_view_model.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/accounts_dialog/accounts_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/edit_transaction_purpose_dialog/edit_transaction_purpose_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/iban_dialog/iban_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/payment_activity_filter_dialog/payment_activity_filter_dialog_view_model.dart';
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
      ref.read(transferUseCaseProvider),
      ref.read(getPurposeUseCaseProvider)),
);

final sendAmountToContactSuccessViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<SendAmountToContactSuccessViewModel, TransferSuccessContent>(
  (ref, args) => SendAmountToContactSuccessViewModel(
      ref.read(sendAmountToContactSuccessUseCaseProvider), args),
);

final requestAmountFromContactViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<RequestAmountFromContactViewModel, Beneficiary>(
  (ref, args) => RequestAmountFromContactViewModel(
      ref.read(requestAmountFromContactUseCaseProvider),
      ref.read(getAccountByAliasUseCaseProvider),
      args),
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
      ref.read(transferVerifyUseCaseProvider),
      ref.read(getPurposeUseCaseProvider)),
);

final enterOtpViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterOtpViewModel>(
  (ref) => EnterOtpViewModel(
      ref.read(enterOtpUseCaseProvider),
      ref.read(transferUseCaseProvider),
      ref.read(transferVerifyUseCaseProvider)),
);

final requestFromNewRecipientViewModelProvider =
    ChangeNotifierProvider.autoDispose<RequestFromNewRecipientViewModel>(
  (ref) => RequestFromNewRecipientViewModel(
      ref.read(requestFromNewRecipientUseCaseProvider),
      ref.read(uploadDocumentUseCaseProvider),
      ref.read(getAccountByAliasUseCaseProvider),
      ref.read(getPurposeUseCaseProvider)),
);

final paymentToNewRecipientViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentToNewRecipientViewModel>(
  (ref) => PaymentToNewRecipientViewModel(),
);

/// credit card pay back
final creditCardPayBackViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<CreditCardPayBackPageModel, CreditCardPayBackArguments>(
  (ref, args) => CreditCardPayBackPageModel(
      ref.read(payBackCreditCardUseCaseProvider), args),
);

/// credit card pay back success
final creditCardPayBackSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<CreditCardPayBackSuccessViewModel,
        CreditCardPayBackSuccessArguments>(
  (ref, args) => CreditCardPayBackSuccessViewModel(args),
);

final requestPaymentFromNewRecipientViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<RequestPaymentFromNewRecipientViewModel, String>(
  (ref, args) => RequestPaymentFromNewRecipientViewModel(args),
);

///edit transaction purpose dialog view model provider
final editTransactionPurposeDialogViewModelProvider = ChangeNotifierProvider
    .autoDispose
    .family<EditTransactionPurposeDialogViewModel, List<dynamic>>((ref, args) =>
        EditTransactionPurposeDialogViewModel(
            ref.read(getPurposeUseCaseProvider), args));

///iban dialog view model provider
final ibanDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<IbanDialogViewModel>(
        (ref) => IbanDialogViewModel());

///transaction purpose Detail dialog view model provider
final purposeDetailDialogViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<PurposeDetailDialogViewModel, List<PurposeDetail>>(
        (ref, args) => PurposeDetailDialogViewModel(args));

///transaction purpose dialog view model provider
final purposeDialogViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<PurposeDialogViewModel, List<Purpose>>(
        (ref, args) => PurposeDialogViewModel(args));

///view all payment contact
final allContactsViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<AllContactPageViewModel, AllContactArguments>(
  (ref, args) => AllContactPageViewModel(args),
);

///payment activity filter dialog view model provider
final paymentActivityFilterDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<PaymentActivityFilterDialogViewModel>((
  ref,
) =>
        PaymentActivityFilterDialogViewModel());

///request money QR code generation view model
final requestMoneyQrGenerationViewModelProvider =
    ChangeNotifierProvider.autoDispose<RequestMoneyQrGenerationPageViewModel>((
  ref,
) =>
        RequestMoneyQrGenerationPageViewModel());

///accounts dialog view model provider
final accountsDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<AccountsDialogViewModel>(
        (ref) => AccountsDialogViewModel());

///qr screen view model provider
final qrScreenViewModelProvider =
    ChangeNotifierProvider.autoDispose<QrScreenPageViewModel>(
        (ref) => QrScreenPageViewModel());

///send money qr scanning view model provider
final sendMoneyQrScanningViewModelProvider =
    ChangeNotifierProvider.autoDispose<SendMoneyQrScanningPageViewModel>(
        (ref) => SendMoneyQrScanningPageViewModel());

///send money qr success view model provider
final sendMoneyQrSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<SendMoneyViaQrSuccessPageViewModel>(
        (ref) => SendMoneyViaQrSuccessPageViewModel());

import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/activity/return_payment_transaction_usecase.dart';
import 'package:domain/usecase/dynamic_link/create_dynamic_link_usecases.dart';
import 'package:domain/usecase/dynamic_link/init_dynamic_link_usecase.dart';
import 'package:domain/usecase/manage_contacts/get_beneficiary_usecase.dart';
import 'package:domain/usecase/payment/add_send_money_contact_usecase.dart';
import 'package:domain/usecase/payment/check_send_money_usecase.dart';
import 'package:domain/usecase/payment/enter_otp_usecase.dart';
import 'package:domain/usecase/payment/enter_request_otp_usecase.dart';
import 'package:domain/usecase/payment/generate_qr_usecase.dart';
import 'package:domain/usecase/payment/get_account_by_alias_usecase.dart';
import 'package:domain/usecase/payment/get_purpose_usecase.dart';
import 'package:domain/usecase/payment/get_rejection_reason_usecase.dart';
import 'package:domain/usecase/payment/pay_back_credit_card_usecase.dart';
import 'package:domain/usecase/payment/qr_scan_otp_usecase.dart';
import 'package:domain/usecase/payment/request_amount_from_contact_usecase.dart';
import 'package:domain/usecase/payment/request_from_new_recipient_usecase.dart';
import 'package:domain/usecase/payment/request_money_failure_usecase.dart';
import 'package:domain/usecase/payment/request_money_from_contact_success_usecase.dart';
import 'package:domain/usecase/payment/request_money_usecase.dart';
import 'package:domain/usecase/payment/send_amount_to_contact_success_usecase.dart';
import 'package:domain/usecase/payment/send_amount_to_contact_usecase.dart';
import 'package:domain/usecase/payment/send_money_failure_usecase.dart';
import 'package:domain/usecase/payment/send_money_usecase.dart';
import 'package:domain/usecase/payment/send_to_new_recipient_usecase.dart';
import 'package:domain/usecase/payment/transfer_qr_usecase.dart';
import 'package:domain/usecase/payment/transfer_usecase.dart';
import 'package:domain/usecase/payment/transfer_verify_usecase.dart';
import 'package:domain/usecase/payment/verify_qr_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[<AddSendMoneyContactUseCase>] provider
final addSendMoneyContactUseCaseProvider = Provider.autoDispose<AddSendMoneyContactUseCase>(
  (ref) => AddSendMoneyContactUseCase(),
);

///[GetBeneficiaryUseCase] provider
final getBeneficiaryUseCaseProvider = Provider.autoDispose<GetBeneficiaryUseCase>(
  (ref) => GetBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[<GetAccountByAliasUseCase>] provider
final getAccountByAliasUseCaseProvider = Provider.autoDispose<GetAccountByAliasUseCase>(
  (ref) => GetAccountByAliasUseCase(ref.read(paymentRepositoryProvider)),
);

///[<SendAmountToContactUseCase>] provider
final sendAmountToContactUseCaseProvider = Provider.autoDispose<SendAmountToContactUseCase>(
  (ref) => SendAmountToContactUseCase(),
);

///[<SendAmountToContactSuccessUseCase>] provider
final sendAmountToContactSuccessUseCaseProvider = Provider.autoDispose<SendAmountToContactSuccessUseCase>(
  (ref) => SendAmountToContactSuccessUseCase(),
);

///[<RequestAmountFromContactUseCase>] provider
final requestAmountFromContactUseCaseProvider = Provider.autoDispose<RequestAmountFromContactUseCase>(
  (ref) => RequestAmountFromContactUseCase(ref.read(paymentRepositoryProvider)),
);

///[<RequestAmountFromContactSuccessUseCase>] provider
final requestAmountFromContactSuccessUseCaseProvider =
    Provider.autoDispose<RequestAmountFromContactSuccessUseCase>(
  (ref) => RequestAmountFromContactSuccessUseCase(),
);

///[<RequestMoneyFailureUseCase>] provider
final requestMoneyFailureUseCaseProvider = Provider.autoDispose<RequestMoneyFailureUseCase>(
  (ref) => RequestMoneyFailureUseCase(),
);

///[<SendMoneyFailureUseCase>] provider
final sendMoneyFailureUseCaseProvider = Provider.autoDispose<SendMoneyFailureUseCase>(
  (ref) => SendMoneyFailureUseCase(),
);

///[<SendMoneyUseCase>] provider
final sendMoneyUseCaseProvider = Provider.autoDispose<SendMoneyUseCase>(
  (ref) => SendMoneyUseCase(),
);

///[<SendMoneyUseCase>] provider
final sendToNewRecipientUseCaseProvider = Provider.autoDispose<SendToNewRecipientUseCase>(
  (ref) => SendToNewRecipientUseCase(),
);

///[<RequestFromNewRecipientUseCase>] provider
final requestFromNewRecipientUseCaseProvider = Provider.autoDispose<RequestFromNewRecipientUseCase>(
  (ref) => RequestFromNewRecipientUseCase(ref.read(paymentRepositoryProvider)),
);

///[<EnterOtpUseCase>] provider
final enterOtpUseCaseProvider = Provider.autoDispose<EnterOtpUseCase>(
  (ref) => EnterOtpUseCase(),
);

///[<EnterRequestOtpUseCase>] provider
final enterRequestOtpUseCaseProvider = Provider.autoDispose<EnterRequestOtpUseCase>(
  (ref) => EnterRequestOtpUseCase(),
);

///[<RequestMoneyUseCase>] provider
final requestMoneyUseCaseProvider = Provider.autoDispose<RequestMoneyUseCase>(
  (ref) => RequestMoneyUseCase(),
);

///[CheckSendMoneyUseCase] provider
final checkSendMoneyUseCaseProvider = Provider.autoDispose<CheckSendMoneyUseCase>(
  (ref) => CheckSendMoneyUseCase(ref.read(paymentRepositoryProvider)),
);

///[TransferUseCase] provider
final transferUseCaseProvider = Provider.autoDispose<TransferUseCase>(
  (ref) => TransferUseCase(ref.read(paymentRepositoryProvider)),
);

///[TransferVerifyUseCase] provider
final transferVerifyUseCaseProvider = Provider.autoDispose<TransferVerifyUseCase>(
  (ref) => TransferVerifyUseCase(ref.read(paymentRepositoryProvider)),
);

///[GetPurposeUseCase] provider
final getPurposeUseCaseProvider = Provider.autoDispose<GetPurposeUseCase>(
  (ref) => GetPurposeUseCase(ref.read(paymentRepositoryProvider)),
);

///[PayBackCreditCardUseCase] provider
final payBackCreditCardUseCaseProvider = Provider.autoDispose<PayBackCreditCardUseCase>(
  (ref) => PayBackCreditCardUseCase(ref.read(paymentRepositoryProvider)),
);

final createDynamicLinkUseCaseProvider = Provider.autoDispose<CreateDynamicLinkUseCase>(
  (ref) => CreateDynamicLinkUseCase(ref.read(dynamicLinkRepositoryProvider)),
);

final initDynamicLinkUseCaseProvider = Provider.autoDispose<InitDynamicLinkUseCase>(
  (ref) => InitDynamicLinkUseCase(ref.read(dynamicLinkRepositoryProvider)),
);

///[GenerateQRUseCase] provider
final generateQRUseCaseProvider = Provider.autoDispose<GenerateQRUseCase>(
  (ref) => GenerateQRUseCase(ref.read(paymentRepositoryProvider)),
);

///[TransferQRUseCase] provider
final transferQRUseCaseProvider = Provider.autoDispose<TransferQRUseCase>(
  (ref) => TransferQRUseCase(ref.read(paymentRepositoryProvider)),
);

///[QRScanOTPUseCase] provider
final qrScanOTPUseCaseProvider =
    Provider.autoDispose<QRScanOTPUseCase>((ref) => QRScanOTPUseCase(ref.read(paymentRepositoryProvider)));

///[VerifyQRUseCase] provider
final verifyQRUseCaseProvider = Provider.autoDispose<VerifyQRUseCase>(
  (ref) => VerifyQRUseCase(ref.read(paymentRepositoryProvider)),
);

final getReasonToReturUseCaseProvider = Provider.autoDispose<GetRejectionReasonUseCase>(
    (ref) => GetRejectionReasonUseCase(ref.read(paymentRepositoryProvider)));

final returnPaymentTransactoinUseCaseProvider =
    Provider.autoDispose<ReturnPaymentTransactionUsecase>((ref) => ReturnPaymentTransactionUsecase());

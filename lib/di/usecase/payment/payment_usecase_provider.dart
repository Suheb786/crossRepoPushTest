import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/payment/add_request_money_contact_usecase.dart';
import 'package:domain/usecase/payment/add_send_money_contact_usecase.dart';
import 'package:domain/usecase/payment/enter_otp_usecase.dart';
import 'package:domain/usecase/payment/enter_request_otp_usecase.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[<AddSendMoneyContactUseCase>] provider
final addSendMoneyContactUseCaseProvider =
Provider.autoDispose<AddSendMoneyContactUseCase>(
      (ref) => AddSendMoneyContactUseCase(),
);

///[<AddRequestMoneyContactUseCase>] provider
final addRequestMoneyContactUseCaseProvider =
Provider.autoDispose<AddRequestMoneyContactUseCase>(
      (ref) =>
      AddRequestMoneyContactUseCase(ref.read(manageContactRepositoryProvider)),
);

///[<SendAmountToContactUseCase>] provider
final sendAmountToContactUseCaseProvider =
Provider.autoDispose<SendAmountToContactUseCase>(
      (ref) => SendAmountToContactUseCase(),
);

///[<SendAmountToContactSuccessUseCase>] provider
final sendAmountToContactSuccessUseCaseProvider =
Provider.autoDispose<SendAmountToContactSuccessUseCase>(
      (ref) => SendAmountToContactSuccessUseCase(),
);

///[<RequestAmountFromContactUseCase>] provider
final requestAmountFromContactUseCaseProvider =
Provider.autoDispose<RequestAmountFromContactUseCase>(
      (ref) => RequestAmountFromContactUseCase(),
);

///[<RequestAmountFromContactSuccessUseCase>] provider
final requestAmountFromContactSuccessUseCaseProvider =
Provider.autoDispose<RequestAmountFromContactSuccessUseCase>(
      (ref) => RequestAmountFromContactSuccessUseCase(),
);

///[<RequestMoneyFailureUseCase>] provider
final requestMoneyFailureUseCaseProvider =
Provider.autoDispose<RequestMoneyFailureUseCase>(
      (ref) => RequestMoneyFailureUseCase(),
);

///[<SendMoneyFailureUseCase>] provider
final sendMoneyFailureUseCaseProvider =
Provider.autoDispose<SendMoneyFailureUseCase>(
      (ref) => SendMoneyFailureUseCase(),
);

///[<SendMoneyUseCase>] provider
final sendMoneyUseCaseProvider = Provider.autoDispose<SendMoneyUseCase>(
      (ref) => SendMoneyUseCase(),
);

///[<SendMoneyUseCase>] provider
final sendToNewRecipientUseCaseProvider =
Provider.autoDispose<SendToNewRecipientUseCase>(
      (ref) => SendToNewRecipientUseCase(),
);

///[<RequestFromNewRecipientUseCase>] provider
final requestFromNewRecipientUseCaseProvider =
Provider.autoDispose<RequestFromNewRecipientUseCase>(
      (ref) => RequestFromNewRecipientUseCase(),
);

///[<EnterOtpUseCase>] provider
final enterOtpUseCaseProvider = Provider.autoDispose<EnterOtpUseCase>(
      (ref) => EnterOtpUseCase(),
);

///[<EnterRequestOtpUseCase>] provider
final enterRequestOtpUseCaseProvider =
Provider.autoDispose<EnterRequestOtpUseCase>(
      (ref) => EnterRequestOtpUseCase(),
);

///[<RequestMoneyUseCase>] provider
final requestMoneyUseCaseProvider = Provider.autoDispose<RequestMoneyUseCase>(
      (ref) => RequestMoneyUseCase(),
);

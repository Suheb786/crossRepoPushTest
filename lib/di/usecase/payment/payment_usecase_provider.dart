import 'package:domain/usecase/payment/add_request_money_contact_usecase.dart';
import 'package:domain/usecase/payment/add_send_money_contact_usecase.dart';
import 'package:domain/usecase/payment/send_amount_to_contact_success_usecase.dart';
import 'package:domain/usecase/payment/send_amount_to_contact_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[<AddSendMoneyContactUseCase>] provider
final addSendMoneyContactUseCaseProvider =
    Provider.autoDispose<AddSendMoneyContactUseCase>(
  (ref) => AddSendMoneyContactUseCase(),
);

///[<AddRequestMoneyContactUseCase>] provider
final addRequestMoneyContactUseCaseProvider =
    Provider.autoDispose<AddRequestMoneyContactUseCase>(
  (ref) => AddRequestMoneyContactUseCase(),
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

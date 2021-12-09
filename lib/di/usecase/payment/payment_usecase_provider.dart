import 'package:domain/usecase/payment/add_request_money_contact_usecase.dart';
import 'package:domain/usecase/payment/add_send_money_contact_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[<AddSendMoneyContactUseCaseProvider>] provider
final addSendMoneyContactUseCaseProvider =
    Provider.autoDispose<AddSendMoneyContactUseCase>(
  (ref) => AddSendMoneyContactUseCase(),
);

///[<AddRequestMoneyContactUseCaseProvider>] provider
final addRequestMoneyContactUseCaseProvider =
    Provider.autoDispose<AddRequestMoneyContactUseCase>(
  (ref) => AddRequestMoneyContactUseCase(),
);

import 'package:domain/usecase/payment/add_send_money_contact_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[<AddSendMoneyContactUseCaseProvider>] provider
final addSendMoneyContactUseCaseProvider =
    Provider.autoDispose<AddSendMoneyContactUseCase>(
  (ref) => AddSendMoneyContactUseCase(),
);

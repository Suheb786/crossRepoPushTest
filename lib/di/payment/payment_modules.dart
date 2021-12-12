import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_view_model.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_view_model.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_view_model.dart';

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

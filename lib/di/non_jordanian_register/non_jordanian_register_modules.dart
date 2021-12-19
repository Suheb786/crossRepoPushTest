import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/notify/notify_usecase_provider.dart';
import 'package:neo_bank/feature/non_jordanian_register/non_jordanian_register_page_view_model.dart';
import 'package:neo_bank/feature/non_jordanian_register/notify/notify_page_view_model.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page_view_model.dart';

///non jordanian account registration view model provider
final nonJordanianRegistrationViewModelProvider =
    ChangeNotifierProvider.autoDispose<NonJordanianRegisterPageViewModel>(
  (ref) => NonJordanianRegisterPageViewModel(),
);

///notify view model provider
final notifyViewModelProvider =
    ChangeNotifierProvider.autoDispose<NotifyPageViewModel>(
  (ref) => NotifyPageViewModel(ref.read(notifyUseCaseProvider)),
);

///notify success view model provider
final notifySuccessViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<NotifySuccessPageViewModel, NotifySuccessArguments>(
      (ref, args) => NotifySuccessPageViewModel(args),
);

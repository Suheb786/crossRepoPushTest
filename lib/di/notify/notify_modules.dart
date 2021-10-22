import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/notify/notify_usecase_provider.dart';
import 'package:neo_bank/feature/register/stepone/notify/notify_page_view_model.dart';
import 'package:neo_bank/feature/register/stepone/notify_success/notify_success_page_view_model.dart';

///notify view model provider
final notifyViewModelProvider =
    ChangeNotifierProvider.autoDispose<NotifyPageViewModel>(
  (ref) => NotifyPageViewModel(ref.read(notifyUseCaseProvider)),
);

///notify success view model provider
final notifySuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<NotifySuccessPageViewModel>(
  (ref) => NotifySuccessPageViewModel(),
);

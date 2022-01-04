import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/help_center/active_call/active_call_page_view_model.dart';
import 'package:neo_bank/feature/help_center/call_ended/call_ended_page_view_model.dart';
import 'package:neo_bank/feature/help_center/help_center_page_view_model.dart';

final helpCenterViewModelProvider =
    ChangeNotifierProvider.autoDispose<HelpCenterPageViewModel>(
  (ref) => HelpCenterPageViewModel(),
);

final activeCallPageViewModelProvider =
ChangeNotifierProvider.autoDispose<ActiveCallPageViewModel>(
        (ref) => ActiveCallPageViewModel(),
);

final callEndedPageViewModelProvider =
ChangeNotifierProvider.autoDispose<CallEndedPageViewModel>(
        (ref) => CallEndedPageViewModel(),
);

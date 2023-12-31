import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/help_center/help_center_usecase_provider.dart';
import 'package:neo_bank/feature/help_center/active_call/active_call_page_view_model.dart';
import 'package:neo_bank/feature/help_center/call_ended/call_ended_page_view_model.dart';
import 'package:neo_bank/feature/help_center/help_center_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagement_team_dialog_view_model.dart';

import '../../feature/help_center/error_screen/help_center_error_page_view_model.dart';

final helpCenterViewModelProvider = ChangeNotifierProvider.autoDispose<HelpCenterPageViewModel>(
  (ref) => HelpCenterPageViewModel(
      ref.read(infobipAudioPluginUseCaseProvider),
      ref.read(obtainTokenUseCaseProvider),
      ref.read(establishCallUseCaseProvider),
      ref.read(hangupCallUseCaseProvider)),
);

final helpCenterErrorViewModelProvider = ChangeNotifierProvider.autoDispose<HelpCenterErrorPageViewModel>(
  (ref) => HelpCenterErrorPageViewModel(),
);

final activeCallPageViewModelProvider = ChangeNotifierProvider.autoDispose<ActiveCallPageViewModel>(
  (ref) => ActiveCallPageViewModel(ref.read(muteUnMuteUseCaseProvider), ref.read(speakerOnOffUseCaseProvider),
      ref.read(hangupCallUseCaseProvider), ref.read(infobipAudioPluginUseCaseProvider)),
);

final callEndedPageViewModelProvider = ChangeNotifierProvider.autoDispose<CallEndedPageViewModel>(
  (ref) => CallEndedPageViewModel(ref.read(callDurationUseCaseProvider)),
);

///get purpose of account opening dialog view model provider
final engagementTeamDialogViewModelProvider = ChangeNotifierProvider<EngagementTeamDialogViewModel>(
    (ref) => EngagementTeamDialogViewModel(ref.read(showChatUseCaseProvider)));

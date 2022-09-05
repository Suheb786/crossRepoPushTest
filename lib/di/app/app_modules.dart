import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/app_flyer/app_flyer_usecase-provider.dart';
import 'package:neo_bank/di/usecase/help_center/help_center_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/main/app_viewmodel.dart';

ChangeNotifierProvider<AppViewModel> appViewModel = ChangeNotifierProvider<AppViewModel>(
  (ref) => AppViewModel(ref.read(getTokenUseCaseProvider), ref.read(infobipMessagePluginUseCaseProvider),
      ref.read(saveUserUseCaseProvider), ref.read(initiAppFlyerSDKProvider)),
);

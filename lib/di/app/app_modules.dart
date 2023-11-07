import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/app_flyer/app_flyer_usecase-provider.dart';
import 'package:neo_bank/main/app_viewmodel.dart';

ChangeNotifierProvider<AppViewModel> appViewModel = ChangeNotifierProvider<AppViewModel>(
  (ref) => AppViewModel(ref.read(initiAppFlyerSDKProvider), ref.read(logAppFlyerEventUseCaseProvider)),
);

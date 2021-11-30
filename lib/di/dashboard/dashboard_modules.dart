import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog_view_model.dart';

final dashboardViewModelProvider =
    ChangeNotifierProvider.autoDispose<DashboardPageViewModel>(
  (ref) => DashboardPageViewModel(ref.read(logoutUseCaseProvider)),
);

final biometricLoginViewModelProvider =
    ChangeNotifierProvider.autoDispose<BiometricLoginDialogViewModel>(
  (ref) => BiometricLoginDialogViewModel(),
);

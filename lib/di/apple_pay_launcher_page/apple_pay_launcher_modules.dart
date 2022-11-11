import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/apple_pay_luncher_screen/apple_pay_launcher_page_view_model.dart';

final applePayLauncherPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<ApplePayLauncherPageViewModel>(
  (ref) => ApplePayLauncherPageViewModel(),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/kyc/kyc_usecase_provider.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';

final loginViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>(
  (ref) => LoginViewModel(
      ref.read(loginUseCaseProvider),
      ref.read(checkKycStatusUseCaseProvider),
      ref.read(getCipherUseCaseProvider)),
);

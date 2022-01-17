import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/forget_password/forget_password_usecase_provider.dart';
import 'package:neo_bank/di/usecase/forgot_password/forgot_password_usecase_provider.dart';
import 'package:neo_bank/feature/forgot_password/add_id_number_for_reset_password/add_id_number_for_reset_password_page_view_model.dart';
import 'package:neo_bank/feature/forgot_password/create_new_password/create_new_password_page_view_model.dart';
import 'package:neo_bank/feature/forgot_password/enter_otp_for_reset_password/enter_otp_for_reset_password_page_view_model.dart';
import 'package:neo_bank/feature/forgot_password/forgot_password_page_view_model.dart';
import 'package:neo_bank/feature/forgot_password/reset_password_success/reset_password_success_view_model.dart';

final forgotPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<ForgotPasswordPageViewModel>(
        (ref) => ForgotPasswordPageViewModel());

final resetPasswordSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<ResetPasswordSuccessViewModel>(
        (ref) => ResetPasswordSuccessViewModel());

final addIdNumberForResetPasswordViewModelProvider = ChangeNotifierProvider
    .autoDispose<AddIDNumberForResetPasswordPageViewModel>((ref) =>
        AddIDNumberForResetPasswordPageViewModel(
            ref.read(checkForgetPasswordUseCaseProvider)));

final enterOtpForResetPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<EnterOTPForResetPasswordPageViewModel>(
        (ref) => EnterOTPForResetPasswordPageViewModel(
            ref.read(enterOtpForResetPasswordUseCaseProvider)));

final createNewPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<CreateNewPasswordPageViewModel>((ref) =>
        CreateNewPasswordPageViewModel(
            ref.read(createNewPasswordUseCaseProvider)));

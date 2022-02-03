import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/device_change/device_change_usecase.dart';
import 'package:neo_bank/di/usecase/kyc/kyc_usecase_provider.dart';
import 'package:neo_bank/feature/change_device_flow/change_device_success/change_device_success_page_view_model.dart';
import 'package:neo_bank/feature/change_device_flow/otp_for_change_device/otp_for_change_device_confirmation_page_view_model.dart';

final otpForChangeDeviceViewModelProvider = ChangeNotifierProvider.autoDispose<
        OtpForChangeDeviceConfirmationPageViewModel>(
    (ref) => OtpForChangeDeviceConfirmationPageViewModel(
        ref.read(verifyDeviceChangeOtpUseCaseProvider),
        ref.read(resendOtpDeviceChangeUseCaseProvider)));

final changeDeviceSuccessViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangeDeviceSuccessPageViewModel>(
        (ref) => ChangeDeviceSuccessPageViewModel(
            ref.read(checkKycStatusUseCaseProvider)));

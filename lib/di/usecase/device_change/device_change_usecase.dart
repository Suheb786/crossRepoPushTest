import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/device_change/resend_otp_device_change_usecase.dart';
import 'package:domain/usecase/device_change/send_otp_token_device_change_usecase.dart';
import 'package:domain/usecase/device_change/send_otp_token_email_usecase.dart';
import 'package:domain/usecase/device_change/verify_device_change_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[ResendOtpDeviceChangeUseCase] provider
final resendOtpDeviceChangeUseCaseProvider = Provider.autoDispose<ResendOtpDeviceChangeUseCase>(
  (ref) => ResendOtpDeviceChangeUseCase(ref.read(deviceChangeRepositoryProvider)),
);

///[SendOtpTokenEmailOtpUseCase] provider
final sendOtpTokenEmailOtpUseCaseProvider = Provider.autoDispose<SendOtpTokenEmailOtpUseCase>(
  (ref) => SendOtpTokenEmailOtpUseCase(ref.read(deviceChangeRepositoryProvider)),
);

///[SendOtpTokeDeviceChangeOtpUseCase] provider
final sendOtpTokenDeviceChangeUseCaseProvider = Provider.autoDispose<SendOtpTokeDeviceChangeOtpUseCase>(
  (ref) => SendOtpTokeDeviceChangeOtpUseCase(ref.read(deviceChangeRepositoryProvider)),
);

///[VerifyDeviceChangeOtpUseCase] provider
final verifyDeviceChangeOtpUseCaseProvider = Provider.autoDispose<VerifyDeviceChangeOtpUseCase>(
  (ref) => VerifyDeviceChangeOtpUseCase(ref.read(deviceChangeRepositoryProvider)),
);

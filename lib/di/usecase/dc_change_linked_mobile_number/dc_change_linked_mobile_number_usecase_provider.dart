import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_new_mobile_number_usecase.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[DcEnterNewMobileNumberUseCase] provider
final dcEnterNewMobileNumberUseCaseProvider =
    Provider.autoDispose<DcEnterNewMobileNumberUseCase>(
  (ref) => DcEnterNewMobileNumberUseCase(),
);

///[DcEnterOtpUseCase] provider
final dcEnterOtpUseCaseProvider = Provider.autoDispose<DcEnterOtpUseCase>(
  (ref) => DcEnterOtpUseCase(),
);

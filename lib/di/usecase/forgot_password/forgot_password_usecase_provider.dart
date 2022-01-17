import 'package:domain/usecase/forgot_password/add_id_number_for_reset_password_usecase.dart';
import 'package:domain/usecase/forgot_password/create_new_password_usecase.dart';
import 'package:domain/usecase/forgot_password/enter_otp_for_reset_password_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[AddIdNumberForResetPasswordUseCase] provider
final addIdNoForResetPasswordUseCaseProvider =
    Provider.autoDispose<AddIdNumberForResetPasswordUseCase>(
  (ref) => AddIdNumberForResetPasswordUseCase(),
);

///[EnterOtpForResetPasswordUseCase] provider
final enterOtpForResetPasswordUseCaseProvider =
    Provider.autoDispose<EnterOtpForResetPasswordUseCase>(
  (ref) => EnterOtpForResetPasswordUseCase(),
);

///[CreateNewPasswordUseCase] provider
final createNewPasswordUseCaseProvider =
    Provider.autoDispose<CreateNewPasswordUseCase>(
  (ref) => CreateNewPasswordUseCase(),
);

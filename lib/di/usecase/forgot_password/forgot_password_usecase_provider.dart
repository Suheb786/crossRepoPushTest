import 'package:domain/usecase/forgot_password/add_id_number_for_reset_password_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[AddIdNumberForResetPasswordUseCase] provider
final addIdNoForResetPasswordUseCaseProvider =
    Provider.autoDispose<AddIdNumberForResetPasswordUseCase>(
  (ref) => AddIdNumberForResetPasswordUseCase(),
);

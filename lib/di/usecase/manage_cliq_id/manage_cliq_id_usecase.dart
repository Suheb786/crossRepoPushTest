import 'package:domain/usecase/manage_cliq/cliq_id_type_selection_usecase.dart';
import 'package:domain/usecase/manage_cliq/enter_otp_for_cliq_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[CliqIdTypeSelectionUseCase] provider
final cliqIdTypSelectioneUseCaseProvider =
    Provider.autoDispose<CliqIdTypeSelectionUseCase>(
  (ref) => CliqIdTypeSelectionUseCase(),
);

///[EnterOtpForCliqIdUseCase] provider
final enterOtpForCliqIdUseCaseProvider =
    Provider.autoDispose<EnterOtpForCliqIdUseCase>(
  (ref) => EnterOtpForCliqIdUseCase(),
);

import 'package:domain/usecase/manage_cliq/cliq_id_type_selection_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[CliqIdTypeSelectionUseCase] provider
final cliqIdTypSelectioneUseCaseProvider =
    Provider.autoDispose<CliqIdTypeSelectionUseCase>(
  (ref) => CliqIdTypeSelectionUseCase(),
);

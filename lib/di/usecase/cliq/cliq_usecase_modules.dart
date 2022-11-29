import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/edit_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/suspend_cliq_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[EditCliqIdUseCase] provider
final EditCliqIdUseCaseProvider = Provider.autoDispose<EditCliqIdUseCase>(
  (ref) => EditCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[DeleteCliqIdUseCase] provider
final deleteCliqIdUseCaseProvider = Provider.autoDispose<DeleteCliqIdUseCase>(
  (ref) => DeleteCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[ReActivateCliqIdUseCase] provider
final reActivateCliqIdUseCaseProvider = Provider.autoDispose<ReActivateCliqIdUseCase>(
  (ref) => ReActivateCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[suspendCliqIdUseCase] provider
final SuspendCliqIdUseCaseProvider = Provider.autoDispose<SuspendCliqIdUseCase>(
  (ref) => SuspendCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/sub_account/add_account_usecase.dart';
import 'package:domain/usecase/sub_account/deactivate_sub_account_usecase.dart';
import 'package:domain/usecase/sub_account/update_nick_name_sub_account_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[Deactivate-SubAccount-UseCase] provider
final deactivateSubAccountUseCase = Provider.autoDispose<DeactivateSubAccountUseCase>(
  (ref) => DeactivateSubAccountUseCase(ref.read(subAccountRepository)),
);

///[Update-Nick-Name-UseCase] provider
final updateNickNameSubAccountUseCase = Provider.autoDispose<UpdateNickNameSubAccountUseCase>(
  (ref) => UpdateNickNameSubAccountUseCase(ref.read(subAccountRepository)),
);

///[Add-Sub-Account-UseCase] provider
final addSubAccountUseCaseProvider = Provider.autoDispose<AddSubAccountUseCase>(
  (ref) => AddSubAccountUseCase(ref.read(subAccountRepository)),
);

import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/account/check_other_nationality_status_usecase.dart';
import 'package:domain/usecase/account/check_videocall_status_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[CheckVideoCallStatusUseCase] provider
final checkVideoCallStatusUseCaseProvider =
    Provider.autoDispose<CheckVideoCallStatusUseCase>((ref) =>
        CheckVideoCallStatusUseCase(ref.read(accountRepositoryProvider)));

///[CheckOtherNationalityStatusUseCase] provider
final checkOtherNationalityStatusUseCaseProvider =
    Provider.autoDispose<CheckOtherNationalityStatusUseCase>((ref) =>
        CheckOtherNationalityStatusUseCase(
            ref.read(accountRepositoryProvider)));

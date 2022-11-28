import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/id_card/get_ahwal_details_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GetAhwalDetailsUseCase] provider
final getAhwalDetailsUseCaseProvider = Provider.autoDispose<GetAhwalDetailsUseCase>(
    (ref) => GetAhwalDetailsUseCase(ref.read(idCardRepositoryProvider)));

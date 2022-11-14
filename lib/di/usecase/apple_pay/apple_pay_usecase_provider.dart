import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/apple_pay/add_user_wallet_detail_usecase.dart';
import 'package:domain/usecase/apple_pay/clear_wallet_id_usecase.dart';
import 'package:domain/usecase/apple_pay/enroll_card_usecase.dart';
import 'package:domain/usecase/apple_pay/get_all_card_list_usecase.dart';
import 'package:domain/usecase/apple_pay/get_user_wallet_detail_usecase.dart';
import 'package:domain/usecase/apple_pay/initialize_antelop_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[AddUserWalletDetailUseCase] provider
final addUserWalletDetailUseCaseProvider = Provider.autoDispose<AddUserWalletDetailUseCase>(
    (ref) => AddUserWalletDetailUseCase(ref.read(applePayRepositoryProvider)));

///[EnrollCardUseCase] provider
final enrollCardUseCaseProvider =
    Provider.autoDispose<EnrollCardUseCase>((ref) => EnrollCardUseCase(ref.read(applePayRepositoryProvider)));

///[GetAllCardListUseCase] provider
final getAllCardListUseCaseProvider = Provider.autoDispose<GetAllCardListUseCase>(
    (ref) => GetAllCardListUseCase(ref.read(applePayRepositoryProvider)));

///[GetUserWalletDetailUseCase] provider
final getUserWalletDetailUseCaseProvider = Provider.autoDispose<GetUserWalletDetailUseCase>(
    (ref) => GetUserWalletDetailUseCase(ref.read(applePayRepositoryProvider)));

///[InitializeAntelopUseCase] provider
final initializeAntelopSDKUseCaseProvider = Provider.autoDispose<InitializeAntelopUseCase>(
    (ref) => InitializeAntelopUseCase(ref.read(applePayRepositoryProvider)));

///[ClearWalletIdUseCase] provider
final clearWalletIdUseCaseProvider =
    Provider.autoDispose<ClearWalletIdUseCase>((ref) => ClearWalletIdUseCase(ref.read(userRepoProvider)));

import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/bank_smart/create_account_usecase.dart';
import 'package:domain/usecase/bank_smart/get_account_details_usecase.dart';
import 'package:domain/usecase/bank_smart/get_account_usecase.dart';
import 'package:domain/usecase/bank_smart/purpose_of_account_opening_usecase.dart';
import 'package:domain/usecase/bank_smart/remove_debit_lock_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[PurposeOfAccountOpeningUseCase] provider
final purposeOfAccountsOpeningUseCaseProvider =
    Provider.autoDispose<PurposeOfAccountOpeningUseCase>((ref) =>
        PurposeOfAccountOpeningUseCase(ref.read(bankSmartRepositoryProvider)));

///[GetAccountUseCase] provider
final getAccountUseCaseProvider = Provider.autoDispose<GetAccountUseCase>(
        (ref) => GetAccountUseCase(ref.read(bankSmartRepositoryProvider)));

///[GetAccountDetailsUseCase] provider
final getAccountDetailsUseCaseProvider =
Provider.autoDispose<GetAccountDetailsUseCase>((ref) =>
    GetAccountDetailsUseCase(ref.read(bankSmartRepositoryProvider)));

///[CreateAccountUseCase] provider
final createAccountUseCaseProvider = Provider.autoDispose<CreateAccountUseCase>(
        (ref) => CreateAccountUseCase(ref.read(bankSmartRepositoryProvider)));

///[RemoveDebitLockUseCase] provider
final removeDebitLockUseCaseProvider =
Provider.autoDispose<RemoveDebitLockUseCase>(
        (ref) => RemoveDebitLockUseCase(ref.read(bankSmartRepositoryProvider)));

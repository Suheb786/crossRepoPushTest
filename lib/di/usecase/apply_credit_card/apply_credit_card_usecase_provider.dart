import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/apply_credit_card/process_loan_step_usecase.dart';
import 'package:domain/usecase/apply_credit_card/set_credit_limit_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setCreditLimitUseCaseProvider = Provider.autoDispose<SetCreditLimitUseCase>(
    (ref) => SetCreditLimitUseCase(ref.read(cardRepositoryProvider)));

final processLoanStepUseCaseProvider = Provider.autoDispose<ProcessLoanStepUseCase>(
    (ref) => ProcessLoanStepUseCase(ref.read(cardRepositoryProvider)));

import 'package:domain/usecase/apply_credit_card/set_credit_limit_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setCreditLimitUseCaseProvider =
    Provider.autoDispose<SetCreditLimitUseCase>(
        (ref) => SetCreditLimitUseCase());

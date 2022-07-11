import 'package:domain/usecase/evouchers/select_account_usecase.dart';
import 'package:domain/usecase/evouchers/select_region_amount_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[SelectRegionAmountUseCase] provider
final selectRegionAmountUseCaseProvider = Provider.autoDispose<SelectRegionAmountUseCase>(
  (ref) => SelectRegionAmountUseCase(),
);

///[SelectAccountUseCase] provider
final selectAccountUseCaseProvider = Provider.autoDispose<SelectAccountUseCase>(
  (ref) => SelectAccountUseCase(),
);

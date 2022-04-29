import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_new_mobile_number_usecase.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_otp_usecase.dart';
import 'package:domain/usecase/update_settlement/update_settlement_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[DcEnterNewMobileNumberUseCase] provider
final dcEnterNewMobileNumberUseCaseProvider =
    Provider.autoDispose<DcEnterNewMobileNumberUseCase>(
  (ref) => DcEnterNewMobileNumberUseCase(ref.read(cardRepositoryProvider)),
);

///[DcEnterOtpUseCase] provider
final dcEnterOtpUseCaseProvider = Provider.autoDispose<DcEnterOtpUseCase>(
  (ref) => DcEnterOtpUseCase(ref.read(cardRepositoryProvider)),
);

///[UpdateSettlementUseCase] provider
final updateSettlementUseCaseProvider =
    Provider.autoDispose<UpdateSettlementUseCase>(
  (ref) => UpdateSettlementUseCase(ref.read(cardRepositoryProvider)),
);

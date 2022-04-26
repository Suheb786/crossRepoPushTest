import 'package:domain/usecase/dc_setting_card_delivery/dc_setting_confirm_pin_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[DcSettingConfirmPinUseCase] provider
final dcSettingConfirmPinUseCaseProvider =
    Provider.autoDispose<DcSettingConfirmPinUseCase>(
  (ref) => DcSettingConfirmPinUseCase(),
);

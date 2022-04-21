import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/card_delivery/card_delivery_usecase_provider.dart';
import 'package:neo_bank/di/usecase/dc_setting_card_delivery/dc_setting_card_delivery_module.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_card_delivery_page_view_model.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_confirm_pin/dc_setting_confirm_pin_page_view_model.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_create_pin/dc_setting_create_pin_page_view_model.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_visa_card/dc_setting_visa_card_page_view_model.dart';

///dc setting card delivery view model provider
final dcSettingCardDeliveryViewModelProvider =
    ChangeNotifierProvider.autoDispose<DcSettingCardDeliveryPageViewModel>(
  (ref) => DcSettingCardDeliveryPageViewModel(),
);

///dc setting visa card view model provider
final dcSettingVisaCardViewModelProvider =
    ChangeNotifierProvider.autoDispose<DcSettingVisaCardPageViewModel>(
  (ref) => DcSettingVisaCardPageViewModel(),
);

///dc setting create pin view model provider
final dcSettingCreatePinViewModelProvider =
    ChangeNotifierProvider.autoDispose<DcSettingCreatePinPageViewModel>(
  (ref) => DcSettingCreatePinPageViewModel(ref.read(createPinUseCaseProvider)),
);

///dc setting confirm pin view model provider
final dcSettingConfirmPinViewModelProvider =
    ChangeNotifierProvider.autoDispose<DcSettingConfirmPinPageViewModel>(
  (ref) => DcSettingConfirmPinPageViewModel(
      ref.read(dcSettingConfirmPinUseCaseProvider)),
);

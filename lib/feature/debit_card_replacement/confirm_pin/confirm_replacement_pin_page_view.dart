import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/confirm_pin/confirm_replacement_pin_page_view_model.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ConfirmReplacementPinPageView extends BasePageViewWidget<ConfirmReplacementPinPageViewModel> {
  ConfirmReplacementPinPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
        stream: model.errorDetectorStream,
        initialData: false,
        dataBuilder: (context, isValid) {
          return ShakeAnimatedWidget(
            enabled: isValid ?? false,
            duration: Duration(milliseconds: 100),
            shakeAngle: Rotation.deg(z: 1),
            curve: Curves.easeInOutSine,
            child: AppStreamBuilder<Resource<bool>>(
              stream: model.confirmPinStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  Navigator.pushReplacementNamed(context, RoutePaths.DebitCardReplacementSuccess,
                      arguments: DebitCardReplacementSuccessPageArgs(
                          type: ProviderScope.containerOf(context)
                              .read(debitCardReplacementViewModelProvider)
                              .debitCardReplacementArguments
                              .type));
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (ProviderScope.containerOf(context)
                            .read(debitCardReplacementViewModelProvider)
                            .appSwiperController
                            .page ==
                        2.0) {
                      FocusScope.of(context).unfocus();
                      if (StringUtils.isDirectionRTL(context)) {
                        if (!details.primaryVelocity!.isNegative) {
                          model.validatePin(
                              ProviderScope.containerOf(context)
                                  .read(createReplacementPinViewModelProvider)
                                  .currentPin,
                              ProviderScope.containerOf(context)
                                  .read(replacementVisaCardViewModelProvider)
                                  .cardNumber!);
                        } else {
                          ProviderScope.containerOf(context)
                              .read(debitCardReplacementViewModelProvider)
                              .previousPage();
                          // .previous(animation: true);
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          print(
                              'currentPin--->${ProviderScope.containerOf(context).read(createReplacementPinViewModelProvider).currentPin}');
                          model.validatePin(
                              ProviderScope.containerOf(context)
                                  .read(createReplacementPinViewModelProvider)
                                  .currentPin,
                              ProviderScope.containerOf(context)
                                  .read(replacementVisaCardViewModelProvider)
                                  .cardNumber!);
                        } else {
                          ProviderScope.containerOf(context)
                              .read(debitCardReplacementViewModelProvider)
                              .previousPage();
                          // .previous(animation: true);
                        }
                      }
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: AppOtpFields(
                                  length: 4,
                                  fieldWidth: MediaQuery.of(context).size.width / 6.4,
                                  fieldHeight: 52,
                                  onChanged: (val) {
                                    model.validate(val);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: AppStreamBuilder<bool>(
                                  stream: model.showButtonStream,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return Visibility(
                                      visible: isValid!,
                                      child: AnimatedButton(
                                        buttonHeight: 50,
                                        buttonText: S.of(context).swipeToProceed,
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

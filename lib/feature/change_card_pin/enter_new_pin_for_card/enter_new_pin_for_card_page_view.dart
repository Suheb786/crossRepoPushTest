import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/change_card_pin/enter_new_pin_for_card/enter_new_pin_for_card_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class EnterNewPinForCardPageView
    extends BasePageViewWidget<EnterNewPinForCardPageViewModel> {
  EnterNewPinForCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: AppKeyBoardHide(
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
                  stream: model.changeDebitPinVerifyStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(changeCardPinViewModelProvider)
                          .swiperController
                          .next();
                    }
                  },
                  dataBuilder: (context, snapshot) {
                    return AppStreamBuilder<Resource<bool>>(
                      stream: model.enterNewPinForCardStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.changeDebitPinVerify();
                        } else if (data.status == Status.ERROR) {
                          if (data.appError!.type == ErrorType.EMPTY_PIN) {
                            model.newPinKey.currentState!.isValid = false;
                          } else if (data.appError!.type ==
                              ErrorType.EMPTY_CONFIRM_PIN) {
                            model.confirmPinKey.currentState!.isValid = false;
                          } else if (data.appError!.type ==
                              ErrorType.PIN_NOT_MATCH) {}

                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, isOtpVerified) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity!.isNegative) {
                              model.enterNewPinForCard(
                                  ProviderScope.containerOf(context)
                                      .read(changeCardPinViewModelProvider)
                                      .cardType);
                            }
                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 24),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Column(
                                        children: [
                                          AppTextField(
                                            labelText: S
                                                .of(context)
                                                .newPin
                                                .toUpperCase(),
                                            hintText: S.of(context).pleaseEnter,
                                            inputType: TextInputType.number,
                                            obscureText: true,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  4)
                                            ],
                                            controller: model.newPinController,
                                            key: model.newPinKey,
                                            onChanged: (value) =>
                                                model.validate(),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText: S
                                                .of(context)
                                                .confirmNewPin
                                                .toUpperCase(),
                                            hintText: S.of(context).pleaseEnter,
                                            obscureText: true,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  4)
                                            ],
                                            inputType: TextInputType.number,
                                            controller:
                                                model.confirmPinController,
                                            key: model.confirmPinKey,
                                            onChanged: (value) =>
                                                model.validate(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 16.0, bottom: 24),
                                          child: AppStreamBuilder<bool>(
                                              stream: model.showButtonStream,
                                              initialData: false,
                                              dataBuilder: (context, isValid) {
                                                return Visibility(
                                                  visible: isValid!,
                                                  child: AnimatedButton(
                                                    buttonHeight: 50,
                                                    buttonText: S
                                                        .of(context)
                                                        .swipeToProceed,
                                                  ),
                                                );
                                              }),
                                        ),
                                        Text(
                                          S.of(context).swipeDownToCancel,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.gray),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/add_id_number_for_reset_password/add_id_number_for_reset_password_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';

class AddIDNumberForResetPasswordPageView
    extends BasePageViewWidget<AddIDNumberForResetPasswordPageViewModel> {
  AddIDNumberForResetPasswordPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
              enabled: isError ?? false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: AppStreamBuilder<Resource<CheckForgetPasswordResponse>>(
                stream: model.checkForgetPasswordResponseStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    ProviderScope.containerOf(context)
                        .read(forgotPasswordViewModelProvider)
                        .nationalId = model.nationalIdController.text;
                    ProviderScope.containerOf(context)
                        .read(forgotPasswordViewModelProvider)
                        .email = model.emailController.text;
                    ProviderScope.containerOf(context)
                        .read(forgotPasswordViewModelProvider)
                        .expiryDate = model.idExpiryDateController.text;
                    ProviderScope.containerOf(context)
                        .read(forgotPasswordViewModelProvider)
                        .nextPage();
                    // .next();
                    print("successful");
                  } else if (data.status == Status.ERROR) {
                    model.showToastWithError(data.appError!);
                  }
                },
                dataBuilder: (context, data) {
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        model.addIdNumberForResetPassword();
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: Column(
                                  children: [
                                    AppTextField(
                                      labelText: S.of(context).emailAddress,
                                      hintText: S.of(context).pleaseEnter,
                                      controller: model.emailController,
                                      key: model.emailKey,
                                      inputAction: TextInputAction.go,
                                      inputType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        model.validate();
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    AppTextField(
                                        labelText: S.of(context).nationalId,
                                        hintText: S.of(context).pleaseEnter,
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.done,
                                        controller: model.nationalIdController,
                                        key: model.nationalIdKey,
                                        onChanged: (value) {
                                          model.validate();
                                        }),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).idExpiryDate,
                                      hintText: S.of(context).pleaseEnter,
                                      inputType: TextInputType.text,
                                      inputAction: TextInputAction.done,
                                      readOnly: true,
                                      controller: model.idExpiryDateController,
                                      key: model.idExpiryDateKey,
                                      onChanged: (value) {
                                        model.validate();
                                      },
                                      suffixIcon: (isvalid, value) {
                                        return InkWell(
                                            onTap: () {
                                              DatePicker.show(context,
                                                  initialDate:
                                                      model.initialDate,
                                                  onSelected: (date) {
                                                model.selectedExpiryDate =
                                                    date.toString();
                                                model.initialDate = date;
                                                model.idExpiryDateController
                                                        .text =
                                                    TimeUtils
                                                        .getFormattedDateForCheckPassword(
                                                            date.toString());
                                                model.validate();
                                              }, onCancelled: () {
                                                Navigator.pop(context);
                                              },
                                                  title: S
                                                      .of(context)
                                                      .issuingDate);
                                            },
                                            child: Container(
                                                height: 16,
                                                width: 16,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                                child: AppSvg.asset(
                                                    AssetUtils.calendar,
                                                    color: Theme.of(context)
                                                        .primaryColorDark)));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: AppStreamBuilder<bool>(
                                    stream: model.showButtonStream,
                                    initialData: false,
                                    dataBuilder: (context, isValid) {
                                      return Visibility(
                                        visible: isValid!,
                                        child: AnimatedButton(
                                          buttonText:
                                              S.of(context).swipeToProceed,
                                        ),
                                      );
                                    }),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    S.of(context).backToLogin,
                                    style: TextStyle(
                                      color: AppColor.brightBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}

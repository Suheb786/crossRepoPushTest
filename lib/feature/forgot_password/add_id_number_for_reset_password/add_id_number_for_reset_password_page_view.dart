import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/add_id_number_for_reset_password/add_id_number_for_reset_password_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
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
                    ProviderScope.containerOf(context).read(forgotPasswordViewModelProvider).nationalId =
                        model.nationalIdController.text;
                    ProviderScope.containerOf(context).read(forgotPasswordViewModelProvider).email =
                        model.emailController.text;
                    ProviderScope.containerOf(context).read(forgotPasswordViewModelProvider).expiryDate =
                        TimeUtils.getFormattedDateForCheckPasswordForOnlyEnglish(
                            model.initialDate.toString());
                    ProviderScope.containerOf(context).read(forgotPasswordViewModelProvider).nextPage();
                    // .next();
                  }
                },
                dataBuilder: (context, data) {
                  return Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
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
                                      height: 16.h,
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
                                      height: 16.h,
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
                                              DatePicker.show(context, initialDate: model.initialDate,
                                                  onSelected: (date) {
                                                //   model.selectedExpiryDate = date.toString();

                                                model.selectedExpiryDate = TimeUtils
                                                    .getFormattedDateForCheckPasswordForOnlyEnglish(
                                                        date.toString());

                                                model.initialDate = date;
                                                model.idExpiryDateController.text =
                                                    TimeUtils.getFormattedDateForCheckPassword(
                                                        date.toString());
                                                model.validate();
                                              }, onCancelled: () {
                                                Navigator.pop(context);
                                              }, title: S.of(context).issuingDate);
                                            },
                                            child: Container(
                                                height: 16.h,
                                                width: 16.w,
                                                padding: EdgeInsets.symmetric(horizontal: 7.w),
                                                child: AppSvg.asset(AssetUtils.calendar,
                                                    color: Theme.of(context).primaryColorDark)));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                  child: AppStreamBuilder<bool>(
                                      stream: model.showButtonStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return AppPrimaryButton(
                                          text: S.of(context).next,
                                          isDisabled: !(isValid ?? false),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            model.emailKey.currentState?.isValid = true;
                                            model.nationalIdKey.currentState?.isValid = true;
                                            model.idExpiryDateKey.currentState?.isValid = true;
                                            model.addIdNumberForResetPassword();
                                          },
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
                                        fontFamily: StringUtils.appFont,
                                        color: AppColor.brightBlue,
                                        fontSize: 14.t,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  );
                },
              ),
            );
          }),
    );
  }
}

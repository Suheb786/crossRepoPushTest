import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/add_new_email/add_new_email_address_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';

class AddNewEmailAddressPageView extends BasePageViewWidget<AddNewEmailAddressPageViewModel> {
  AddNewEmailAddressPageView(ProviderBase model) : super(model);

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
              stream: model.addNewEmailAddressStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  ProviderScope.containerOf(context).read(changeEmailAddressViewModelProvider).nextPage();
                  // .next(animation: true);
                  // ProviderScope?.containerOf(context)
                  //         .read(enterOtpForNewEmailAddressViewModelProvider)
                  //         .countDownController =
                  //     CountdownTimerController(
                  //         endTime: ProviderScope?.containerOf(context)
                  //             .read(enterOtpForNewEmailAddressViewModelProvider)
                  //             .endTime);
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
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
                              child: AppTextField(
                                labelText: S.of(context).emailAddress,
                                hintText: S.of(context).pleaseEnter,
                                inputType: TextInputType.text,
                                controller: model.emailController,
                                key: model.changeEmailKey,
                                onChanged: (value) => model.validate(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.0.h),
                            child: AppStreamBuilder<bool>(
                                stream: model.showButtonStream,
                                initialData: false,
                                dataBuilder: (context, isValid) {
                                  return AppPrimaryButton(
                                    text: S.of(context).next,
                                    isDisabled: !isValid!,
                                    onPressed: () {
                                      model.changeEmail();
                                    },
                                  );
                                }),
                          ),
                        ],
                      )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

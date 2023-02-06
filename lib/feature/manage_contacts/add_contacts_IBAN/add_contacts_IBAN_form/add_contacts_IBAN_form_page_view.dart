import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';

import 'add_contacts_IBAN_form_page_view_model.dart';

class AddContactsIBANformPageView extends BasePageViewWidget<AddContactsIBANformPageViewModel> {
  AddContactsIBANformPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<bool>(
        initialData: false,
        stream: model.errorDetectorStream,
        dataBuilder: (context, isError) {
          return ShakeAnimatedWidget(
            enabled: isError ?? false,
            duration: Duration(milliseconds: 100),
            shakeAngle: Rotation.deg(z: 1),
            curve: Curves.easeInOutSine,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                ProviderScope.containerOf(context)
                    .read(addContactIBANViewModelProvider)
                    .appSwiperController
                    .nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeInOutSine,
                    );
                // if (ProviderScope.containerOf(context)
                //         .read(addContactIBANViewModelProvider)
                //         .appSwiperController
                //         .page ==
                //     0.0) {
                //   FocusScope.of(context).unfocus();
                //   // if (StringUtils.isDirectionRTL(context)) {
                //   //   // if (!details.primaryVelocity!.isNegative) {
                //   //   //   model.
                //   //   // }
                //   // }
                // }
              },
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                          ? 0
                          : MediaQuery.of(context).viewInsets.bottom - 48),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AppTextField(
                                labelText: S.current.nameOfBeneficiary.toUpperCase(),
                                hintText: S.current.pleaseEnter,
                                controller: model.nameController,
                                key: model.nameKey,
                              ),
                              SizedBox(height: 16.0.h),
                              AppTextField(
                                labelText: S.current.emailAddress.toUpperCase(),
                                hintText: S.current.pleaseEnter,
                                controller: model.emailController,
                                key: model.emailKey,
                              ),
                              SizedBox(height: 16.0.h),
                              AppTextField(
                                labelText: S.current.ibanORaccountORmobileORalias.toUpperCase(),
                                hintText: 'Please enter',
                                //Todo : + add exclamation icon
                                controller: model.ibanORaccountORmobileORaliasController,
                                key: model.ibanORaccountORmobileORaliasKey,
                              ),
                              SizedBox(height: 16.0.h),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.showStreamButom,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return Visibility(
                                            visible: isValid!,
                                            child: AnimatedButton(
                                              buttonText: "",
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0.h),
                              child: AppStreamBuilder<bool>(
                                  stream: model.showStreamButom,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return Visibility(
                                      visible: isValid!,
                                      child: AnimatedButton(
                                        buttonText: 'Swipe to proceed',
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
                                  'Back to Contact',
                                  style: TextStyle(
                                    color: AppColor.brightBlue,
                                    fontSize: 14.t,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

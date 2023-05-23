import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/payment/number_formatting_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

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
            child: AppStreamBuilder<Resource<bool>>(
                initialData: Resource.none(),
                stream: model.addcontactIBANStream,
                onData: (value) {
                  if (value.status == Status.SUCCESS) {
                    ProviderScope.containerOf(context).read(addContactIBANViewModelProvider).nextPage();
                  } else {}
                },
                dataBuilder: (context, validate) {
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (ProviderScope.containerOf(context)
                              .read(addContactIBANViewModelProvider)
                              .appSwiperController
                              .page ==
                          0.0) {
                        FocusScope.of(context).unfocus();
                        if (StringUtils.isDirectionRTL(context)) {
                          if (!details.primaryVelocity!.isNegative) {
                            model.validationUserInput();
                          } else {
                            ProviderScope.containerOf(context)
                                .read(addContactIBANViewModelProvider)
                                .previousPage();
                          }
                        } else {
                          if (details.primaryVelocity!.isNegative) {
                            model.validationUserInput();
                          } else {
                            ProviderScope.containerOf(context)
                                .read(addContactIBANViewModelProvider)
                                .previousPage();
                          }
                        }
                      }
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
                                        onChanged: (value) {
                                          model.validate(value);
                                        }),
                                    SizedBox(height: 16.0.h),
                                    AppTextField(
                                        labelText: S.current.emailAddress.toUpperCase(),
                                        hintText: S.current.pleaseEnter,
                                        controller: model.emailController,
                                        key: model.emailKey,
                                        onChanged: (value) {
                                          model.validate(value);
                                        }),
                                    SizedBox(height: 16.0.h),
                                    AppTextField(
                                      labelText: S.current.accountMobileNoAlias,
                                      hintText: S.current.pleaseEnter,
                                      controller: model.ibanORaccountORmobileORaliasController,
                                      key: model.ibanORaccountORmobileORaliasKey,
                                      onChanged: (value) {
                                        model.validate(value);
                                      },
                                      labelIcon: () {
                                        return InkWell(
                                          onTap: () {
                                            InformationDialog.show(context,
                                                isSwipeToCancel: false,
                                                title: S.of(context).mobileNoRegisteredWithBlink,
                                                descriptionWidget: Column(
                                                  children: [
                                                    Text(
                                                      S.of(context).samplesOfNoFormatting,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 14.t,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                    NumberFormattingWidget(
                                                      title: S.of(context).iban,
                                                      desc: S.of(context).dummyIBAN,
                                                    ),
                                                    NumberFormattingWidget(
                                                      title: S.of(context).accountNumber,
                                                      desc: S.of(context).dummyAccountNo,
                                                    ),
                                                    NumberFormattingWidget(
                                                      title: S.of(context).mobileNo,
                                                      desc: S.of(context).dummyMobileNo,
                                                    ),
                                                    NumberFormattingWidget(
                                                      title: S.of(context).alias,
                                                      desc: S.of(context).dummyAlias,
                                                    )
                                                  ],
                                                ),
                                                onDismissed: () {}, onSelected: () {
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(start: 5.0.w),
                                            child: Container(
                                                height: 14.h,
                                                width: 14.w,
                                                child: AppSvg.asset(AssetUtils.info,
                                                    color: Theme.of(context)
                                                        .inputDecorationTheme
                                                        .focusedBorder!
                                                        .borderSide
                                                        .color)),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 16.0.h),
                                  ],
                                ),
                              )),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.showButtonSubjectStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return Visibility(
                                            visible: isValid!,
                                            child: AnimatedButton(
                                              borderColor: AppColor.sky_blue_mid,
                                              textColor: AppColor.sky_blue_mid,
                                              buttonText: S.current.swipeToProceed,
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
                                        S.current.backToContact,
                                        style: TextStyle(
                                          color: AppColor.brightBlue,
                                          fontSize: 14.t,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w600,
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
                  );
                }),
          );
        });
  }
}

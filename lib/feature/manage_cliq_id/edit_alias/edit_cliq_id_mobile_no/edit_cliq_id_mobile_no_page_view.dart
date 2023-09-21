import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/otp_for_edit_alias_and_mobile_no/otp_for_edit_alias_mobile_no_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/cliq_term_condition_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';
import 'edit_cliq_id_mobile_no_page_view_model.dart';

class EditCliqIDMobileNoPageView extends BasePageViewWidget<EditCliqIDMobileNoPageViewModel> {
  EditCliqIDMobileNoPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Padding(
      padding: EdgeInsetsDirectional.only(top: 96.0.h, start: 24.w, end: 24.w, bottom: 36.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).editCliqId,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            S.of(context).editYourMobileNo,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 32.h,
          ),
          Expanded(
              child: AppStreamBuilder<bool>(
                  stream: model.errorDetectorStream,
                  initialData: false,
                  dataBuilder: (context, isError) {
                    return ShakeAnimatedWidget(
                      enabled: isError ?? false,
                      duration: Duration(milliseconds: 100),
                      shakeAngle: Rotation.deg(z: 1),
                      curve: Curves.easeInOutSine,
                      child: AppStreamBuilder<Resource<EditCliqOtp>>(
                          initialData: Resource.none(),
                          stream: model.editCliqIdOtpStream,
                          onData: (data) {
                            if (data.status == Status.SUCCESS) {
                              if (data.data != null) {
                                Navigator.pushNamed(context, RoutePaths.OtpForEditAliasAndMobileNoPage,
                                    arguments: OtpForEditAliasAndMobileNoPageArguments(
                                        data: data.data!,
                                        aliasId: model.arguments.aliasID,
                                        aliasValue: model.mobileNoController.text,
                                        isAlias: false,
                                        mobileCode: data.data?.mobileCode ?? '',
                                        mobileNumber: data.data?.mobileNumber ?? ''));
                              }
                            }
                          },
                          dataBuilder: (context, response) {
                            return AppStreamBuilder<Resource<bool>>(
                                initialData: Resource.none(),
                                stream: model.editMobileNoValidationResponseStream,
                                onData: (data) {
                                  if (data.status == Status.SUCCESS) {
                                    ///api call
                                    model.makeOtpRequest(
                                        aliasId: model.arguments.aliasID,
                                        aliasValue: model.mobileNoController.text,
                                        isAlias: false);
                                  }
                                },
                                dataBuilder: (context, isValid) {
                                  return Card(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.only(start: 24.w, top: 32.h, end: 24.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppTextField(
                                                labelText: S.of(context).mobileNumber.toUpperCase(),
                                                hintText: S.of(context).mobileNoAliasHint,
                                                inputType: TextInputType.phone,
                                                inputAction: TextInputAction.done,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(14),
                                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                ],
                                                controller: model.mobileNoController,
                                                key: model.mobileNumberKey,
                                                onChanged: (value) {
                                                  model.showBtn();
                                                },
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Text(
                                                S.of(context).aliasMobileNoHint,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.t,
                                                    color: AppColor.dark_gray_1,
                                                    fontFamily: StringUtils.appFont),
                                              ),
                                              AppStreamBuilder<bool>(
                                                initialData: false,
                                                stream: model.isSelectedStream,
                                                dataBuilder: (BuildContext context, data) {
                                                  return Padding(
                                                    padding: EdgeInsetsDirectional.only(top: 32.h),
                                                    child: CliqTermConditionSelectionWidget(
                                                      subDescription:
                                                          S.of(context).whenAcceptingCreationOfYourCliqId,
                                                      isSelected: data,
                                                      unMarkSelected: () {
                                                        model.termAndConditionSelected(false);
                                                      },
                                                      markSelected: () {
                                                        model.termAndConditionSelected(true);
                                                      },
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            AppStreamBuilder<bool>(
                                              initialData: false,
                                              stream: model.isSelectedStream,
                                              dataBuilder: (BuildContext context, data) {
                                                return AppStreamBuilder<bool>(
                                                  stream: model.showButtonStream,
                                                  initialData: false,
                                                  dataBuilder: (BuildContext context, isValid) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(top: 26.0.h),
                                                      child: AppPrimaryButton(
                                                        text: S.of(context).next,
                                                        isDisabled: (data == true
                                                            ? (isValid == true ? true : false)
                                                            : false),
                                                        onPressed: () {
                                                          model.validate();
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 26.0.h, bottom: 32.h),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    S.of(context).backToManageCliq,
                                                    style: TextStyle(
                                                      color: AppColor.brightBlue,
                                                      fontSize: 14.t,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                          }),
                    );
                  })),
        ],
      ),
    ));
  }
}

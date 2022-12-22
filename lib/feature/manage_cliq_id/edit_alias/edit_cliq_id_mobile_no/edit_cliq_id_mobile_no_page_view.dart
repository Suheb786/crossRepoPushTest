import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/otp_for_edit_alias_and_mobile_no/otp_for_edit_alias_mobile_no_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/cliq_term_condition_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

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
                color: Theme.of(context).accentColor),
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
                color: Theme.of(context).accentColor),
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
                                        aliasValue: "00962" + model.mobileNoController.text,
                                        isAlias: false));
                              }
                            }
                          },
                          dataBuilder: (context, response) {
                            return AppStreamBuilder<Resource<bool>>(
                                initialData: Resource.none(),
                                stream: model.editMobileNoValidationResponseStream,
                                onData: (data) {
                                  if (data.status == Status.SUCCESS) {
                                    /* Navigator.pushNamed(context, RoutePaths.OtpForEditAliasAndMobileNoPage,
                                        arguments: OtpForEditAliasAndMobileNoPageArguments(
                                            data: EditCliqOtp('7738927791'),
                                            aliasId: '76777',
                                            aliasValue: model.aliasController.text,
                                            isAlias: true));*/

                                    ///api call
                                    model.makeOtpRequest(
                                        aliasId: model.arguments.aliasID,
                                        aliasValue: "00962" + model.mobileNoController.text,
                                        isAlias: false);
                                  }
                                },
                                dataBuilder: (context, isValid) {
                                  return GestureDetector(
                                    onHorizontalDragEnd: (details) {
                                      if (details.primaryVelocity!.isNegative) {
                                        debugPrint('isNegative');
                                        //  Navigator.pushNamed(context, RoutePaths.OtpForEditAliasAndMobileNoPage);
                                        model.validate();
                                      }
                                    },
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.only(
                                                    start: 24.w, top: 32.h, end: 24.w),
                                                child: AppTextField(
                                                  labelText: S.of(context).mobileNumber.toUpperCase(),
                                                  hintText: S.of(context).mobileNumberHint,
                                                  inputType: TextInputType.phone,
                                                  inputAction: TextInputAction.done,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(10),
                                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                  ],
                                                  controller: model.mobileNoController,
                                                  key: model.mobileNumberKey,
                                                  onChanged: (value) {
                                                    model.showBtn();
                                                  },
                                                ),
                                              ),
                                              AppStreamBuilder<bool>(
                                                initialData: false,
                                                stream: model.isSelectedStream,
                                                dataBuilder: (BuildContext context, data) {
                                                  return Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 24.w, top: 32.h, end: 24.w),
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
                                                        child: Visibility(
                                                          visible: (data == true
                                                              ? (isValid == true ? true : false)
                                                              : false),
                                                          child: AnimatedButton(
                                                              buttonText: S.of(context).swipeToProceed),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
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
                                                        letterSpacing: 1.0,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
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

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/cliq_term_condition_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EditAliasPageView extends BasePageViewWidget<EditAliasPageViewModel> {
  EditAliasPageView(ProviderBase model) : super(model);

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
              S.of(context).editYourAlias,
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
                child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity!.isNegative) {
                  debugPrint('isNegative');
                  Navigator.pushNamed(context, RoutePaths.OtpForEditAliasAndMobileNoPage);
                }
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 24.w, top: 32.h, end: 24.w),
                          child: AppTextField(
                            labelText: S.of(context).alias.toUpperCase(),
                            hintText: S.of(context).pleaseEnter,
                            controller: model.aliasController,
                            key: model.aliasKey,
                            inputAction: TextInputAction.done,
                            onChanged: (value) {
                              model.validate();
                            },
                            inputType: TextInputType.text,
                          ),
                        ),
                        AppStreamBuilder<bool>(
                          initialData: false,
                          stream: model.isSelectedStream,
                          dataBuilder: (BuildContext context, data) {
                            return Padding(
                              padding: EdgeInsetsDirectional.only(start: 24.w, top: 32.h, end: 24.w),
                              child: CliqTermConditionSelectionWidget(
                                subDescription: S.of(context).whenAcceptingCreationOfYourCliqId,
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
                                    visible: (data == true ? (isValid == true ? true : false) : false),
                                    child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
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
            ))
          ],
        ),
      ),
    );
  }
}

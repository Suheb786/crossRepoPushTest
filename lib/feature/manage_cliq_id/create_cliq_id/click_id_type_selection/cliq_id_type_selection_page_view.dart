import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/enum/cliq_id_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/click_id_type_selection/cliq_id_type_selection_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CliqIdTypeSelectionPageView extends BasePageViewWidget<CliqIdTypeSelectionPageViewModel> {
  CliqIdTypeSelectionPageView(ProviderBase model) : super(model);

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
                child: AppStreamBuilder<Resource<bool>>(
                    initialData: Resource.none(),
                    stream: model.cliqIdTypeSelectionValidationStream,
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        if (data.data!) {
                          ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).nextPage();
                        }
                      }
                    },
                    dataBuilder: (context, cliqIdTypeSelectionResponse) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (ProviderScope.containerOf(context)
                                  .read(createCliqIdViewModelProvider)
                                  .appSwiperController
                                  .page ==
                              0.0) {
                            FocusScope.of(context).unfocus();
                            if (StringUtils.isDirectionRTL(context)) {
                              if (!details.primaryVelocity!.isNegative) {
                                model.addIdNumberForResetPassword();
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                model.addIdNumberForResetPassword();
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        physics: ClampingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            AppTextField(
                                              labelText: S.of(context).cliqIdType.toUpperCase(),
                                              hintText: S.of(context).pleaseSelect,
                                              controller: model.cliqIdTypeController,
                                              key: model.clickIdTypeKey,
                                              readOnly: true,
                                              onPressed: () {
                                                RelationshipWithCardHolderDialog.show(context,
                                                    title: S.of(context).cliqIdType,
                                                    relationSHipWithCardHolder: [
                                                      S.of(context).alias,
                                                      S.of(context).mobileNumber
                                                    ], onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.cliqIdTypeController.text = value;
                                                  model.updateCliqIdType(value.fromCliqIdTypeValue());
                                                  model.validate();
                                                });
                                              },
                                              suffixIcon: (isValid, value) {
                                                return Container(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                                                    child: AppSvg.asset(AssetUtils.downArrow,
                                                        color: Theme.of(context).primaryColorDark));
                                              },
                                            ),
                                            AppStreamBuilder(
                                                stream: model.cliqIdTypeStream,
                                                initialData: CliqIdTypeEnum.NONE,
                                                dataBuilder: (context, cliqIdType) {
                                                  switch (cliqIdType) {
                                                    case CliqIdTypeEnum.ALIAS:
                                                      return Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 16.h,
                                                          ),
                                                          AppTextField(
                                                              labelText: S.of(context).alias.toUpperCase(),
                                                              hintText: S.of(context).pleaseEnter,
                                                              inputType: TextInputType.text,
                                                              inputAction: TextInputAction.done,
                                                              controller: model.aliasController,
                                                              key: model.aliasKey,
                                                              onChanged: (value) {
                                                                model.validate();
                                                              }),
                                                        ],
                                                      );
                                                    case CliqIdTypeEnum.MOBILE_NO:
                                                      return Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 16.h,
                                                          ),
                                                          AppTextField(
                                                            labelText:
                                                                S.of(context).mobileNumber.toUpperCase(),
                                                            hintText: S.of(context).mobileNumberHint,
                                                            inputType: TextInputType.phone,
                                                            inputAction: TextInputAction.done,
                                                            inputFormatters: [
                                                              LengthLimitingTextInputFormatter(10),
                                                              FilteringTextInputFormatter.allow(
                                                                  RegExp(r'[0-9]')),
                                                            ],
                                                            controller: model.mobileNumberController,
                                                            key: model.mobileNumberKey,
                                                            onChanged: (value) {
                                                              model.validate();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    default:
                                                      return Container();
                                                  }
                                                }),
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
                                                return Visibility(
                                                  visible: isValid!,
                                                  child: AnimatedButton(
                                                    buttonText: S.of(context).swipeToProceed,
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
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    }));
          }),
    );
  }
}

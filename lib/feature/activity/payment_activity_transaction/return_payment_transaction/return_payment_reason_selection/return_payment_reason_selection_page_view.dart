import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/enum/cliq_id_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_reason_selection/return_payment_reason_selection_page_view_model.dart';
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
import 'package:riverpod/src/framework.dart';

class ReturnPaymentReasonSelectionPageView
    extends BasePageViewWidget<ReturnPaymentReasonSelectionPageViewModel> {
  ReturnPaymentReasonSelectionPageView(ProviderBase model) : super(model);

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
                    stream: model.requestPaymentReasonValidationStream,
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        if (data.data!) {
                          ProviderScope.containerOf(context)
                              .read(returnPaymentTransactionSliderPageViewModelProvider)
                              .nextPage();
                        }
                      }
                    },
                    dataBuilder: (context, requestPaymentReasonSelectionResponse) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (ProviderScope.containerOf(context)
                                  .read(returnPaymentTransactionSliderPageViewModelProvider)
                                  .appSwiperController
                                  .page ==
                              0.0) {
                            FocusScope.of(context).unfocus();
                            if (StringUtils.isDirectionRTL(context)) {
                              if (!details.primaryVelocity!.isNegative) {
                                model.validateSelectedReason();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .previousPage();
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                model.validateSelectedReason();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
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
                                              controller: model.reasonToReturnController,
                                              key: model.reasonToReturnKey,
                                              readOnly: true,
                                              onPressed: () {
                                                RelationshipWithCardHolderDialog.show(context,
                                                    title: "Reason to Return",
                                                    relationSHipWithCardHolder:
                                                        StringUtils.isDirectionRTL(context)
                                                            ? model.returnResonTypeListAr
                                                            : model.returnResonTypeListEn, onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.reasonToReturnController.text = value;
                                                  // model.updateCliqIdType(value.fromCliqIdTypeValue());
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                            child: AppStreamBuilder<bool>(
                                                initialData: false,
                                                stream: model.showButtonStream,
                                                dataBuilder: (context, show) {
                                                  return Visibility(
                                                    visible: show!,
                                                    child: AnimatedButton(
                                                      buttonText: S.of(context).swipeToProceed,
                                                    ),
                                                  );
                                                })),
                                        Center(
                                          child: GestureDetector(
                                            onHorizontalDragDown: (details) {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              S.of(context).swipeDownToCancel,
                                              style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 10.t,
                                                letterSpacing: 1.0,
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w400,
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

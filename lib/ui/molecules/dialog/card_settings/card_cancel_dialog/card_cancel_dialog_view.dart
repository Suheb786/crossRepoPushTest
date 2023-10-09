import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/debit_card_settings/debit_card_settings_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/terms_and_condition_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/cancellation_reason_dialog/cancellation_reason_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/card_cancel_dialog/card_cancel_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CardCancelDialogView extends StatelessWidget {
  final Function(String, bool)? onSelected;
  final Function(AppError)? onError;
  final Function? onDismissed;
  final List<String> reasons;
  final bool? isPrimaryDebitCard;

  CardCancelDialogView(
      {required this.reasons, this.onSelected, this.onDismissed, this.onError, this.isPrimaryDebitCard});

  ProviderBase providerBase() {
    return cancelCardDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CardCancelDialogViewModel>(
      providerBase: providerBase(),
      builder: (context, model, child) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 170.h),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 34.h),
                    AppSvg.asset(
                      AssetUtils.cardCancelIcon,
                      height: 42.h,
                      width: 46.w,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      S.of(context).cancelTheCard,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 20.t,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 35.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: InkWell(
                          onTap: () {
                            CancellationReasonDialog.show(
                              context,
                              title: S.of(context).reasonOfCancellation,
                              onDismissed: () {
                                Navigator.pop(context);
                              },
                              onSelected: (value) {
                                model!.reasonCancellationController.text = value;
                                Navigator.pop(context);
                              },
                              reasons: reasons,
                            );
                          },
                          child: AppTextField(
                            labelText: S.of(context).reasonOfCancellation.toUpperCase(),
                            hintText: S.of(context).pleaseSelect,
                            readOnly: true,
                            key: model!.reasonKey,
                            controller: model.reasonCancellationController,
                            autoFocus: false,
                            onPressed: () {
                              CancellationReasonDialog.show(context,
                                  onDismissed: () {
                                    Navigator.pop(context);
                                    Future.delayed(Duration(milliseconds: 100), () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    });
                                  },
                                  title: S.of(context).reasonOfCancellation,
                                  reasons: reasons,
                                  onSelected: (value) {
                                    Navigator.pop(context);
                                    model.reasonCancellationController.text = value;
                                  });
                            },
                            suffixIcon: (isChecked, value) {
                              return Container(
                                width: 16.w,
                                height: 16.h,
                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1),
                              );
                            },
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                      child: Text(
                        S.of(context).cancelCardDesc,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).colorScheme.error,
                          height: 1.5,
                          fontSize: 14.t,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isPrimaryDebitCard ?? true,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                        child: AppStreamBuilder<bool>(
                          stream: model.declarationSelectedStream,
                          initialData: false,
                          dataBuilder: (context, isSelected) {
                            model.isSelected = isSelected!;
                            return TermsAndConditionWidget(
                              isSelected: isSelected,
                              title1: S.of(context).requestNewCardImmediately,
                              onTap: () {
                                model.updateDeclarationSelection(!(isSelected));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 42.h),
                      child: AppPrimaryButton(
                        onPressed: () {
                          if (isPrimaryDebitCard ?? true) {
                            if (model.reasonCancellationController.text.isEmpty) {
                              model.reasonKey.currentState!.isValid = false;
                              onError?.call(AppError(
                                error: ErrorInfo(message: ''),
                                type: ErrorType.SELECT_CANCELATION_REASON,
                                cause: Exception(),
                              ));
                            } else {
                              onSelected?.call(model.reasonCancellationController.text, model.isSelected);
                            }
                          } else {
                            onSelected?.call(model.reasonCancellationController.text, false);
                          }
                        },
                        text: S.of(context).confirm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -24.h,
              child: InkWell(
                onTap: () {
                  onDismissed?.call();
                },
                child: Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                    child: Image.asset(
                      AssetUtils.close_bold,
                      scale: 3.5,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/debit_card_settings/debit_card_settings_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
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
        insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
        child: Container(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  onDismissed?.call();
                }
              },
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
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
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
                        onPressed: () {
                          CancellationReasonDialog.show(context,
                              onDismissed: () {
                                Navigator.pop(context);
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Text(
                      S.of(context).cancelCardDesc,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).errorColor,
                        height: 1.5,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isPrimaryDebitCard ?? true,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
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
                  InkWell(
                    onTap: () {
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

                      // else if (!model.declarationSelected.value) {
                      //   onError?.call(AppError(
                      //     error: ErrorInfo(message: ''),
                      //     type: ErrorType.INVALID_DECLARATION_SELECTION,
                      //     cause: Exception(),
                      //   ));
                      // }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      height: 57.h,
                      width: 57.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                      child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          onDismissed?.call();
                        },
                        child: Text(
                          S.of(context).swipeDownToCancel,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 10.t,
                              fontWeight: FontWeight.w400,
                              color: AppColor.dark_gray_1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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

class CardCancelDialogView extends StatelessWidget {
  final Function(String, bool)? onSelected;
  final Function(AppError)? onError;
  final Function? onDismissed;
  final List<String> reasons;

  CardCancelDialogView(
      {required this.reasons, this.onSelected, this.onDismissed, this.onError});

  ProviderBase providerBase() {
    return cancelCardDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CardCancelDialogViewModel>(
      providerBase: providerBase(),
      builder: (context, model, child) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        insetPadding:
            EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
        child: Container(
          child: SingleChildScrollView(
            //physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 34),
                AppSvg.asset(
                  AssetUtils.cardCancelIcon,
                  height: 42,
                  width: 46,
                ),
                SizedBox(height: 15),
                Text(
                  S.of(context).cancelTheCard,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      labelText:
                          S.of(context).reasonOfCancellation.toUpperCase(),
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
                          width: 16,
                          height: 16,
                          padding: EdgeInsets.all(4),
                          child: AppSvg.asset(AssetUtils.downArrow,
                              color: AppColor.dark_gray_1),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    S.of(context).cancelCardDesc,
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                      height: 1.5,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    if (model.reasonCancellationController.text.isEmpty) {
                      model.reasonKey.currentState!.isValid = false;
                      onError?.call(AppError(
                        error: ErrorInfo(message: ''),
                        type: ErrorType.SELECT_CANCELATION_REASON,
                        cause: Exception(),
                      ));
                    } else {
                      onSelected?.call(
                          model.reasonCancellationController.text,
                          model.isSelected);
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
                    padding: EdgeInsets.all(16),
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context)
                            .accentTextTheme
                            .bodyText1!
                            .color!),
                    child: AppSvg.asset(AssetUtils.tick,
                        color: Theme.of(context).accentColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        onDismissed?.call();
                      },
                      child: Text(
                        S.of(context).swipeDownToCancel,
                        style: TextStyle(
                            fontSize: 10,
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
    );
  }
}

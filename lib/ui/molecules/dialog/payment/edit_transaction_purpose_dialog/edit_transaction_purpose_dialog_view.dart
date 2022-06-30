import 'package:domain/constants/enum/transaction_type.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/edit_transaction_purpose_dialog/edit_transaction_purpose_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditTransactionPurposeDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(Purpose, PurposeDetail)? onSelected;
  final Beneficiary? beneficiary;
  final TransactionType? type;
  final String? purpose;
  final String? purposeDetail;

  const EditTransactionPurposeDialogView(
      {this.onDismissed, this.onSelected, this.beneficiary, this.type, this.purposeDetail: "", this.purpose});

  ProviderBase providerBase() {
    return editTransactionPurposeDialogViewModelProvider
        .call([beneficiary!, type!, purpose!, purposeDetail!]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EditTransactionPurposeDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 32, start: 24, end: 24),
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      onDismissed?.call();
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        S.of(context).editTransactionPurpose,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            beneficiary!.fullName ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            beneficiary!.iban ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.gray_1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 28),
                        child: AppTextField(
                          labelText: S.of(context).purpose,
                          hintText: S.of(context).pleaseSelect,
                          inputType: TextInputType.text,
                          controller: model!.purposeController,
                          key: model.purposeKey,
                          readOnly: true,
                          onPressed: () {
                            if (model.purposeList != null && model.purposeList!.isNotEmpty) {
                              PurposeDialog.show(context, purposeList: model.purposeList!, onDismissed: () {
                                Navigator.pop(context);
                              }, onSelected: (value) {
                                Navigator.pop(context);
                                model.updatePurpose(value);
                                model.updatePurposeDetailList(value.purposeDetails!);
                              });
                            }
                          },
                          suffixIcon: (enabled, value) {
                            return AppSvg.asset(AssetUtils.dropDown,
                                color: AppColor.dark_gray_1, width: 16, height: 16);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 18),
                        child: AppTextField(
                          labelText: S.of(context).purposeDetails,
                          hintText: S.of(context).pleaseSelect,
                          inputType: TextInputType.text,
                          controller: model.purposeDetailController,
                          key: model.purposeDetailKey,
                          readOnly: true,
                          onPressed: () {
                            if (model.purposeDetailList != null && model.purposeDetailList!.isNotEmpty) {
                              PurposeDetailDialog.show(context, purposeDetailList: model.purposeDetailList,
                                  onDismissed: () {
                                Navigator.pop(context);
                              }, onSelected: (value) {
                                Navigator.pop(context);
                                model.updatePurposeDetail(value);
                              });
                            }
                          },
                          suffixIcon: (enabled, value) {
                            return AppSvg.asset(AssetUtils.dropDown,
                                color: AppColor.dark_gray_1, width: 16, height: 16);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 147),
                        child: InkWell(
                          onTap: () {
                            if (model.purpose != null && model.purposeDetail != null) {
                              onSelected!.call(model.purpose!, model.purposeDetail!);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                            child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                        child: Center(
                          child: Text(
                            S.of(context).swipeDownToCancel,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400, color: AppColor.dark_gray_1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.loadingStream.listen((value) {
            if (value) {
              AppProgress(context);
            } else {
              Navigator.pop(context);
            }
          });

          model.error.listen((event) {
            _showTopError(
                ErrorParser.getLocalisedStringError(
                  error: event,
                  localisedHelper: S.of(context),
                ),
                context);
          });
        },
        providerBase: providerBase());
  }

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        context,
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColor.dark_brown, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).error,
                          style: TextStyle(
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0, right: 16),
                          child: Text(message,
                              style: TextStyle(
                                  // fontFamily: "Montserrat",
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1500),
        hideOutAnimationDuration: Duration(milliseconds: 500),
        showOutAnimationDuration: Duration(milliseconds: 700));
  }
}

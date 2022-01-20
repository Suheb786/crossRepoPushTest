import 'package:domain/constants/enum/transaction_type.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/edit_transaction_purpose_dialog/edit_transaction_purpose_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EditTransactionPurposeDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(Purpose, PurposeDetail)? onSelected;
  final Beneficiary? beneficiary;
  final TransactionType? type;

  const EditTransactionPurposeDialogView(
      {this.onDismissed, this.onSelected, this.beneficiary, this.type});

  ProviderBase providerBase() {
    return editTransactionPurposeDialogViewModelProvider
        .call([beneficiary!, type!]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EditTransactionPurposeDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            insetPadding:
            EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 32, left: 24, right: 24),
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
                        alignment: Alignment.centerLeft,
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
                        alignment: Alignment.centerLeft,
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
                          if (model.purposeList != null &&
                              model.purposeList!.isNotEmpty) {
                            PurposeDialog.show(context,
                                purposeList: model.purposeList!,
                                onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.updatePurpose(value);
                                  model.updatePurposeDetailList(
                                      value.purposeDetails!);
                                });
                          }
                        },
                        suffixIcon: (enabled, value) {
                          return AppSvg.asset(AssetUtils.dropDown,
                              color: AppColor.dark_gray_1,
                              width: 16,
                              height: 16);
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
                          if (model.purposeDetailList != null &&
                              model.purposeDetailList!.isNotEmpty) {
                            PurposeDetailDialog.show(context,
                                purposeDetailList: model.purposeDetailList,
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
                              color: AppColor.dark_gray_1,
                              width: 16,
                              height: 16);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 147),
                      child: InkWell(
                        onTap: () {
                          onSelected!
                              .call(model.purpose!, model.purposeDetail!);
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                      child: Center(
                        child: Text(
                          S.of(context).swipeDownToCancel,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.dark_gray_1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        providerBase: providerBase());
  }
}

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
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../button/app_primary_button.dart';

class EditTransactionPurposeDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(Purpose, PurposeDetail)? onSelected;
  final Beneficiary? beneficiary;
  final TransactionType? type;
  final String? purpose;
  final String? purposeDetail;
  final bool onWillPop;

  const EditTransactionPurposeDialogView(
      {this.onDismissed,
      this.onSelected,
      this.beneficiary,
      this.type,
      this.purposeDetail = "",
      this.purpose,
      this.onWillPop = true});

  ProviderBase providerBase() {
    return editTransactionPurposeDialogViewModelProvider
        .call([beneficiary!, type!, purpose!, purposeDetail!]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<EditTransactionPurposeDialogViewModel>(
          builder: (context, model, child) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 204.h),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 32.h, start: 24.w, end: 24.w),
                      child: Column(
                        children: [
                          Text(
                            S.of(context).editTransactionPurpose,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 14.t,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.h),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                beneficiary!.fullName ?? '',
                                style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.t,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                beneficiary!.iban ?? '',
                                style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 12.t,
                                  color: AppColor.gray_1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 28.h),
                            child: AppTextField(
                              labelText: S.of(context).purpose,
                              hintText: S.of(context).pleaseSelect,
                              inputType: TextInputType.text,
                              controller: model!.purposeController,
                              key: model.purposeKey,
                              readOnly: true,
                              onPressed: () {
                                if (model.purposeList != null && model.purposeList!.isNotEmpty) {
                                  PurposeDialog.show(context, purposeList: model.purposeList!,
                                      onDismissed: () {
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
                                    color: AppColor.dark_gray_1, width: 16.w, height: 16.h);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 18.h),
                            child: AppTextField(
                              labelText: S.of(context).purposeDetails,
                              hintText: S.of(context).pleaseSelect,
                              inputType: TextInputType.text,
                              controller: model.purposeDetailController,
                              key: model.purposeDetailKey,
                              readOnly: true,
                              onPressed: () {
                                if (model.purposeDetailList != null && model.purposeDetailList!.isNotEmpty) {
                                  PurposeDetailDialog.show(context,
                                      purposeDetailList: model.purposeDetailList, onDismissed: () {
                                    Navigator.pop(context);
                                  }, onSelected: (value) {
                                    Navigator.pop(context);
                                    model.updatePurposeDetail(value);
                                  });
                                }
                              },
                              suffixIcon: (enabled, value) {
                                return AppSvg.asset(AssetUtils.dropDown,
                                    color: AppColor.dark_gray_1, width: 16.w, height: 16.h);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 147.h, bottom: 42.h),
                            child: AppPrimaryButton(
                              onPressed: () {
                                if (model.purpose != null && model.purposeDetail != null) {
                                  onSelected!.call(model.purpose!, model.purposeDetail!);
                                } else {
                                  Navigator.pop(context);
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
          providerBase: providerBase()),
    );
  }

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                              fontFamily: StringUtils.appFont,
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.t),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0.h, right: 16.w),
                          child: Text(message,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.t)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1500),
        reverseAnimationDuration: Duration(milliseconds: 500),
        animationDuration: Duration(milliseconds: 700));
  }
}

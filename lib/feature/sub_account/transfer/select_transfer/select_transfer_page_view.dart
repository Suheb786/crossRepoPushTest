import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/sub_account/account_to_account_transfer_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/sub_account/transfer/select_transfer/select_transfer_page_view_model.dart';
import 'package:neo_bank/feature/sub_account/transfer/transfer_success/transfer_success_page.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../base/base_page.dart';
import '../../../../generated/l10n.dart';
import '../../../../ui/molecules/dialog/sub_accounts_dialogs/select_from_list_dialog/select_from_list_dialog.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../ui/molecules/textfield/transfer_account_textfield.dart';
import '../../../../utils/status.dart';
import '../../../../utils/string_utils.dart';

class SelectTransferPageView extends BasePageViewWidget<SelectTransferPageViewModel> {
  SelectTransferPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, SelectTransferPageViewModel model) {
    // final iskeyBoardEnabled = MediaQuery.of(context).viewInsets.bottom != 0;
    return AppKeyBoardHide(
      child: Column(
        children: [
          SizedBox(height: 96.h),
          Text(
            S.current.transfer.toUpperCase(),
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 10.0.t,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Text(
            S.current.transferHeader,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 20.0.t,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 60.h, bottom: 56.h),
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(vertical: 32.h, horizontal: 24.w),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            Visibility(
                              // visible: !iskeyBoardEnabled,
                              child: AppStreamBuilder<Account>(
                                  initialData:
                                      model.getIntialTrasnferfromAccountDetail(model.argument.account),
                                  stream: model.transferFromAccountDetailsStream,
                                  dataBuilder: (context, modified) {
                                    return InkWell(
                                      onTap: () {
                                        SelectFromListDialog.show(
                                          context,
                                          title: S.current.transferFrom,
                                          accountName: model.getNonSelectedAccountTitleTransferFromList(),
                                          accountNumber: model.getNonSelectedAccountNumberTransferFromList(),
                                          availableAmount:
                                              model.getNonSelectedAvailableBalanceTransferFromList(),
                                          onDismissed: () => Navigator.pop(context),
                                          onConfirm: (value) {
                                            model.updateTransferFromAccount(value);
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      child: TransferAccountTextField(
                                          context: context,
                                          model: model,
                                          label: S.current.transferFrom.toUpperCase(),
                                          accuntNumber: modified?.accountNo ?? "",
                                          availableAmount: modified?.availableBalance == ""
                                              ? ""
                                              : StringUtils.formatBalance(modified?.availableBalance ?? "") +
                                                  " " +
                                                  S.current.JOD.toUpperCase(),
                                          accountName: modified?.isSubAccount == false
                                              ? (modified?.nickName == null || modified?.nickName == ""
                                                  ? (S.current.mainAccount)
                                                  : (S.current.mainAccount +
                                                      " - " +
                                                      (modified?.nickName ?? "")))
                                              : (modified?.nickName == null || modified?.nickName == ""
                                                  ? (S.current.subAccount)
                                                  : (S.current.subAccount +
                                                      " - " +
                                                      (modified?.nickName ?? "")))),
                                    );
                                  }),
                            ),
                            SizedBox(height: 16.h),
                            AppStreamBuilder<Account>(
                                stream: model.transferToAccountDetailsStream,
                                initialData: Account(
                                    accountNo: " ", accountTitle: " ", availableBalance: "", nickName: ""),
                                dataBuilder: (context, modified) {
                                  return InkWell(
                                    onTap: () {
                                      if (model.transferFromAccountDetailsResponse.hasValue) {
                                        SelectFromListDialog.show(
                                          context,
                                          title: S.current.transferTo,
                                          accountName: model.getNonSelectedAccountNameTransferToList(),
                                          accountNumber: model.getNonSelectedAccountNumberTransferToList(),
                                          availableAmount: model.getNonSelectedavailableAmountTansferToList(),
                                          onDismissed: () => Navigator.pop(context),
                                          onConfirm: (value) {
                                            model.updateTransferToAccount(value);
                                            model.validateIfEmpty();
                                            Navigator.pop(context);
                                          },
                                        );
                                      }
                                    },
                                    child: TransferAccountTextField(
                                      context: context,
                                      model: model,
                                      label: S.current.transferTo.toUpperCase(),
                                      accuntNumber: (modified?.accountNo ?? ""),
                                      accountName: (modified?.isSubAccount == false
                                          ? (modified?.nickName == null || modified?.nickName == ""
                                              ? (S.current.mainAccount)
                                              : (S.current.mainAccount + " - " + (modified?.nickName ?? "")))
                                          : (modified?.nickName == null || modified?.nickName == ""
                                              ? (S.current.subAccount)
                                              : (S.current.subAccount + " - " + (modified?.nickName ?? "")))),
                                      availableAmount: modified?.availableBalance == ""
                                          ? ""
                                          : StringUtils.formatBalance(modified?.availableBalance ?? "") +
                                              " " +
                                              S.current.JOD.toUpperCase(),
                                    ),
                                  );
                                }),
                            SizedBox(height: 16.h),
                            AppTextField(
                                labelText: S.current.amount.toUpperCase(),
                                hintText: S.current.JOD.toUpperCase(),
                                controller: model.amountTextController,
                                key: model.amountKey,
                                inputType: TextInputType.number,
                                onFieldSubmitted: (value) {
                                  StringUtils.formatBalance(value);
                                  model.validateIfEmpty();
                                })
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(bottom: 24.0.h),
                          child: AppStreamBuilder<Resource<AccountToAccountTransferResponse>>(
                              stream: model.accountToAccountTransferResponseStream,
                              initialData: Resource.none(),
                              onData: (value) {
                                if (value.status == Status.SUCCESS) {
                                  Navigator.pushNamed(context, RoutePaths.TransferSuccessPage,
                                      arguments: TransferSuccessPageArgument(
                                          amount: value.data?.content.amount ?? 0,
                                          accountNo: value.data?.content.reference ?? "",
                                          accountName: value.data?.content.name ?? ""));
                                }
                              },
                              dataBuilder: (context, transferResponse) {
                                return AppStreamBuilder<bool>(
                                    stream: model.showButtonStream,
                                    initialData: false,
                                    dataBuilder: (context, isValid) {
                                      return AppPrimaryButton(
                                        onPressed: () {
                                          model.validForm(context);
                                        },
                                        isDisabled: !isValid!,
                                        text: S.current.transfer,
                                      );
                                    });
                              }),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              S.of(context).backToDashboard,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                                fontSize: 14.t,
                                letterSpacing: 1.0,
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

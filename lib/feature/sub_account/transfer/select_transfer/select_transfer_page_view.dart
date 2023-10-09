import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/sub_account/account_to_account_transfer_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/sub_account/transfer/select_transfer/select_transfer_page_view_model.dart';
import 'package:neo_bank/feature/sub_account/transfer/transfer_success/transfer_success_page.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/sub_accounts_dialogs/select_account_list_dialog/select_account_list_dialog.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../base/base_page.dart';
import '../../../../generated/l10n.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../ui/molecules/textfield/transfer_account_textfield.dart';
import '../../../../utils/status.dart';
import '../../../../utils/string_utils.dart';

class SelectTransferPageView extends BasePageViewWidget<SelectTransferPageViewModel> {
  SelectTransferPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, SelectTransferPageViewModel model) {
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
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom - 50.h <= 0
                        ? 0
                        : MediaQuery.of(context).viewInsets.bottom - 48.h),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 32.h, horizontal: 24.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              Visibility(
                                child: AppStreamBuilder<Account>(
                                    initialData: Account(
                                        accountNo: " ",
                                        accountTitle: " ",
                                        availableBalance: "",
                                        nickName: ""),
                                    stream: model.selectedFromAccountStream,
                                    dataBuilder: (context, selectedFromAccount) {
                                      return InkWell(
                                        onTap: () {
                                          SelectAccountListDialog.show(
                                            context,
                                            title: S.current.transferFrom,
                                            accountList: model.getAllFromList,
                                            onDismissed: () => Navigator.pop(context),
                                            onConfirm: (value) {
                                              Navigator.pop(context);
                                              model.validateIfEmpty();
                                              model.addFromAccountData(selectedAccount: value);
                                              model.filterToAccountList(selectedAccount: value);
                                            },
                                          );
                                        },
                                        child: TransferAccountTextField(
                                            context: context,
                                            model: model,
                                            label: S.current.transferFrom.toUpperCase(),
                                            accuntNumber: selectedFromAccount?.accountNo ?? "",
                                            availableAmount: selectedFromAccount?.availableBalance == ""
                                                ? ""
                                                : StringUtils.formatBalance(
                                                        selectedFromAccount?.availableBalance ?? "") +
                                                    " " +
                                                    S.current.JOD.toUpperCase(),
                                            accountName: selectedFromAccount?.isSubAccount == false
                                                ? (selectedFromAccount?.nickName == null ||
                                                        selectedFromAccount?.nickName == ""
                                                    ? (S.current.mainAccount)
                                                    : (S.current.mainAccount +
                                                        " - " +
                                                        (selectedFromAccount?.nickName ?? "")))
                                                : (selectedFromAccount?.nickName == null ||
                                                        selectedFromAccount?.nickName == ""
                                                    ? (S.current.subAccount)
                                                    : (S.current.subAccount +
                                                        " - " +
                                                        (selectedFromAccount?.nickName ?? "")))),
                                      );
                                    }),
                              ),
                              SizedBox(height: 16.h),
                              AppStreamBuilder<Account>(
                                  stream: model.selectedToAccountStream,
                                  initialData: Account(
                                      accountNo: "", accountTitle: "", availableBalance: "", nickName: ""),
                                  dataBuilder: (context, modified) {
                                    return InkWell(
                                      onTap: () {
                                        if (model.getAllToAccountList.isNotEmpty) {
                                          SelectAccountListDialog.show(
                                            context,
                                            title: S.current.transferTo,
                                            accountList: model.getAllToAccountList,
                                            onDismissed: () => Navigator.pop(context),
                                            onConfirm: (value) {
                                              Navigator.pop(context);
                                              model.validateIfEmpty();
                                              model.addToAccountData(selectedAccount: value);
                                              model.filterFromAccountList(selectedAccount: value);
                                            },
                                          );
                                        }
                                      },
                                      child: TransferAccountTextField(
                                        context: context,
                                        model: model,
                                        label: S.current.transferTo.toUpperCase(),
                                        accuntNumber: (modified?.accountNo ?? ""),
                                        accountName: (modified?.accountNo ?? '').isNotEmpty
                                            ? (modified?.isSubAccount == false
                                                ? (modified?.nickName == null || modified?.nickName == ""
                                                    ? (S.current.mainAccount)
                                                    : (S.current.mainAccount +
                                                        " - " +
                                                        (modified?.nickName ?? "")))
                                                : (modified?.nickName == null || modified?.nickName == ""
                                                    ? (S.current.subAccount)
                                                    : (S.current.subAccount +
                                                        " - " +
                                                        (modified?.nickName ?? ""))))
                                            : S.of(context).selectAccount,
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
                                  inputType: TextInputType.numberWithOptions(decimal: true, signed: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))
                                  ],
                                  onChanged: (value) {
                                    model.validateIfEmpty();
                                  },
                                  onFieldSubmitted: (value) {
                                    StringUtils.formatBalance(value);
                                  }),
                              SizedBox(height: 16.h),
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
                                    Navigator.pushReplacementNamed(context, RoutePaths.TransferSuccessPage,
                                        arguments: TransferSuccessPageArgument(
                                          amount: value.data?.content.amount ?? 0,
                                          accountNo: model.selectedToAccount?.accountNo ?? '',
                                          accountName: (model.selectedToAccount?.isSubAccount ?? false)
                                              ? (model.selectedToAccount?.nickName ?? '').isNotEmpty
                                                  ? S.of(context).subAccount +
                                                      " - " +
                                                      (model.selectedToAccount?.nickName ?? '')
                                                  : S.of(context).subAccount
                                              : (model.selectedToAccount?.nickName ?? '').isNotEmpty
                                                  ? S.of(context).mainAccount +
                                                      " - " +
                                                      (model.selectedToAccount?.nickName ?? '')
                                                  : S.of(context).mainAccount,
                                        ));
                                  }
                                },
                                dataBuilder: (context, transferResponse) {
                                  return AppStreamBuilder<bool>(
                                      stream: model.showButtonStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return AppPrimaryButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            model.accountToAccountTransfer();
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
          ),
        ],
      ),
    );
  }
}

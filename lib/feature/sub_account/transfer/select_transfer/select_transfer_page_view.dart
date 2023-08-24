import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/sub_account/transfer/select_transfer/select_transfer_page_view_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../base/base_page.dart';
import '../../../../generated/l10n.dart';
import '../../../../ui/molecules/dialog/sub_accounts_dialogs/select_from_list_dialog/select_from_list_dialog.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../ui/molecules/textfield/transfer_account_textfield.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';
import '../../../../utils/string_utils.dart';

class SelectTransferPageView extends BasePageViewWidget<SelectTransferPageViewModel> {
  SelectTransferPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, SelectTransferPageViewModel model) {
    final iskeyBoardEnabled = MediaQuery.of(context).viewInsets.bottom != 0;
    return AppKeyBoardHide(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {},
        child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: !iskeyBoardEnabled,
                                  child: AppStreamBuilder<Account>(
                                      initialData:
                                          model.getIntialTrasnferfromAccountDetail(model.argument.account),
                                      stream: model.transferFromAccountDetailsStream,
                                      dataBuilder: (context, modified) {
                                        return GestureDetector(
                                          onTap: () {
                                            SelectFromListDialog.show(
                                              context,
                                              title: S.current.transferTo,
                                              accountName: model.getNonSelectedAccountTitleTransferFromList(),
                                              accountNumber:
                                                  model.getNonSelectedAccountNumberTransferFromList(),
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
                                            key: model.transferFromKey,
                                            label: S.current.transferFrom.toUpperCase(),
                                            accuntNumber: modified?.accountNo ?? "",
                                            availableAmount: modified?.availableBalance == ""
                                                ? ""
                                                : model.formatBalance(modified?.availableBalance ?? "") +
                                                    " " +
                                                    S.current.JOD.toUpperCase(),
                                            accountName: modified?.accountTitle ?? "",
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(height: 16.h),
                                AppStreamBuilder<Account>(
                                    stream: model.transferToAccountDetailsStream,
                                    initialData:
                                        Account(accountNo: " ", accountTitle: " ", availableBalance: ""),
                                    dataBuilder: (context, snapShot) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (model.transferFromAccountDetailsResponse.hasValue) {
                                            SelectFromListDialog.show(
                                              context,
                                              title: S.current.transferTo,
                                              accountName: model.getNonSelectedAccountNameTransferToList(),
                                              accountNumber:
                                                  model.getNonSelectedAccountNumberTransferToList(),
                                              availableAmount:
                                                  model.getNonSelectedavailableAmountTansferToList(),
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
                                          key: model.transferToKey,
                                          model: model,
                                          label: S.current.transferTo.toUpperCase(),
                                          accuntNumber: snapShot?.accountNo ?? "",
                                          accountName: snapShot?.accountTitle ?? "",
                                          availableAmount: snapShot?.availableBalance == ""
                                              ? ""
                                              : model.formatBalance(snapShot?.availableBalance ?? "") +
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
                                  onFieldSubmitted: (value) => model.formatAmount(value),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(bottom: 24.0.h),
                              child: AppStreamBuilder<bool>(
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
                                  }),
                            ),
                            Center(
                              child: AppStreamBuilder<Resource<GetDashboardDataResponse>>(
                                  stream: model.getDashboardDataStream,
                                  initialData: Resource.none(),
                                  onData: (value) {
                                    if (value.status == Status.SUCCESS) {
                                      Navigator.pushNamed(context, RoutePaths.AppHome);
                                    }
                                  },
                                  dataBuilder: (context, snapshot) {
                                    return InkWell(
                                      onTap: () {
                                        model.getDashboardData();
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
                                    );
                                  }),
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
        ),
      ),
    );
  }
}

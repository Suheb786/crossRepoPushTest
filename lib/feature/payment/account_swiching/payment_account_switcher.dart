import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../generated/l10n.dart';
import '../../../ui/molecules/dialog/account_selection/account_selection_dialog.dart';

class PaymentAccountSwitcher extends StatefulWidget {
  Function(Account) onDefaultSelectedAccount;
  Function(Account) onSelectAccount;
  String title;
  bool isSingleLineView;
  bool isShowAmount;

  PaymentAccountSwitcher(
      {required this.onDefaultSelectedAccount,
      required this.onSelectAccount,
      required this.title,
      required this.isSingleLineView,
      this.isShowAmount = false});

  @override
  State<PaymentAccountSwitcher> createState() => _PaymentAccountSwitcherState();
}

class _PaymentAccountSwitcherState extends State<PaymentAccountSwitcher> {
  late Account selectedAccount;
  late List<Account> totalAccounts;
  late ValueNotifier<Account> accountChangeNotifier;

  @override
  void initState() {
    totalAccounts = ProviderScope.containerOf(appLevelKey.currentContext!)
        .read(appHomeViewModelProvider)
        .getAllMyAccounts();

    /// default selected account put to the main account..
    selectedAccount = totalAccounts.firstWhere((element) => !(element.isSubAccount ?? true));
    accountChangeNotifier = ValueNotifier(selectedAccount);

    widget.onDefaultSelectedAccount(selectedAccount);

    super.initState();
  }

  onSelectedAccount(Account selectedAccount) {
    // to update the ui.
    this.selectedAccount = selectedAccount;
    accountChangeNotifier.value = selectedAccount;
    widget.onSelectAccount(selectedAccount);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        AccountSelectionDialog.show(context, title: widget.title, onDismissed: () {
          Navigator.pop(context);
        }, onSelected: (selectedAccount) {
          onSelectedAccount(selectedAccount);
          Navigator.pop(context);
        }, accountList: totalAccounts);
      },
      child: widget.isSingleLineView
          ? Container(
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 0.5),
              ),
              child: ValueListenableBuilder<Account>(
                valueListenable: accountChangeNotifier,
                builder: (context, Account value, Widget? child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 16),
                      Text(
                        "${selectedAccount.isSubAccount! ? "${selectedAccount.nickName == null ? S.of(context).subAccount : "${S.of(context).subAccount} - ${selectedAccount.nickName}"}" : "${selectedAccount.nickName == null ? S.of(context).mainAccount : "${S.of(context).mainAccount} - ${selectedAccount.nickName}"}"}",
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.t,
                          color: AppColor.light_acccent_blue,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        StringUtils.formatBalance(selectedAccount.availableBalance ?? '0.00'),
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.t,
                          color: Theme.of(context).colorScheme.shadow,
                        ),
                      ),
                      SizedBox(width: 2),
                      Text(
                        S.of(context).JOD,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.t,
                          color: AppColor.light_gray,
                        ),
                      ),
                      SizedBox(width: 8),
                      AppSvg.asset(
                        AssetUtils.downArrow,
                        color: AppColor.light_acccent_blue,
                      ),
                      SizedBox(width: 14),
                    ],
                  );
                },
              ))
          : Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsetsDirectional.all(16.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      width: 1,
                      color: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color)),
              child: ValueListenableBuilder<Account>(
                  valueListenable: accountChangeNotifier,
                  builder: (context, Account value, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 10.0.t,
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "${selectedAccount.isSubAccount! ? "${selectedAccount.nickName == null ? S.of(context).subAccount : "${S.of(context).subAccount} - ${selectedAccount.nickName}"}" : "${selectedAccount.nickName == null ? S.of(context).mainAccount : "${S.of(context).mainAccount} - ${selectedAccount.nickName}"}"}",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 14.0.t,
                                    color: Theme.of(context).colorScheme.shadow,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                selectedAccount.accountNo ?? "",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.0.t,
                                    color: Theme.of(context).colorScheme.surfaceTint,
                                    fontWeight: FontWeight.w600),
                              ),
                              Visibility(visible: !widget.isShowAmount, child: SizedBox(height: 16.h)),
                              Visibility(
                                visible: !widget.isShowAmount,
                                child: Text(
                                  StringUtils.formatBalance(selectedAccount.availableBalance ?? '0.00') +
                                      " " +
                                      S.of(context).JOD,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.0.t,
                                      color: Theme.of(context).colorScheme.shadow,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              height: 16.h,
                              width: 16.w,
                              padding: EdgeInsets.symmetric(horizontal: 7.w),
                              child: AppSvg.asset(AssetUtils.downArrow,
                                  color: Theme.of(context).primaryColorDark)),
                        )
                      ],
                    );
                  }),
            ),
    );
  }
}

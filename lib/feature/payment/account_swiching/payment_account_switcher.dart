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
import '../../../ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';

class PaymentAccountSwitcher extends StatefulWidget {
  Function(Account) onDefaultSelectedAccount;
  Function(Account) onSelectAccount;

  PaymentAccountSwitcher({
    required this.onDefaultSelectedAccount,
    required this.onSelectAccount,
  });

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

  onSelectedAccount() {
    // to update the ui.
    accountChangeNotifier = ValueNotifier(selectedAccount);
    widget.onSelectAccount(selectedAccount);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        AccountSelectionDialog.show(context, title: S.current.mobileNoRegisteredWithBlink, onDismissed: () {},
            onSelected: (selectedAccount) {
          onSelectedAccount();
          Navigator.pop(context);
        }, accountList: totalAccounts);
      },
      child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 0.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              Text(
                "${(selectedAccount.isSubAccount ?? false) ? "Sub Account" : "Main Account"}",
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
                "${selectedAccount.availableBalance ?? '0.00'}",
                softWrap: true,
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.t,
                  color: Theme.of(context).colorScheme.shadow,
                ),
              ),
              SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  S.of(context).JOD,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.t,
                    color: AppColor.light_gray,
                  ),
                ),
              ),
              SizedBox(width: 8),
              AppSvg.asset(
                AssetUtils.downArrow,
                color: AppColor.light_acccent_blue,
              ),
              SizedBox(width: 14),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import 'beneficiary_transaction_history_list_page_view.dart';
import 'beneficiary_transaction_history_list_page_view_model.dart';

class BeneficiaryTransactionHistoryListPage extends BasePage<BeneficiaryTransactionHistoryListPageViewModel> {
  @override
  BeneficiaryTransactionHistoryListPageState createState() => BeneficiaryTransactionHistoryListPageState();
}

class BeneficiaryTransactionHistoryListPageState extends BaseStatefulPage<
    BeneficiaryTransactionHistoryListPageViewModel, BeneficiaryTransactionHistoryListPage> {
  @override
  ProviderBase provideBase() {
    return beneficiaryTransactionHistoryListPageViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.0.h),
      child: GestureDetector(
          onVerticalDragEnd: (details) {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: EdgeInsets.only(bottom: 35.h, top: 50.h),
            child: Center(
              child: Text(
                S.of(context).transactionHistory,
                style: TextStyle(
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          )),
    );
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, BeneficiaryTransactionHistoryListPageViewModel model) {
    return BeneficiaryTransactionHistoryListPageView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import 'beneficiary_transaction_history_list_page_view.dart';
import 'beneficiary_transaction_history_list_page_view_model.dart';

class BeneficiaryTransactionHistoryListPage extends BasePage<BeneficiaryTransactionHistoryListPageViewModel> {
  BeneficiaryTransactionHistoryListPageArguments arguments;

  BeneficiaryTransactionHistoryListPage(this.arguments);

  @override
  BeneficiaryTransactionHistoryListPageState createState() => BeneficiaryTransactionHistoryListPageState();
}

class BeneficiaryTransactionHistoryListPageState extends BaseStatefulPage<
    BeneficiaryTransactionHistoryListPageViewModel, BeneficiaryTransactionHistoryListPage> {
  @override
  ProviderBase provideBase() {
    return beneficiaryTransactionHistoryListPageViewModelProvider.call(widget.arguments);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.0.h),
      child: Padding(
        padding: EdgeInsets.only(bottom: 35.h, top: 50.h, left: 24.w, right: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: AppSvg.asset(AssetUtils.back,
                  height: 24.h,
                  width: 24.w,
                  matchTextDirection: true,
                  color: widget.arguments.navigationType == NavigationType.SEND_MONEY
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.shadow),
            ),
            Center(
              child: Text(
                S.of(context).transactionHistory,
                style: TextStyle(
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: widget.arguments.navigationType == NavigationType.REQUEST_MONEY
                        ? Theme.of(context).colorScheme.surfaceVariant
                        : Theme.of(context).colorScheme.secondary),
              ),
            ),
            SizedBox(
              height: 40,
              width: 40,
            )
          ],
        ),
      ),
    );
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return widget.arguments.navigationType == NavigationType.REQUEST_MONEY
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, BeneficiaryTransactionHistoryListPageViewModel model) {
    return BeneficiaryTransactionHistoryListPageView(provideBase());
  }
}

class BeneficiaryTransactionHistoryListPageArguments {
  final NavigationType navigationType;
  final String beneficiaryId;

  BeneficiaryTransactionHistoryListPageArguments({required this.navigationType, required this.beneficiaryId});
}

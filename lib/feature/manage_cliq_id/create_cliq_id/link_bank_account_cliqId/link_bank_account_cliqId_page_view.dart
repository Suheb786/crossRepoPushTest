import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/link_bank_account_cliqId/link_bank_account_cliqId_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/accounts_dialog/accounts_dialog.dart';
import 'package:neo_bank/ui/molecules/register/add_income_widget.dart';
import 'package:neo_bank/utils/string_utils.dart';

class LinkBankAccountCliqIdPageView extends BasePageViewWidget<LinkBankAccountCliqIdPageViewModel> {
  LinkBankAccountCliqIdPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (ProviderScope.containerOf(context)
                      .read(createCliqIdViewModelProvider)
                      .appSwiperController
                      .page ==
                  1.0) {
                FocusScope.of(context).unfocus();
                if (StringUtils.isDirectionRTL(context)) {
                  if (!details.primaryVelocity!.isNegative) {
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).nextPage();
                  } else {
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).previousPage();
                  }
                } else {
                  if (details.primaryVelocity!.isNegative) {
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).nextPage();
                  } else {
                    ProviderScope.containerOf(context).read(createCliqIdViewModelProvider).previousPage();
                  }
                }
              }
            },
            child: Card(
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                          ? 0
                          : MediaQuery.of(context).viewInsets.bottom - 48),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AddIncomeWidget(
                          label: S.of(context).addIncome,
                          onTap: () {
                            AccountsDialog.show(context,
                                accountsList: ['5669 4900 2111', '5669 4900 2111'],
                                label: S.of(context).addLinkAccount, onDismissed: () {
                              Navigator.pop(context);
                            }, onSelected: (value) {
                              Navigator.pop(context);
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

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
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
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
                    child: SingleChildScrollView(
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              S.of(context).linkedAccount,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.t,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Expanded(
                                  child: Column(
                                    children: [
                                      Text('Savings Account 1'),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Savings Account 1'),
                                          Icon(
                                            Icons.more_horiz_outlined,
                                            size: 25,
                                            color: Color(0xFF5F6368),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(),
                                        child: Text(
                                          'Default',
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12.t,
                                              color: AppColor.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: 6),
                          AddIncomeWidget(
                            label: S.of(context).addIncome,
                            onTap: () {
                              AccountsDialog.show(context, label: S.of(context).addLinkAccount,
                                  onDismissed: () {
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
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

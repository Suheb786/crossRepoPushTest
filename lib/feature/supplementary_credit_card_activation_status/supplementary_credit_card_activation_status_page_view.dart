import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card_activation_status/supplementary_credit_card_activation_status_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_activation_status_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class SupplementaryCreditCardActivationStatusPageView
    extends BasePageViewWidget<
        SupplementaryCreditCardActivationStatusPageViewModel> {
  SupplementaryCreditCardActivationStatusPageView(ProviderBase model)
      : super(model);

  @override
  Widget build(BuildContext context,
      SupplementaryCreditCardActivationStatusPageViewModel model) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 92),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AssetUtils.line),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.vividYellow,
                            ),
                            child:
                                Center(child: AppSvg.asset(AssetUtils.right)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 56,
                  ),
                  Text(
                    S.of(context).preparingYourCard,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CreditCardActivationStatusWidget(
                    label: S.of(context).creatingSuppCreditLimit,
                    isActivated: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CreditCardActivationStatusWidget(
                    label: S.of(context).issuingSuppCreditCard,
                    isActivated: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CreditCardActivationStatusWidget(
                    label: S.of(context).activatingSuppCreditCard,
                    isActivated: true,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AddRequestMoneyContactPageView
    extends BasePageViewWidget<AddRequestMoneyContactViewModel> {
  AddRequestMoneyContactPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Center(
        child: AspectRatio(
          aspectRatio: 0.62,
          child: GestureDetector(
            onHorizontalDragEnd: (details) {},
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              color: Theme.of(context).canvasColor,
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Padding(
                        padding: EdgeInsets.only(top: 30, left: 27),
                        child: Text(S.of(context).requestMoney,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ))),
                    Padding(
                      padding: EdgeInsets.only(top: 90),
                      child: Align(
                        alignment: Alignment.center,
                        child: AppSvg.asset(AssetUtils.profileCircle),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).addSendContact,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ])),
            ),
          ),
        ),
      ),
    );
  }
}

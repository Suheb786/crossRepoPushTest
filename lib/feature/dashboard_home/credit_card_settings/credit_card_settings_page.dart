import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardSettingsPage extends BasePage<CreditCardSettingsViewModel> {
  final CreditCardSettingsArguments _cardSettingsArguments;

  CreditCardSettingsPage(this._cardSettingsArguments);

  @override
  CreditCardSettingsPageState createState() => CreditCardSettingsPageState();
}

class CreditCardSettingsPageState
    extends BaseStatefulPage<CreditCardSettingsViewModel, CreditCardSettingsPage> {
  @override
  ProviderBase provideBase() {
    return creditCardSettingsViewModelProvider.call(widget._cardSettingsArguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  void onModelReady(CreditCardSettingsViewModel model) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (!(model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false)) {
        InformationDialog.show(context,
            image: AssetUtils.card_activation,
            title: S.of(context).cardSettingsDisabled,
            descriptionWidget: Text(
              S.of(context).cardSettingsDisabledDesc,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 14.t,
                  fontWeight: FontWeight.w400,
                  color: AppColor.veryDarkGray1),
            ), onSelected: () {
          Navigator.pop(context);
        }, onDismissed: () {
          Navigator.pop(context);
        });
      }
    });

    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, CreditCardSettingsViewModel model) {
    return CreditCardSettingsPageView(provideBase());
  }
}

class CreditCardSettingsArguments {
  final CreditCard creditCard;
  final bool isChangePinEnabled;

  CreditCardSettingsArguments({required this.creditCard, required this.isChangePinEnabled});
}

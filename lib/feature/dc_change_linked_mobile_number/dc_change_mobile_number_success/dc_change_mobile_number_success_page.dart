import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_mobile_number_success/dc_change_mobile_number_success_page_view.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_mobile_number_success/dc_change_mobile_number_success_view_model.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_page_view.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_view_model.dart';

class DcChangeMobileNumberSuccessPage
    extends BasePage<DcChangeMobileNumberSuccessViewModel> {
  @override
  DcChangeMobileNumberSuccessPageState createState() =>
      DcChangeMobileNumberSuccessPageState();
}

class DcChangeMobileNumberSuccessPageState extends BaseStatefulPage<
    DcChangeMobileNumberSuccessViewModel, DcChangeMobileNumberSuccessPage> {
  @override
  ProviderBase provideBase() {
    return dcChangeMobileNumberSuccessViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(
      BuildContext context, DcChangeMobileNumberSuccessViewModel model) {
    return DcChangeMobileNumberSuccessPageView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/add_new_email/add_new_email_address_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/add_new_email/add_new_email_address_page_view_model.dart';

class AddNewEmailAddressPage extends BasePage<AddNewEmailAddressPageViewModel> {
  @override
  AddNewEmailAddressPageState createState() => AddNewEmailAddressPageState();
}

class AddNewEmailAddressPageState extends BaseStatefulPage<
        AddNewEmailAddressPageViewModel, AddNewEmailAddressPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AddNewEmailAddressPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return addNewEmailAddressViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(
      BuildContext context, AddNewEmailAddressPageViewModel model) {
    return AddNewEmailAddressPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

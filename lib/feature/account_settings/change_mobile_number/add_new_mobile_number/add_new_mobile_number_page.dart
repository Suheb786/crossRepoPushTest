import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/add_new_mobile_number/add_new_mobile_number_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/add_new_mobile_number/add_new_mobile_number_page_view_model.dart';

class AddNewMobileNumberPage extends BasePage<AddNewMobileNumberPageViewModel> {
  @override
  AddNewMobileNumberPageState createState() => AddNewMobileNumberPageState();
}

class AddNewMobileNumberPageState
    extends BaseStatefulPage<AddNewMobileNumberPageViewModel, AddNewMobileNumberPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AddNewMobileNumberPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return addNewMobileNumberViewModelProvider;
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
  Widget buildView(BuildContext context, AddNewMobileNumberPageViewModel model) {
    return AddNewMobileNumberPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

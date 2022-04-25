import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/add_new_mobile_cliq/add_new_mobile_no_cliq_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/add_new_mobile_cliq/add_new_mobile_no_cliq_page_view_model.dart';

class AddNewMobileNumberCliqPage
    extends BasePage<AddNewMobileNumberCliqPageViewModel> {
  @override
  AddNewMobileNumberCliqPageState createState() =>
      AddNewMobileNumberCliqPageState();
}

class AddNewMobileNumberCliqPageState extends BaseStatefulPage<
        AddNewMobileNumberCliqPageViewModel, AddNewMobileNumberCliqPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AddNewMobileNumberCliqPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return addNewMobileNumberCliqViewModelProvider;
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
      BuildContext context, AddNewMobileNumberCliqPageViewModel model) {
    return AddNewMobileNumberCliqPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

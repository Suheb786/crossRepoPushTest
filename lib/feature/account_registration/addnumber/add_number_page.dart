import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_model.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_page_view.dart';

class AddNumberPage extends BasePage<AddNumberViewModel> {
  @override
  AddNumberPageState createState() => AddNumberPageState();
}

class AddNumberPageState extends BaseStatefulPage<AddNumberViewModel, AddNumberPage>
    with AutomaticKeepAliveClientMixin {
  AddNumberPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return addNumberViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, AddNumberViewModel model) {
    return AddNumberPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

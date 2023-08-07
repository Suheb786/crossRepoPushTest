import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';

import 'add_email_model.dart';
import 'add_email_page_view.dart';

class AddEmailPage extends BasePage<AddEmailViewModel> {
  @override
  AddEmailPageState createState() => AddEmailPageState();
}

class AddEmailPageState extends BaseStatefulPage<AddEmailViewModel, AddEmailPage>
    with AutomaticKeepAliveClientMixin {
  AddEmailPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return addEmailViewModelProvider;
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
  Widget buildView(BuildContext context, AddEmailViewModel model) {
    return AddEmailPageView(provideBase());
  }

  @override
  bool? resizeToAvoidBottomInset() {
    return false;
  }

  @override
  bool get wantKeepAlive => true;
}

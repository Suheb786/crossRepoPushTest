import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/help_center/help_center_modules.dart';
import 'package:neo_bank/feature/help_center/call_ended/call_ended_page_view.dart';
import 'package:neo_bank/feature/help_center/call_ended/call_ended_page_view_model.dart';

class CallEndedPage extends BasePage<CallEndedPageViewModel> {
  @override
  CallEndedPagePageState createState() => CallEndedPagePageState();
}

class CallEndedPagePageState extends BaseStatefulPage<CallEndedPageViewModel, CallEndedPage> {
  @override
  ProviderBase provideBase() {
    return callEndedPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, CallEndedPageViewModel model) {
    return CallEndedPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}

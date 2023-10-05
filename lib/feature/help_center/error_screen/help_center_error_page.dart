import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/help_center/help_center_modules.dart';

import 'help_center_error_page_view.dart';
import 'help_center_error_page_view_model.dart';

class HelpCenterErrorPage extends BasePage<HelpCenterErrorPageViewModel> {
  InfobipCallStatusEnum status;

  HelpCenterErrorPage(this.status);

  @override
  HelpCenterErrorPagePageState createState() => HelpCenterErrorPagePageState();
}

class HelpCenterErrorPagePageState
    extends BaseStatefulPage<HelpCenterErrorPageViewModel, HelpCenterErrorPage> {
  @override
  ProviderBase provideBase() {
    return helpCenterErrorViewModelProvider;
  }

  @override
  void onModelReady(HelpCenterErrorPageViewModel model) {
    model.status = widget.status;
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, HelpCenterErrorPageViewModel model) {
    return HelpCenterErrorPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}

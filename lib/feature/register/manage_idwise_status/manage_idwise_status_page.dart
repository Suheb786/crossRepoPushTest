import 'package:flutter/src/widgets/framework.dart';
import 'package:riverpod/src/framework.dart';

import '../../../base/base_page.dart';
import '../../../di/account_registration/account_registration_modules.dart';
import 'manage_idwise_status_model.dart';
import 'manage_idwise_status_view.dart';

class ManageIDWiseStatusPage extends BasePage<ManageIDWiseStatusViewModel> {
  final ManageIDWiseStatusParams _arguments;

  ManageIDWiseStatusPage(this._arguments);

  @override
  ManageIDWiseStatusPageState createState() => ManageIDWiseStatusPageState();
}

class ManageIDWiseStatusPageState
    extends BaseStatefulPage<ManageIDWiseStatusViewModel, ManageIDWiseStatusPage> {
  @override
  Widget buildView(BuildContext context, ManageIDWiseStatusViewModel model) {
    return ManageIDWiseStatusView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return manageIDWiseStatusViewModel;
  }

  @override
  void onModelReady(ManageIDWiseStatusViewModel model) {
    model.arguments = widget._arguments;
    super.onModelReady(model);
  }
}

class ManageIDWiseStatusParams {
  bool isAhwalCheckPassed;
  bool isFaceMatchScorePassed;
  String journeyId;

  ManageIDWiseStatusParams(
      {required this.isAhwalCheckPassed, required this.isFaceMatchScorePassed, required this.journeyId});
}

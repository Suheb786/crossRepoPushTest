import 'package:flutter/material.dart';
import 'package:neo_bank/feature/account_registration/manage_idwise_status/manage_idwise_status_model.dart';
import 'package:riverpod/src/framework.dart';

import '../../../base/base_page.dart';

class ManageIDWiseStatusView extends BasePageViewWidget<ManageIDWiseStatusViewModel> {
  ManageIDWiseStatusView(ProviderBase providerBase) : super(providerBase);

  @override
  Widget build(BuildContext context, ManageIDWiseStatusViewModel model) {
    return Text("data");
  }
}

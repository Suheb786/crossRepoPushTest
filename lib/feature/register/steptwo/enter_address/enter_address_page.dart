import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/steptwo/enter_address/enter_address_model.dart';
import 'package:neo_bank/feature/register/steptwo/enter_address/enter_address_view.dart';
import 'package:riverpod/src/framework.dart';

class EnterAddressPage extends BasePage<EnterAddressViewModel> {
  @override
  EnterAddressPageState createState() => EnterAddressPageState();
}

class EnterAddressPageState
    extends BaseStatefulPage<EnterAddressViewModel, EnterAddressPage> {
  @override
  ProviderBase provideBase() {
    return enterAddressViewModelProvider;
  }

  @override
  void onModelReady(EnterAddressViewModel model) {
  }

  @override
  Widget buildView(BuildContext context, EnterAddressViewModel model) {
    return EnterAddressView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/addnumber/add_number_model.dart';
import 'package:neo_bank/feature/register/stepone/addnumber/add_number_page_view.dart';

class AddNumberPage extends BasePage<AddNumberViewModel> {
  @override
  AddNumberPageState createState() => AddNumberPageState();
}

class AddNumberPageState
    extends BaseStatefulPage<AddNumberViewModel, AddNumberPage> {
  @override
  ProviderBase provideBase() {
    return addNumberViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, AddNumberViewModel model) {
    return AddNumberPageView(provideBase());
  }
}

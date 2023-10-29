import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/create_cliq_id_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/create_cliq_id_page_view_model.dart';

class CreateCliqIdPage extends BasePage<CreateCliqIdPageViewModel> {
  @override
  CreateCliqIdPageState createState() => CreateCliqIdPageState();
}

class CreateCliqIdPageState
    extends BaseStatefulPage<CreateCliqIdPageViewModel, CreateCliqIdPage> {
  @override
  ProviderBase provideBase() {
    return createCliqIdViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, CreateCliqIdPageViewModel model) {
    return CreateCliqIdPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(CreateCliqIdPageViewModel model, {param}) async {
    var parentModel =
        ProviderScope.containerOf(context).read(createCliqIdViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}

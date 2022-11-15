import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/edit_mobile_no_cliq_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_mobile_number_cliq/edit_mobile_no_cliq_page_view_model.dart';

class EditMobileNoCliqPage extends BasePage<EditMobileNoCliqPageViewModel> {
  @override
  EditMobileNoCliqPageState createState() => EditMobileNoCliqPageState();
}

class EditMobileNoCliqPageState
    extends BaseStatefulPage<EditMobileNoCliqPageViewModel, EditMobileNoCliqPage> {
  @override
  ProviderBase provideBase() {
    return editMobileNoViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, EditMobileNoCliqPageViewModel model) {
    return EditMobileNoCliqPageView(provideBase());
  }
}

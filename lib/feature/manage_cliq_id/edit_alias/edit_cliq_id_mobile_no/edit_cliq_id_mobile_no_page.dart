import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page_view_model.dart';

import 'edit_cliq_id_mobile_no_page_view.dart';
import 'edit_cliq_id_mobile_no_page_view_model.dart';

class EditCliqIDMobileNoPage extends BasePage<EditCliqIDMobileNoPageViewModel> {
  @override
  EditCliqIDMobileNoPageState createState() => EditCliqIDMobileNoPageState();
}

class EditCliqIDMobileNoPageState
    extends BaseStatefulPage<EditCliqIDMobileNoPageViewModel, EditCliqIDMobileNoPage> {
  @override
  ProviderBase provideBase() {
    return editAliasViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  /* @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(preferredSize: Size(double.maxFinite, 96), child: Container());
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }*/

  @override
  Widget buildView(BuildContext context, EditCliqIDMobileNoPageViewModel model) {
    return EditCliqIDMobileNoPageView(provideBase());
  }
}

/*class EditCliqIDMobileNoPageArguments {
  final
}*/

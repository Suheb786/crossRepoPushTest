import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page_view_model.dart';

class EditAliasPage extends BasePage<EditAliasPageViewModel> {
  final EditAliasPageArguments _arguments;

  EditAliasPage(this._arguments);

  @override
  EditAliasPageState createState() => EditAliasPageState();
}

class EditAliasPageState extends BaseStatefulPage<EditAliasPageViewModel, EditAliasPage> {
  @override
  ProviderBase provideBase() {
    return editAliasViewModelProvider.call(widget._arguments);
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
  Widget buildView(BuildContext context, EditAliasPageViewModel model) {
    return EditAliasPageView(provideBase());
  }
}

class EditAliasPageArguments {
  final String aliasID;
  final String aliasName;

  EditAliasPageArguments({required this.aliasID, required this.aliasName});
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';

import 'link_account_page_view.dart';
import 'link_account_page_view_model.dart';

class LinkAccountPage extends BasePage<LinkAccountPageViewModel> {
  final LinkAccountPageArgument _arguments;

  LinkAccountPage(this._arguments);

  @override
  LinkAccountPageState createState() => LinkAccountPageState();
}

class LinkAccountPageState extends BaseStatefulPage<LinkAccountPageViewModel, LinkAccountPage> {
  @override
  ProviderBase provideBase() {
    return linkAccountPageViewModelProvider.call(widget._arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, LinkAccountPageViewModel model) {
    return LinkAccountPageView(provideBase());
  }
}

class LinkAccountPageArgument {
  final String aliasId;
  final String linkType;

  final bool isAlias;
  final String aliasValue;
  final bool getToken;

  LinkAccountPageArgument(
      {required this.aliasId,
      required this.aliasValue,
      required this.isAlias,
      required this.getToken,
      required this.linkType});
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page_view_model.dart';

class BaseCardPageView extends BasePageViewWidget<BaseCardPageViewModel> {
  BaseCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, BaseCardPageViewModel model) {
    return Card(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text('BaseCard'),
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page_view_model.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class BaseCardPageView extends BasePageViewWidget<BaseCardPageViewModel> {
  BaseCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, BaseCardPageViewModel model) {
    return Card(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 32.0.h, horizontal: 24.0.w),
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

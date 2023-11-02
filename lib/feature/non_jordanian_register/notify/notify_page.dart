import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/non_jordanian_register/non_jordanian_register_modules.dart';
import 'package:neo_bank/feature/non_jordanian_register/notify/notify_page_view.dart';
import 'package:neo_bank/feature/non_jordanian_register/notify/notify_page_view_model.dart';

class NotifyPage extends BasePage<NotifyPageViewModel> {
  @override
  NotifyPageState createState() => NotifyPageState();
}

class NotifyPageState extends BaseStatefulPage<NotifyPageViewModel, NotifyPage> {
  @override
  ProviderBase provideBase() {
    return notifyViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, NotifyPageViewModel model) {
    return NotifyPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(NotifyPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(nonJordanianRegistrationViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}

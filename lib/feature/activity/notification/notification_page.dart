import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/notification/notification_page_view.dart';
import 'package:neo_bank/feature/activity/notification/notification_view_model.dart';

class NotificationPage extends BasePage<NotificationViewModel> {
  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends BaseStatefulPage<NotificationViewModel, NotificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return notificationViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, NotificationViewModel model) {
    return NotificationPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}

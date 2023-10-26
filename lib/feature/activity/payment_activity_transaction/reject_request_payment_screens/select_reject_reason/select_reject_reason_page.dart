import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/select_reject_reason/select_reject_reason_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/select_reject_reason/select_reject_reason_page_view_model.dart';

class SelectRejectReasonPage extends BasePage<SelectRejectReasonPageViewModel> {
  @override
  SelectRejectReasonPageState createState() => SelectRejectReasonPageState();
}

class SelectRejectReasonPageState
    extends BaseStatefulPage<SelectRejectReasonPageViewModel, SelectRejectReasonPage>
    with AutomaticKeepAliveClientMixin {
  SelectRejectReasonPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return selectRejectReasonPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, SelectRejectReasonPageViewModel model) {
    return SelectRejectReasonPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<bool> onBackPressed(SelectRejectReasonPageViewModel model,
      {param}) async {
    var parentModel = ProviderScope.containerOf(context)
        .read(rejectRequestPaymentPageViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }

}

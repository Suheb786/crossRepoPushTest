import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_new_mobile_number/dc_enter_new_mobile_number_page_view.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_new_mobile_number/dc_enter_new_mobile_number_page_view_model.dart';

class DcEnterNewMobileNumberPage
    extends BasePage<DcEnterNewMobileNumberPageViewModel> {
  @override
  DcEnterNewMobileNumberPageState createState() =>
      DcEnterNewMobileNumberPageState();
}

class DcEnterNewMobileNumberPageState extends BaseStatefulPage<
    DcEnterNewMobileNumberPageViewModel,
    DcEnterNewMobileNumberPage> with AutomaticKeepAliveClientMixin {
  DcEnterNewMobileNumberPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return dcEnterNewMobileNumberViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(
      BuildContext context, DcEnterNewMobileNumberPageViewModel model) {
    return DcEnterNewMobileNumberPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<bool> onBackPressed(DcEnterNewMobileNumberPageViewModel model,
      {param}) async {
    var parentModel = ProviderScope.containerOf(context)
        .read(dcChangeLinkedMobileNumberViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}

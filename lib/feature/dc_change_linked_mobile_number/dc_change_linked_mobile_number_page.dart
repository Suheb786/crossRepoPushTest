import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_page_view.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_view_model.dart';
import 'package:neo_bank/utils/navgition_type.dart';

class DcChangeLinkedMobileNumberPage
    extends BasePage<DcChangeLinkedMobileNumberViewModel> {
  NavigationType? navigationType;

  DcChangeLinkedMobileNumberPage({this.navigationType});

  @override
  DcChangeLinkedMobileNumberPageState createState() =>
      DcChangeLinkedMobileNumberPageState();
}

class DcChangeLinkedMobileNumberPageState extends BaseStatefulPage<
    DcChangeLinkedMobileNumberViewModel,
    DcChangeLinkedMobileNumberPage> with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return dcChangeLinkedMobileNumberViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(
      BuildContext context, DcChangeLinkedMobileNumberViewModel model) {
    return DcChangeLinkedMobileNumberPageView(
        provideBase(), widget.navigationType);
  }

  @override
  bool get wantKeepAlive => true;
}

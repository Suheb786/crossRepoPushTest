import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_page_view.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_view_model.dart';

class DcChangeLinkedMobileNumberPage extends BasePage<DcChangeLinkedMobileNumberViewModel> {
  final DCChangeLinkedMobileNumberArguments _arguments;

  DcChangeLinkedMobileNumberPage(this._arguments);

  @override
  DcChangeLinkedMobileNumberPageState createState() => DcChangeLinkedMobileNumberPageState();
}

class DcChangeLinkedMobileNumberPageState
    extends BaseStatefulPage<DcChangeLinkedMobileNumberViewModel, DcChangeLinkedMobileNumberPage>
    with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return dcChangeLinkedMobileNumberViewModelProvider;
  }

  @override
  void onModelReady(DcChangeLinkedMobileNumberViewModel model) {
    model.arguments = widget._arguments;
    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return widget._arguments.cardType == CardType.DEBIT
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, DcChangeLinkedMobileNumberViewModel model) {
    return DcChangeLinkedMobileNumberPageView(provideBase(), widget._arguments);
  }

  @override
  bool get wantKeepAlive => true;
}

class DCChangeLinkedMobileNumberArguments {
  final CardType cardType;
  final String? tokenizedPan;

  DCChangeLinkedMobileNumberArguments({this.cardType = CardType.DEBIT, this.tokenizedPan});
}

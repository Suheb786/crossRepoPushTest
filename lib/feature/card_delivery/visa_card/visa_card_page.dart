import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/card_delivery/visa_card/visa_card_page_view.dart';
import 'package:neo_bank/feature/card_delivery/visa_card/visa_card_page_view_model.dart';

class VisaCardPage extends BasePage<VisaCardPageViewModel> {
  @override
  VisaCardPageState createState() => VisaCardPageState();
}

class VisaCardPageState
    extends BaseStatefulPage<VisaCardPageViewModel, VisaCardPage>
    with TickerProviderStateMixin {
  @override
  ProviderBase provideBase() {
    return visaCardViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, VisaCardPageViewModel model) {
    return VisaCardPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(VisaCardPageViewModel model, {param}) async {
    var parentModel =
        ProviderScope.containerOf(context).read(cardDeliveryViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}

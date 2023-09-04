import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_page_view.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/utils/navgition_type.dart';

class PaymentHomePage extends BasePage<PaymentHomeViewModel> {
  NavigationType? navigationType;

  PaymentHomePage({this.navigationType});

  @override
  PaymentHomePageState createState() => PaymentHomePageState();
}

class PaymentHomePageState extends BaseStatefulPage<PaymentHomeViewModel, PaymentHomePage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  ProviderBase provideBase() {
    return paymentHomeViewModelProvider;
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
  void onModelReady(PaymentHomeViewModel model) {
    model.navigationType = widget.navigationType ?? NavigationType.DASHBOARD;
    // model.getBeneficiaries(context, "SM");
    if (!model.animationInitialized) {
      model.animationInitialized = true;
      model.getBeneficiaries(context, "SM");
      model.translateUpController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );

      model.translateUpAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: model.translateUpController,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        ),
      );

      model.translateSidewaysController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );



    }
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, PaymentHomeViewModel model) {
    return PaymentHomePageView(provideBase(), widget.navigationType);
  }

  @override
  bool get wantKeepAlive => true;
}

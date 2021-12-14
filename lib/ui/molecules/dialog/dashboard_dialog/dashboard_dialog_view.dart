import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/utils/color_utils.dart';

class DashboardDialogView extends StatelessWidget {
  DashboardDialogView();

  ProviderBase providerBase() {
    return dashboardDialogViewModelProvider;
  }

  List<Widget> pages = [
    Container(
      height: 100,
      width: 100,
      color: AppColor.whiteGray,
    ),
    Container(
      height: 100,
      width: 100,
      color: AppColor.black,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: double.infinity,
    //   width: double.infinity,
    //   color: Theme.of(context).primaryColorDark.withOpacity(0.4),
    //   child: BaseWidget<DashboardDialogViewModel>(
    //       builder: (data, model, child) {
    //         return Padding(
    //           padding: EdgeInsets.only(bottom: 47),
    //           child: AppStreamBuilder<int>(
    //             stream: model!.currentStep,
    //             initialData: 0,
    //             dataBuilder: (context, currentStep) {
    //               return GestureDetector(
    //                 behavior: HitTestBehavior.translucent,
    //                 child: Padding(
    //                   padding: EdgeInsets.only(top: 75),
    //                   child: Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Expanded(
    //                         child: Padding(
    //                           padding: EdgeInsets.only(top: 30),
    //                           child: Column(
    //                             children: [
    //                               Expanded(
    //                                 child: Padding(
    //                                   padding: EdgeInsets.only(top: 4),
    //                                   child: Stack(
    //                                     alignment: Alignment.center,
    //                                     children: [
    //                                       AppSwiper(
    //                                         pages: pages,
    //                                         pageController: model.pageController,
    //                                         onIndexChanged: (index) {
    //                                           model.updatePage(index);
    //                                           model.updatePageControllerStream(index);
    //                                         },
    //                                         currentStep: currentStep,
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //           ),
    //         );
    //       },
    //       providerBase: providerBase()),
    // );
    return Container();
  }
}

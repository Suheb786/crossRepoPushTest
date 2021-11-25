import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/get_card/get_card_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class AppHomePageView extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageView(ProviderBase model) : super(model);

  List pages = [
    GetCardPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    // return Container(
    //   color: Theme.of(context).accentColor,
    //   child: Padding(
    //     padding: EdgeInsets.only(top: 85, left: 48, right: 48),
    //     child: Column(
    //       children: [
    //         Text(
    //           S.of(context).totalBalance,
    //           style: TextStyle(
    //               fontWeight: FontWeight.w400,
    //               fontSize: 18,
    //               color: AppColor.black),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(top: 5.0),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text("0.00",
    //                   style: TextStyle(
    //                       fontSize: 24,
    //                       fontWeight: FontWeight.w700,
    //                       color: Theme.of(context).primaryColorDark)),
    //               Padding(
    //                 padding: EdgeInsets.only(left: 5.0),
    //                 child: Text("JOD",
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.w700,
    //                         fontSize: 14,
    //                         color: AppColor.verLightGray4)),
    //               )
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(top: 18.0),
    //           child: AppSvg.asset(AssetUtils.swipeDown),
    //         ),
    //         // Padding(
    //         //   padding: EdgeInsets.symmetric(horizontal: 24),
    //         //   child: AppStreamBuilder<int>(
    //         //     initialData: 0,
    //         //     stream: model.currentPageSubject,
    //         //     dataBuilder: (context, currentPage) {
    //         //       return DotsIndicator(
    //         //         dotsCount: pages.length,
    //         //         position: currentPage!.toDouble(),
    //         //         mainAxisSize: MainAxisSize.max,
    //         //         decorator: DotsDecorator(
    //         //             shape: RoundedRectangleBorder(
    //         //                 borderRadius: BorderRadius.circular(5)),
    //         //             activeSize:
    //         //             Size(MediaQuery.of(context).size.width / 6, 4),
    //         //             size: Size(MediaQuery.of(context).size.width / 6, 4),
    //         //             spacing: EdgeInsets.symmetric(horizontal: 1),
    //         //             activeShape: RoundedRectangleBorder(
    //         //                 borderRadius: BorderRadius.circular(5)),
    //         //             activeColor: Theme.of(context).accentColor,
    //         //             color:
    //         //             Theme.of(context).primaryColorLight.withOpacity(0.3)),
    //         //       );
    //         //     },
    //         //   ),
    //         // ),
    //         Expanded(
    //           child: PageView.builder(
    //             itemCount: pages.length,
    //             physics: NeverScrollableScrollPhysics(),
    //             controller: model.appHomeController,
    //             onPageChanged: (currentPage) {
    //               model.changeCurrentPage(currentPage);
    //             },
    //             itemBuilder: (context, index) {
    //               return pages[index];
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Padding(
      padding: EdgeInsets.only(top: 85),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Text(
                S.of(context).totalBalance,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppColor.black),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("0.00",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColorDark)),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text("JOD",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColor.verLightGray4)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: AppSvg.asset(AssetUtils.swipeDown),
              ),
              Expanded(
                child: AppSwiper(
                  pages: pages,
                  pageController: model.pageController,
                  onIndexChanged: (index) {
                    // model.changeCurrentPage(index);
                  },
                  currentStep: currentStep,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

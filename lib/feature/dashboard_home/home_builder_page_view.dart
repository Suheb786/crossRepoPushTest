import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/home_builder_view_model.dart';

class HomeBuilderView extends BasePageViewWidget<HomeBuilderViewModel> {
  HomeBuilderView(ProviderBase model) : super(model);

  List pages = [];

  @override
  Widget build(BuildContext context, model) {
    // return Padding(
    //   padding: EdgeInsets.only(top: 56),
    //   child: Column(
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 24),
    //         child: AppStreamBuilder<int>(
    //           initialData: 0,
    //           stream: model.currentPageSubject,
    //           dataBuilder: (context, currentPage) {
    //             return DotsIndicator(
    //               dotsCount: pages.length,
    //               position: currentPage!.toDouble(),
    //               mainAxisSize: MainAxisSize.max,
    //               decorator: DotsDecorator(
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(5)),
    //                   activeSize:
    //                   Size(MediaQuery.of(context).size.width / 6, 4),
    //                   size: Size(MediaQuery.of(context).size.width / 6, 4),
    //                   spacing: EdgeInsets.symmetric(horizontal: 1),
    //                   activeShape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(5)),
    //                   activeColor: Theme.of(context).accentColor,
    //                   color:
    //                   Theme.of(context).primaryColorLight.withOpacity(0.3)),
    //             );
    //           },
    //         ),
    //       ),
    //       Expanded(
    //         child: PageView.builder(
    //           itemCount: pages.length,
    //           physics: NeverScrollableScrollPhysics(),
    //           controller: model.registrationStepsController,
    //           onPageChanged: (currentPage) {
    //             model.changeCurrentPage(currentPage);
    //           },
    //           itemBuilder: (context, index) {
    //             return pages[index];
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Container();
  }
}

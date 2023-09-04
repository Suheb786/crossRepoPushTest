import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dashboard/bottom_bar_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagment_team_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/pager/activity_swiper.dart';
import '../../../utils/device_size_helper.dart';

class ActivityHomePageView extends BasePageViewWidget<ActivityHomeViewModel> {
  ActivityHomePageView(ProviderBase model) : super(model);

  Widget? paymentActivityTransactionPage;

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<List<RequestMoneyActivityList>>>(
        stream: model.paymentActivityListStream,
        initialData: Resource.none(),
        dataBuilder: (context, paymentActivity) {
          return AppStreamBuilder<int>(
            stream: model.currentStep,
            initialData: 0,
            dataBuilder: (context, currentStep) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (DeviceSizeHelper.isBigDevice ? 0.08 : 0.06) -
                        4),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          AppStreamBuilder<ActivityAnimatedPage>(
                              stream: model.pageSwitchStream,
                              initialData: ActivityAnimatedPage.NULL,
                              dataBuilder: (context, switchedPage) {
                                if (paymentActivityTransactionPage == null) {
                                  paymentActivityTransactionPage = PaymentActivityTransactionPage(
                                    PaymentActivityTransactionPageArgument(
                                      backgroundColor: Theme.of(context).canvasColor,
                                      title: S.of(context).paymentActivity,
                                      titleColor: AppColor.black,
                                    ),
                                  );
                                }
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  reverseDuration: const Duration(milliseconds: 400),
                                  switchInCurve: Curves.easeInOut,
                                  switchOutCurve: Curves.linearToEaseOut,
                                  child: switchedPage == ActivityAnimatedPage.PAYMENT_ACTIVITY
                                      ? paymentActivityTransactionPage
                                      : const SizedBox(),
                                );
                              }),
                          AnimatedBuilder(
                              animation: model.translateSettingsUpController,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /// To get rid of the unwanted card size changes....
                                  AppStreamBuilder<ActivityAnimatedPage>(
                                      stream: model.pageSwitchStream,
                                      initialData: ActivityAnimatedPage.NULL,
                                      dataBuilder: (context, switchedPage) {
                                        return AnimatedCrossFade(
                                          crossFadeState: switchedPage == ActivityAnimatedPage.NULL
                                              ? CrossFadeState.showFirst
                                              : CrossFadeState.showSecond,
                                          firstChild: const SizedBox(),
                                          secondChild: SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.03 +
                                                MediaQuery.of(context).size.height *
                                                    (DeviceSizeHelper.isBigDevice ? 0.036 : 0.02) +
                                                117.h,
                                          ),
                                          duration: const Duration(milliseconds: 500),
                                        );
                                      }),
                                  activityTitleWidget(),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            fit: StackFit.expand,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.only(bottom: 0.0.h),
                                                child: ActivitySwiper(
                                                  pages: [PaymentActivityPage()],
                                                  currentStep: currentStep,
                                                  appSwiperController: model.appSwiperController,
                                                  onIndexChanged: (index) {
                                                    model.updatePage(index);
                                                  },
                                                  translateSidewaysController:
                                                      model.translateSidewaysController,
                                                ),
                                              ),

                                              ///View More button
                                              AppStreamBuilder<ActivityAnimatedPage>(
                                                  stream: model.pageSwitchStream,
                                                  initialData: ActivityAnimatedPage.NULL,
                                                  dataBuilder: (context, switchedPage) {
                                                    return Positioned(
                                                      bottom: 20,
                                                      child: currentStep == 0 &&
                                                              (paymentActivity?.data ?? []).isNotEmpty
                                                          ? InkWell(
                                                              splashColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
                                                              onTap: () {
                                                                model.showHideAllTransactionsPage(
                                                                    switchedPage ==
                                                                        ActivityAnimatedPage.NULL);
                                                              },
                                                              child: AnimatedContainer(
                                                                duration: const Duration(milliseconds: 500),
                                                                curve: Curves.easeInOut,
                                                                width: switchedPage ==
                                                                        ActivityAnimatedPage.PAYMENT_ACTIVITY
                                                                    ? 48
                                                                    : 100,
                                                                height: switchedPage ==
                                                                        ActivityAnimatedPage.PAYMENT_ACTIVITY
                                                                    ? 48
                                                                    : 36,
                                                                alignment: Alignment.center,
                                                                margin: switchedPage ==
                                                                        ActivityAnimatedPage.PAYMENT_ACTIVITY
                                                                    ? EdgeInsets.zero
                                                                    : EdgeInsets.only(bottom: 4),
                                                                decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  border: Border.all(
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .inverseSurface,
                                                                      width: 1),
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .inverseSurface,
                                                                        blurRadius: 5,
                                                                        spreadRadius: 0.1,
                                                                        offset: Offset(0, 4))
                                                                  ],
                                                                ),
                                                                child: AnimatedCrossFade(
                                                                  duration: const Duration(milliseconds: 500),
                                                                  reverseDuration:
                                                                      const Duration(milliseconds: 500),
                                                                  firstCurve: Curves.easeIn,
                                                                  secondCurve: Curves.easeIn,
                                                                  alignment: Alignment.center,
                                                                  crossFadeState: switchedPage ==
                                                                          ActivityAnimatedPage
                                                                              .PAYMENT_ACTIVITY
                                                                      ? CrossFadeState.showFirst
                                                                      : CrossFadeState.showSecond,
                                                                  firstChild: Padding(
                                                                    padding: const EdgeInsets.all(10.0),
                                                                    child: AppSvg.asset(AssetUtils.down,
                                                                        color: AppColor.light_acccent_blue,
                                                                        height: 40,
                                                                        width: 40),
                                                                  ),
                                                                  secondChild: Padding(
                                                                    padding: const EdgeInsets.only(top: 2.0),
                                                                    child: Text(
                                                                      S.current.view_more,
                                                                      style: TextStyle(
                                                                          color: AppColor.skyblue,
                                                                          fontSize: 12,
                                                                          fontWeight: FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    );
                                                  }),
                                              /*Visibility(
                                              visible: currentStep == 0 && (paymentActivity?.data ?? []).isNotEmpty,
                                              child: Positioned(
                                                bottom: 0,
                                                child: Column(
                                                  children: [
                                                    AppSvg.asset(AssetUtils.swipeUp),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.only(top: 2.0.h),
                                                      child: Text(
                                                        S.of(context).swipeToViewMore,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            color: AppColor.dark_gray_2,
                                                            fontSize: 12.0.t,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )*/
                                            ],
                                          ),
                                        ),

                                        /// INDICATOR...
                                        AppStreamBuilder<ActivityAnimatedPage>(
                                            stream: model.pageSwitchStream,
                                            initialData: ActivityAnimatedPage.NULL,
                                            dataBuilder: (context, switchedPage) {
                                              return AnimatedCrossFade(
                                                crossFadeState: switchedPage != ActivityAnimatedPage.NULL
                                                    ? CrossFadeState.showFirst
                                                    : CrossFadeState.showSecond,
                                                firstChild: const SizedBox(),
                                                secondChild: SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.04,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(bottom: 17.h),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: buildPageIndicator(currentStep!, 1),
                                                    ),
                                                  ),
                                                ),
                                                duration: const Duration(milliseconds: 500),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                      0,
                                      (model.translateSettingsUpController.value *
                                          (-MediaQuery.of(context).size.height * 0.78))),
                                  child: child,
                                );
                              }),
                        ],
                      ),
                    ),
                    AppStreamBuilder<ActivityAnimatedPage>(
                        stream: model.pageSwitchStream,
                        initialData: ActivityAnimatedPage.NULL,
                        dataBuilder: (context, switchedPage) {
                          return AnimatedCrossFade(
                            crossFadeState: (switchedPage != ActivityAnimatedPage.NULL)
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: Duration(milliseconds: 500),
                            secondChild: const SizedBox(),
                            firstChild: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      (DeviceSizeHelper.isBigDevice ? 0.036 : 0.02)),
                              child: BottomBarWidget(
                                onHomeTap: () {
                                  if (switchedPage == ActivityAnimatedPage.NULL) {
                                    Navigator.pop(context);
                                  }
                                },
                                onMoreTap: () {
                                  if (switchedPage == ActivityAnimatedPage.NULL) {
                                    Navigator.pop(context);
                                  }
                                },
                                onContactUsTap: () {
                                  if (switchedPage == ActivityAnimatedPage.NULL) {
                                    EngagementTeamDialog.show(context, onDismissed: () {
                                      Navigator.pop(context);
                                    }, onSelected: (value) {
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                              ),
                            ),
                          );
                        })
                  ],
                ),
              );
            },
          );
        });
  }

  List<Widget> buildPageIndicator(int currentPage, int totalPage) {
    List<Widget> list = [];
    for (int i = 0; i < totalPage; i++) {
      list.add(i == currentPage
          ? indicator(true, i, currentPage, totalPage)
          : indicator(false, i, currentPage, totalPage));
    }
    return list;
  }

  Widget indicator(bool isActive, int i, int currentPage, int totalPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: getIndicatorSize(isActive, i, currentPage, totalPage),
      width: getIndicatorSize(isActive, i, currentPage, totalPage),
      decoration: BoxDecoration(
        color: getColor(isActive, i),
        shape: BoxShape.circle,
      ),
    );
  }

  double getIndicatorSize(bool isActive, int i, int currentPage, int totalPage) {
    if (isActive) {
      return 7.0;
    } else if ((i == 0 || i == totalPage - 1) && !isActive) {
      return 5.0;
    }
    return 5.0;
  }

  Color getColor(bool isActive, int i) {
    if (isActive) {
      return Colors.black;
    } else {
      return Color(0xFFA9A9A9);
    }
  }

  Widget activityTitleWidget() {
    return Column(
      children: [
        AppSvg.asset(AssetUtils.book),
        SizedBox(height: 2.h),
        Text(
          S.current.activity,
          style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 18.0.t),
        )
      ],
    );
  }
}

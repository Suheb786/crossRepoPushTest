import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DebitCardDeliveredPageView extends BasePageViewWidget<DebitCardDeliveredViewModel> {
  DebitCardDeliveredPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 40.h, end: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: InkWell(
                      onTap: () {
                        ProviderScope.containerOf(context)
                            .read(homeViewModelProvider)
                            .homeController
                            .jumpToPage(2);
                      },
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: AppSvg.asset(AssetUtils.close)))),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 106.0.h, start: 24.w),
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.confirmDebitCardDeliveryStream,
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            Navigator.pushNamed(context, RoutePaths.DebitCardVerificationSuccess);
                          }
                        },
                        initialData: Resource.none(),
                        dataBuilder: (context, cardDeliveryResponse) {
                          return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              model.confirmDebitCardDelivery();
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 2,
                              color: Theme.of(context).accentColor,
                              margin: EdgeInsetsDirectional.zero,
                              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(top: 226.h),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          S.of(context).numberOnCard,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 10.t,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.gray4),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(top: 9.h),
                                        child: Text(
                                          model.debitCard.cardNumber!.isNotEmpty
                                              ? StringUtils.getLastFourDigitOfCardNo(
                                                  model.debitCard.cardNumber)
                                              : '-',
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 30.t,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsetsDirectional.only(top: 78.h, start: 30.w, end: 24.w),
                                        child: Text(
                                          S.of(context).cardDelivery,
                                          maxLines: 4,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.gray4),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(top: 75.h, bottom: 31.h),
                                        child: AnimatedButton(
                                            buttonText: S.of(context).swipeToConfirm,
                                            borderColor: Theme.of(context).accentTextTheme.bodyText1!.color),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  PositionedDirectional(
                      start: 40.w,
                      end: 16.w,
                      top: 72.h,
                      child: Stack(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                                height: 186.h,
                                width: double.infinity,
                                padding: EdgeInsetsDirectional.only(top: 111.h, start: 20.w),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        matchTextDirection: true,
                                        image: AssetImage(
                                          AssetUtils.debitCard,
                                        ),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(10.43)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.debitCard.accountTitle ?? '',
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.t,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsetsDirectional.only(top: 10.h),
                                        child: Text(
                                            model.debitCard.cardNumber!.isNotEmpty
                                                ? StringUtils.getLastFourDigitOfCardNo(
                                                    model.debitCard.cardNumber)
                                                : '-',
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 12.t,
                                                fontWeight: FontWeight.w700)))
                                  ],
                                )),
                          ),
                          Positioned(
                              left: 7.w,
                              bottom: 19.h,
                              child: Image.asset(
                                AssetUtils.ellipseRed,
                                height: 55.h,
                                width: 55.w,
                              ))
                        ],
                      ))
                ],
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: 36.h),
                  child: Text(
                    S.of(context).deliveryIssue,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).accentTextTheme.bodyText1!.color,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

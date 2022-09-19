import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_confirm_flight_detail/rj_confirm_flight_detail_page.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_flight_booking_detail_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_page.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_otp_validate/rj_otp_validate_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RjFlightBookingDetailPageView extends BasePageViewWidget<RjFlightBookingDetailPageViewModel> {
  final pages = [
    // CountrySelectionPage(),
    RjConfirmFlightDetailPage(),
    // CreatePasswordPage(),
    // ValidateOtpPage(),
    RjMakePaymentPage(),
    RjOtpValidatePage(),
  ];

  RjFlightBookingDetailPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 56),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: AppStreamBuilder<int>(
              initialData: 0,
              stream: model.currentPageStream,
              dataBuilder: (context, currentPage) {
                return DotsIndicator(
                  dotsCount: pages.length,
                  position: currentPage!.toDouble(),
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeSize: Size(MediaQuery.of(context).size.width / 3.7, 5),
                      size: Size(MediaQuery.of(context).size.width / 3.7, 5),
                      spacing: EdgeInsets.symmetric(horizontal: 1),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeColor: Theme.of(context).accentColor,
                      color: Theme.of(context).primaryColorLight.withOpacity(0.3)),
                );
              },
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 36),
            child: AppStreamBuilder<int>(
              stream: model.currentPageStream,
              initialData: 0,
              dataBuilder: (context, currentStep) {
                return Column(
                  children: [
                    Text(
                      S.of(context).bookFlight,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 10,
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 8.0, bottom: currentStep == 2 ? 0 : 32, start: 24, end: 24),
                      child: ShowUpAnimation(
                        key: ValueKey(currentStep),
                        delayStart: Duration(milliseconds: 50),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: Text(
                          StepTextHelper.accountRegistrationTextHelper(
                            currentStep ?? 0,
                            S.of(context).pleaseConfirmFlightDetail,
                            S.of(context).howYouLikeToPayment,
                            '${S.of(context).enterOtpHeader} \n +962 79 322 8080',
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).accentColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    /* AppStreamBuilder<MobileNumberParams>(
                        stream: model.mobileNumberStream,
                        initialData: MobileNumberParams(),
                        dataBuilder: (context, mobileNumber) {
                          return Visibility(
                            visible: currentStep == 2,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 32),
                              child: ShowUpAnimation(
                                delayStart: Duration(milliseconds: 500),
                                animationDuration: Duration(milliseconds: 750),
                                curve: Curves.bounceIn,
                                direction: Direction.vertical,
                                offset: 0.5,
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    "${mobileNumber!.mobileCode.isNotEmpty ? (mobileNumber.mobileCode.contains('00') ? mobileNumber.mobileCode.replaceAll('00', '+') : '+${mobileNumber.mobileCode}') : '-'} "
                                    "${mobileNumber.mobileNumber}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).accentColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),*/
                    Expanded(
                      child: AppSwiper(
                        pages: pages,
                        appSwiperController: model.appSwiperController,
                        pageController: model.pageController,
                        onIndexChanged: (index) {
                          model.changeCurrentPage(index);
                        },
                        currentStep: currentStep,
                      ),
                    )
                  ],
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}

class Pages extends StatelessWidget {
  final text;
  Pages({this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}

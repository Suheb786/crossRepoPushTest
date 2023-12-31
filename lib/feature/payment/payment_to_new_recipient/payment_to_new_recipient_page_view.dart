import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_page.dart';
import 'package:neo_bank/feature/payment/payment_to_new_recipient/payment_to_new_recipient_view_model.dart';
import 'package:neo_bank/feature/payment/send_to_new_recipient/send_to_new_recipient_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class PaymentToNewRecipientPageView extends BasePageViewWidget<PaymentToNewRecipientViewModel> {
  PaymentToNewRecipientPageView(ProviderBase model) : super(model);

  final pages = [SendToNewRecipientPage(), EnterOtpPage(), Visibility(visible: false, child: BaseCardPage())];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h, bottom: 36.0.h),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: DotsIndicator(
                  dotsCount: pages.length - 1,
                  position: currentStep!,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeSize: Size((MediaQuery.of(context).size.width) / 2.5, 4),
                      size: Size((MediaQuery.of(context).size.width) / 2.5, 4),
                      spacing: EdgeInsets.symmetric(horizontal: 1.0.w),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      color: Theme.of(context).primaryColorLight.withOpacity(0.3)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 37.0.h),
                child: ShowUpAnimation(
                  key: ValueKey(currentStep),
                  delayStart: Duration(milliseconds: 50),
                  animationDuration: Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: StepTextHelper.paymentToNewRecipientStepTextHelper(
                    currentStep,
                    Column(
                      children: [
                        Text(
                          S.of(context).sending,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20.0.t),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppStreamBuilder<bool>(
                                  stream: model.editAmountStream,
                                  initialData: false,
                                  dataBuilder: (context, isEdit) {
                                    return isEdit!
                                        ? Container(
                                            height: 28.0.h,
                                            width: 100.0.w,
                                            child: TextFormField(
                                              autofocus: true,
                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
                                              ],
                                              onChanged: (value) {
                                                if (value != ".") {
                                                  ProviderScope.containerOf(context)
                                                      .read(sendMoneyViewModelProvider)
                                                      .currentPinValue = model.editAmountController.text;

                                                  model.argument?.currentPinValue = value;
                                                }
                                              },
                                              onFieldSubmitted: (value) {
                                                model.updateEditAmount(false);
                                              },
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 28.0.t,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context).colorScheme.secondary),
                                              cursorColor: Theme.of(context).colorScheme.secondary,
                                              controller: model.editAmountController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(bottom: 10.0.h),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            double.parse(ProviderScope.containerOf(context)
                                                    .read(sendMoneyViewModelProvider)
                                                    .currentPinValue)
                                                .toStringAsFixed(3),
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: Theme.of(context).colorScheme.secondary,
                                                fontSize: 28.0.t,
                                                fontWeight: FontWeight.w700),
                                          );
                                  }),
                              Padding(
                                padding: EdgeInsets.only(top: 6.0.h),
                                child: Text(
                                  S.of(context).JOD,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.very_light_red,
                                      fontSize: 14.0.t,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0.h),
                          child: AppStreamBuilder<bool>(
                              stream: model.editAmountStream,
                              initialData: false,
                              dataBuilder: (context, value) {
                                return InkWell(
                                  onTap: () {
                                    if (!value!) {
                                      model.editAmountController.text = ProviderScope.containerOf(context)
                                          .read(sendMoneyViewModelProvider)
                                          .currentPinValue;
                                      model.updateEditAmount(true);
                                    }
                                  },
                                  child: Text(
                                    S.of(context).tapToEdit,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0.t,
                                        color: AppColor.very_light_red),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          S.of(context).sendMoney,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0.t),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0.h),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              S.of(context).enterCode +
                                  "\n${ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileCode != null ? (ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileCode!.isNotEmpty ? ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileCode!.replaceAll('00', '+') : '+') : ""}" +
                                  " ${ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileNumber!}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0.t,
                                  color: Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 22.0.h),
                  child: AppSwiper(
                    pages: pages,
                    appSwiperController: model.appSwiperController,
                    pageController: model.pageController,
                    onIndexChanged: (index) {
                      // model.changeCurrentPage(index);
                      model.updatePage(index);
                    },
                    currentStep: currentStep,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

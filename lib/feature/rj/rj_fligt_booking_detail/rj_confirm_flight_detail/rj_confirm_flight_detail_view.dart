import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_confirm_flight_detail/rj_confirm_fight_detail_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/rj/rj_confirm_flight_detail_depart_and_return_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RjConfirmFlightDetailView extends BasePageViewWidget<RjConfirmFlightDetailViewModel> {
  RjConfirmFlightDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
                enabled: isError ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: GestureDetector(
                  /*   onHorizontalDragEnd: (details) {
                    if (ProviderScope.containerOf(context)
                            .read(rjFlightBookingDetailViewModelProvider)
                            .appSwiperController
                            .page ==
                        0.0) {
                      FocusScope.of(context).unfocus();

                      if (StringUtils.isDirectionRTL(context)) {
                        if (details.primaryVelocity!.isNegative) {
                          ProviderScope.containerOf(context)
                              .read(rjFlightBookingDetailViewModelProvider)
                              .previousPage();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(rjFlightBookingDetailViewModelProvider)
                              .nextPage();
                          ProviderScope.containerOf(context)
                              .read(rjMakePaymentViewModelProvider)
                              .addMakePaymentItem(cardList: [
                            MakePaymentCard(
                                cardName: S.of(context).accountCard,
                                cardNo: ProviderScope.containerOf(context)
                                        .read(appHomeViewModelProvider)
                                        .dashboardDataContent
                                        .account
                                        ?.accountNo ??
                                    '',
                                amt: 1000,
                                currency: 'JOD',
                                isSelected: true)
                          ]);
                          ProviderScope.containerOf(context)
                              .read(rjMakePaymentViewModelProvider)
                              .selectedItem(0);
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          ProviderScope.containerOf(context)
                              .read(rjFlightBookingDetailViewModelProvider)
                              .nextPage();
                          ProviderScope.containerOf(context)
                              .read(rjMakePaymentViewModelProvider)
                              .addMakePaymentItem(cardList: [
                            MakePaymentCard(
                                cardName: S.of(context).accountCard,
                                cardNo: ProviderScope.containerOf(context)
                                        .read(appHomeViewModelProvider)
                                        .dashboardDataContent
                                        .account
                                        ?.accountNo ??
                                    '',
                                amt: 1000,
                                currency: 'JOD',
                                isSelected: true)
                          ]);
                          ProviderScope.containerOf(context)
                              .read(rjMakePaymentViewModelProvider)
                              .selectedItem(0);
                        } else {
                          ProviderScope.containerOf(context)
                              .read(rjFlightBookingDetailViewModelProvider)
                              .previousPage();
                        }
                      }
                    }
                  }, */
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                        child: Column(
                          children: [
                            Text(
                              S.of(context).totalAmount,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.t),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).dummyAmount,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).colorScheme.surfaceVariant,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.t),
                                ),
                                SizedBox(
                                  width: 4.h,
                                ),
                                Text(
                                  S.of(context).JOD,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).colorScheme.onInverseSurface,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.t),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Container(
                              color: Theme.of(context).colorScheme.onBackground,
                              height: 1.h,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            RjConfirmFlightDetailDepartAndReturnWidget(
                                title: S.of(context).depart,
                                titleDescription: 'Amman, Jordan (AMM)',
                                toDescription: "Tokyo, Japan",
                                date: S.of(context).purchaseDummyDate.toUpperCase(),
                                time: S.of(context).purchaseDummyTime),
                            SizedBox(
                              height: 16.h,
                            ),
                            RjConfirmFlightDetailDepartAndReturnWidget(
                                title: S.of(context).returnTitle,
                                titleDescription: "Tokyo, Japan",
                                toDescription: 'Amman, Jordan (AMM)',
                                date: S.of(context).purchaseDummyDate.toUpperCase(),
                                time: S.of(context).purchaseDummyTime),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  S.of(context).taxAmount,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.t),
                                ),
                                Spacer(),
                                Text(
                                  '97.750 ',
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.t),
                                ),
                                Text(
                                  S.of(context).JOD,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.t),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  S.of(context).bookingRefNo,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.t),
                                ),
                                Spacer(),
                                Text(
                                  '82292929190099',
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.t),
                                )
                              ],
                            ),
                            Spacer(),
                            AppPrimaryButton(
                              text: S.of(context).next,
                              onPressed: () {
                                ProviderScope.containerOf(context)
                                    .read(rjFlightBookingDetailViewModelProvider)
                                    .nextPage();
                                // ProviderScope.containerOf(context)
                                //     .read(rjMakePaymentViewModelProvider)
                                //     .addMakePaymentItem(cardList: [
                                //   MakePaymentCard(
                                //       cardName: S.of(context).accountCard,
                                //       cardNo: ProviderScope.containerOf(context)
                                //               .read(appHomeViewModelProvider)
                                //               .dashboardDataContent
                                //               .account
                                //               ?.accountNo ??
                                //           '',
                                //       amt: 1000,
                                //       currency: 'JOD',
                                //       isSelected: true)
                                // ]);
                                // ProviderScope.containerOf(context)
                                //     .read(rjMakePaymentViewModelProvider)
                                //     .selectedItem(0);
                              },
                            ),
                            SizedBox(
                              height: 31.h,
                            ),
                            InkWell(
                              onTap: () {
                                InformationDialog.show(context,
                                    image: AssetUtils.cancelFlightIcon,
                                    title: S.of(context).cancelBooking,
                                    descriptionWidget: Text(
                                      S.of(context).cancelBookingDetail,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.surface),
                                    ), onSelected: () {
                                  Navigator.pop(context);
                                }, onDismissed: () {
                                  Navigator.pop(context);
                                });
                                //  Navigator.pop(context);
                              },
                              child: GestureDetector(
                                onTap: () {
                                  InformationDialog.show(context,
                                      title: S.current.cancelBooking,
                                      onDismissed: () => Navigator.pop(context),
                                      isSwipeToCancel: true,
                                      image: AssetUtils.cancelFlightIcon,
                                      onSelected: () {},
                                      descriptionWidget: Text(
                                        S.current.cancelBookingDetail,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).colorScheme.surface,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ));
                                },
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ));
          }),
    );
  }
}

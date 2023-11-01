import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/flight_type_enum.dart';
import 'package:domain/model/rj/get_flight_detail/flight_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_confirm_flight_detail/rj_confirm_fight_detail_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/rj/rj_confirm_flight_detail_depart_and_return_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

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
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                      child: AppStreamBuilder<Resource<FlightDetailResponse>>(
                          stream: model.getFlightDetailsStream,
                          initialData: Resource.none(),
                          onData: (data) {
                            if (data.status == Status.SUCCESS) {
                              model.flightDetailResponse = data.data ?? FlightDetailResponse();
                            }
                          },
                          dataBuilder: (context, flightDetails) {
                            return Column(
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
                                      '${flightDetails?.data?.flightDetailContent?.paymentAmount ?? '0.0'}',
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
                                      '${flightDetails?.data?.flightDetailContent?.paymentCurrency ?? ''}',
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
                                Visibility(
                                  visible: (flightDetails?.data?.flightDetailContent?.flightDetails ?? [])
                                      .isNotEmpty,
                                  child: Column(
                                    children: [
                                      RjConfirmFlightDetailDepartAndReturnWidget(
                                          title: S.of(context).depart,
                                          titleDescription:
                                              flightDetails?.data?.flightDetailContent?.flightDetails?[0].origin ??
                                                  '',
                                          toDescription: flightDetails?.data?.flightDetailContent
                                                  ?.flightDetails?[0].destination ??
                                              '',
                                          date: (flightDetails?.data?.flightDetailContent?.flightDetails?[0].flightDate ?? '')
                                                  .isNotEmpty
                                              ? TimeUtils.getFormattedDateForCreditCard(flightDetails?.data
                                                      ?.flightDetailContent?.flightDetails?[0].flightDate ??
                                                  '')
                                              : '-',
                                          time: (flightDetails?.data?.flightDetailContent?.flightDetails?[0]
                                                          .flightDate ??
                                                      '')
                                                  .isNotEmpty
                                              ? ' - ${TimeUtils.getFormattedTimeForTransaction(flightDetails?.data?.flightDetailContent?.flightDetails?[0].flightDate ?? '')}'
                                              : '-'),
                                      Visibility(
                                        visible: flightDetails?.data?.flightDetailContent?.flightType ==
                                            FlightTypeEnum.RoundTrip,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            (flightDetails?.data?.flightDetailContent?.flightDetails ?? []).length > 1
                                                ? RjConfirmFlightDetailDepartAndReturnWidget(
                                                    title: S.of(context).returnTitle,
                                                    titleDescription: flightDetails?.data?.flightDetailContent
                                                            ?.flightDetails?[1].origin ??
                                                        '',
                                                    toDescription: flightDetails?.data?.flightDetailContent
                                                            ?.flightDetails?[1].destination ??
                                                        '',
                                                    date:
                                                        (flightDetails?.data?.flightDetailContent?.flightDetails?[1].flightDate ?? '').isNotEmpty
                                                            ? TimeUtils.getFormattedDate(flightDetails
                                                                    ?.data
                                                                    ?.flightDetailContent
                                                                    ?.flightDetails?[1]
                                                                    .flightDate ??
                                                                '')
                                                            : '-',
                                                    time: (flightDetails?.data?.flightDetailContent?.flightDetails?[1].flightDate ?? '')
                                                            .isNotEmpty
                                                        ? ' - ${TimeUtils.getFormattedTimeForTransaction(flightDetails?.data?.flightDetailContent?.flightDetails?[1].flightDate ?? '')}'
                                                        : '-')
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).fare,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.t),
                                    ),
                                    Spacer(),
                                    Text(
                                      '-',
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
                                      S.of(context).taxesAndFee,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.t),
                                    ),
                                    Spacer(),
                                    Text(
                                      ' - ',
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
                                      flightDetails?.data?.flightDetailContent?.requestReference ?? '-',
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
                                    ProviderScope.containerOf(context)
                                        .read(rjMakePaymentViewModelProvider)
                                        .addFromAccountData(
                                            account: ProviderScope.containerOf(context)
                                                .read(appHomeViewModelProvider)
                                                .dashboardDataContent
                                                .account!);
                                  },
                                ),
                                SizedBox(
                                  height: 31.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    InformationDialog.show(context,
                                        title: S.current.cancelBooking,
                                        onDismissed: () => Navigator.pop(context),
                                        isSwipeToCancel: true,
                                        image: AssetUtils.cancelFlightIcon,
                                        onSelected: () {
                                          Navigator.of(context)
                                            ..pop()
                                            ..pop();
                                        },
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
                              ],
                            );
                          })),
                ));
          }),
    );
  }
}

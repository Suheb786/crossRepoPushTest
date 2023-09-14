import 'package:domain/model/rj/destination_response.dart';
import 'package:domain/model/rj/get_trip_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../base/base_page.dart';
import '../../../../di/rj/rj_modules.dart';
import '../../../../generated/l10n.dart';
import '../../../../main/navigation/route_paths.dart';
import '../../../../ui/molecules/app_svg.dart';
import '../../../../ui/molecules/button/animated_button.dart';
import '../../../../ui/molecules/button/app_primary_button.dart';
import '../../../../ui/molecules/date_picker.dart';
import '../../../../ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../utils/asset_utils.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';
import '../../../../utils/string_utils.dart';
import '../../../../utils/time_utils.dart';
import '../../rj_booking_in_app_web_view/rj_booking_page.dart';
import '../passenger/passenger_widget.dart';

class RJBookingWidgetView extends StatefulWidget {
  int index;

  RJBookingWidgetView({Key? key, required this.index}) : super(key: key);

  @override
  State<RJBookingWidgetView> createState() => _RJBookingWidgetViewState();
}

class _RJBookingWidgetViewState extends State<RJBookingWidgetView> {
  @override
  Widget build(BuildContext context) {
    var model = ProviderScope.containerOf(context).read(rjFlightBookingPageViewModelProvider);
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              AppTextField(
                labelText: S.of(context).rjFrom.toUpperCase(),
                hintText: S.of(context).fromLabelForRJFlightBooking,
                readOnly: true,
                controller: model.fromController,
                // key: model.fromKey,
              ),
              SizedBox(
                height: 16.h,
              ),
              AppStreamBuilder<Resource<DestinationResponse>>(
                  stream: model.getDestinationStream,
                  initialData: Resource.none(),
                  dataBuilder: (context, destinationResponse) {
                    return AppTextField(
                      labelText: S.of(context).to.toUpperCase(),
                      hintText: S.of(context).pleaseSelect,
                      readOnly: true,
                      controller: model.toController,
                      // key: model.toKey,
                      onPressed: () {
                        /// to dialog for country selection
                        if (destinationResponse?.status == Status.SUCCESS) {
                          ToDialog.show(context,
                              title: S.of(context).to.toUpperCase(),
                              destinationList: destinationResponse?.data?.destinationContent?.destinationList,
                              onDismissed: () {
                            Navigator.pop(context);
                          }, onSelected: (value) {
                            Navigator.pop(context);
                            model.selectedDestination = value;
                            model.toController.text = value.airportName ?? '';
                            model.isValid();
                          });
                        }
                      },
                      suffixIcon: (value, data) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
                          child: AppSvg.asset(AssetUtils.downArrow,
                              width: 16.w, height: 16.h, color: Theme.of(context).primaryColorDark),
                        );
                      },
                    );
                  }),
              SizedBox(
                height: 16.h,
              ),
              AppTextField(
                labelText: S.of(context).departOn.toUpperCase(),
                hintText: S.of(context).invalidPreferredDate,
                readOnly: true,
                controller: model.selectedDepartOnDateController,
                // key: model.selectedDepartOnDateKey,
                onPressed: () {
                  /// opening calender dialog
                  DatePicker.show(context, firstDate: DateTime.now(), initialDate: model.departOnDate,
                      onSelected: (date) {
                    model.selectedDepartOnDateController.text = TimeUtils.getFormattedDOB(date.toString());
                    model.departOnDate = date;
                    model.isValid();
                  }, onCancelled: () {
                    Navigator.pop(context);
                  }, title: S.of(context).preferredDate);
                },
                suffixIcon: (value, data) {
                  return Container(
                      height: 16.h,
                      width: 16.w,
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
                      child: AppSvg.asset(AssetUtils.calendar,
                          height: 16.h, width: 16.w, color: Theme.of(context).primaryColorDark));
                },
              ),
              if (widget.index == 1) ...[
                Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    AppTextField(
                      labelText: S.of(context).returnOn.toUpperCase(),
                      hintText: S.of(context).invalidPreferredDate,
                      readOnly: true,
                      controller: model.selectedReturnOnDateController,
                      onPressed: () {
                        /// opening date dialog
                        DatePicker.show(context, firstDate: DateTime.now(), initialDate: model.returnOnDate,
                            onSelected: (date) {
                          model.selectedReturnOnDateController.text =
                              TimeUtils.getFormattedDOB(date.toString());
                          model.returnOnDate = date;
                          model.isValid();
                        }, onCancelled: () {
                          Navigator.pop(context);
                        }, title: S.of(context).preferredDate);
                      },
                      suffixIcon: (value, data) {
                        return Container(
                          height: 16.h,
                          width: 16.w,
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                          child: AppSvg.asset(AssetUtils.calendar,
                              color: Theme.of(context).colorScheme.surfaceTint),
                        );
                      },
                    ),
                  ],
                )
              ],
              SizedBox(
                height: 32.h,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  S.of(context).cabinClass,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.t,
                      color: Theme.of(context).colorScheme.shadow),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                height: 90.h,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        /// selection cabin class based on index
                        model.selectedCabinClass(index);
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20.00 - 8.w,
                        child: AppStreamBuilder<int>(
                          stream: model.selectedCabinClassSubjectStream,
                          initialData: 0,
                          dataBuilder: (BuildContext context, data) {
                            ///based on index changing cabin class container border color
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: data == index
                                        ? Theme.of(context).colorScheme.onSecondaryContainer
                                        : Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.w),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppSvg.asset(
                                    model.cabinClassOptionList[index].icon,
                                    height: 24,
                                    width: 24,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    model.cabinClassOptionList[index].option,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.t,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).indicatorColor),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, int) {
                    return SizedBox(
                      width: 8.w,
                    );
                  },
                  itemCount: model.cabinClassOptionList.length,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  S.of(context).passengers,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.t,
                      color: Theme.of(context).colorScheme.shadow),
                ),
              ),
              ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PassengerWidget(
                        onTap: (data) {
                          model.passengerList = data;
                        },
                        passengerList: model.passengerList,
                        index: index);
                  },
                  separatorBuilder: (context, int) {
                    return SizedBox(
                      height: 24.h,
                    );
                  },
                  itemCount: model.passengerList.length),
              SizedBox(
                height: 24.h,
              ),
              AppStreamBuilder<Resource<GetTripResponse>>(
                  stream: model.getTwoWayLinkStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      Navigator.pushNamed(context, RoutePaths.RjBookingInAppWebView,
                          arguments: RjBookingPageArguments(url: data.data?.content?.content?.link));
                    }
                  },
                  dataBuilder: (context, getOneWayTripLinkResponse) {
                    return AppStreamBuilder<Resource<GetTripResponse>>(
                        stream: model.getOneWayLinkStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            Navigator.pushNamed(
                              context,
                              RoutePaths.RjBookingInAppWebView,
                              arguments: RjBookingPageArguments(
                                url: data.data?.content?.content?.link,
                              ),
                            );
                          }
                        },
                        dataBuilder: (context, getOneWayTripLinkResponse) {
                          return AppStreamBuilder<bool>(
                              stream: model.allFieldValidatorStream,
                              initialData: false,
                              dataBuilder: (context, isValid) {
                                return AppPrimaryButton(
                                  isDisabled: !isValid!,
                                  onPressed: () {
                                    model.getTripLink(context);
                                  },
                                  text: S.of(context).next,
                                );
                              });
                        });
                  }),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

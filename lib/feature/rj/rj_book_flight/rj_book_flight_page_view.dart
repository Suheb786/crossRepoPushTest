import 'package:domain/model/rj/destination_response.dart';
import 'package:domain/model/rj/get_trip_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/rj_book_flight_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';

import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

import '../../../base/base_page.dart';
import 'passenger_widget.dart';

class RjFlightBookingView extends BasePageViewWidget<RjFlightBookingViewModel> {
  final Function? onDismissed;
  final Function(String)? onSelected;

  RjFlightBookingView(
    ProviderBase model, {
    this.onDismissed,
    this.onSelected,
  }) : super(model);

  @override
  Widget build(BuildContext context, RjFlightBookingViewModel model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        int sensitivity = 8;
        if (details.primaryVelocity! > sensitivity) {
          Navigator.pop(context);
        } else if (details.primaryVelocity! < -sensitivity) {}
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).colorScheme.onSurface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 57.h),
              child: Text(
                S.of(context).bookYourFlight,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 35.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
                        height: 4.h,
                        width: 64.w,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: model.scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 40.0.h, bottom: 10.h),
                                child: Container(
                                  height: 33.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (index == 0) {
                                            /// selection of one-way tab
                                            model.selectedTab(0);
                                            model.isValid();
                                          } else {
                                            /// selection of return tab
                                            model.selectedTab(1);
                                            model.isValid();
                                          }
                                        },
                                        child: Container(
                                          width: 60.w,
                                          child: Column(
                                            children: [
                                              AppStreamBuilder<int>(
                                                initialData: 0,
                                                stream: model.selectedTabStream,
                                                dataBuilder: (BuildContext context, data) {
                                                  /// changing tab indicator color based on data variable
                                                  return data == index
                                                      ? Column(
                                                          children: [
                                                            Text(
                                                              model
                                                                  .rjBookingFlightTabOptionList[index].option,
                                                              style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Theme.of(context).primaryColorDark,
                                                                  fontSize: 14.t),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Container(
                                                              height: 2.h,
                                                              color: Theme.of(context).primaryColor,
                                                            )
                                                          ],
                                                        )
                                                      : Column(
                                                          children: [
                                                            Text(
                                                              model
                                                                  .rjBookingFlightTabOptionList[index].option,
                                                              style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Theme.of(context)
                                                                      .colorScheme
                                                                      .onInverseSurface,
                                                                  fontSize: 14.t),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Container(),
                                                          ],
                                                        );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, int) {
                                      return SizedBox(
                                        width: 20.w,
                                      );
                                    },
                                    itemCount: model.rjBookingFlightTabOptionList.length,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              AppTextField(
                                labelText: S.of(context).rjFrom.toUpperCase(),
                                hintText: S.of(context).fromLabelForRJFlightBooking,
                                readOnly: true,
                                controller: model.fromController,
                                key: model.fromKey,
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
                                      key: model.toKey,
                                      onPressed: () {
                                        /// to dialog for country selection
                                        if (destinationResponse?.status == Status.SUCCESS) {
                                          ToDialog.show(context,
                                              title: S.of(context).to.toUpperCase(),
                                              destinationList: destinationResponse?.data?.destinationContent
                                                  ?.destinationList, onDismissed: () {
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
                                              width: 16.w,
                                              height: 16.h,
                                              color: Theme.of(context).primaryColorDark),
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
                                key: model.selectedDepartOnDateKey,
                                onPressed: () {
                                  /// opening calender dialog
                                  DatePicker.show(context,
                                      firstDate: DateTime.now(),
                                      initialDate: model.departOnDate, onSelected: (date) {
                                    model.selectedDepartOnDateController.text =
                                        TimeUtils.getFormattedDOB(date.toString());
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
                                          height: 16.h,
                                          width: 16.w,
                                          color: Theme.of(context).primaryColorDark));
                                },
                              ),
                              AppStreamBuilder(
                                initialData: 0,
                                stream: model.selectedTabStream,
                                dataBuilder: (BuildContext context, data) {
                                  /// based on index hiding return field in the dialog
                                  return data == 1
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            AppTextField(
                                              labelText: S.of(context).returnOn.toUpperCase(),
                                              hintText: S.of(context).invalidPreferredDate,
                                              readOnly: true,
                                              controller: model.selectedReturnOnDateController,
                                              key: model.selectedReturnOnDateKey,
                                              onPressed: () {
                                                /// opening date dialog
                                                DatePicker.show(context,
                                                    firstDate: DateTime.now(),
                                                    initialDate: model.returnOnDate, onSelected: (date) {
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
                                                  padding:
                                                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                                  child: AppSvg.asset(AssetUtils.calendar,
                                                      color: Theme.of(context).colorScheme.surfaceTint),
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      : Container();
                                },
                              ),
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
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        /// selection cabin class based on index
                                        model.selectedCabinClass(index);
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 2.15.w,
                                        child: AppStreamBuilder<int>(
                                          stream: model.selectedCabinClassSubjectStream,
                                          initialData: 0,
                                          dataBuilder: (BuildContext context, data) {
                                            ///based on index changing cabin class container border color
                                            return data == index
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .onSecondaryContainer,
                                                        ),
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(8.w),
                                                        )),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset(
                                                          model.cabinClassOptionList[index].icon,
                                                          height: 24.h,
                                                          width: 24.h,
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
                                                  )
                                                : Container(
                                                    // width: 142.w,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Theme.of(context).colorScheme.inverseSurface,
                                                        ),
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(8.w),
                                                        )),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset(
                                                          model.cabinClassOptionList[index].icon,
                                                          height: 24.h,
                                                          width: 24.h,
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
                                height: 32.h,
                              ),
                              GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  if (details.primaryVelocity!.isNegative) {
                                    model.getTripLink(context);
                                  }
                                },
                                child: AppStreamBuilder<Resource<GetTripResponse>>(
                                    stream: model.getTwoWayLinkStream,
                                    initialData: Resource.none(),
                                    onData: (data) {
                                      if (data.status == Status.SUCCESS) {
                                        Navigator.pushNamed(context, RoutePaths.RjBookingInAppWebView,
                                            arguments: RjBookingPageArguments(
                                                url: data.data?.content?.content?.link));
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
                                                  return (isValid!)
                                                      ? AnimatedButton(
                                                          buttonText: S.of(context).swipeToProceed,
                                                          borderColor: Theme.of(context)
                                                              .colorScheme
                                                              .onSecondaryContainer,
                                                          textColor: Theme.of(context)
                                                              .colorScheme
                                                              .onSecondaryContainer,
                                                        )
                                                      : Container();
                                                });
                                          });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:domain/model/rj/destination_response.dart';
import 'package:domain/model/rj/get_trip_response.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/passenger_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RjFlightBookingDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  RjFlightBookingDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return rjFlightBookingDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RjFlightBookingDialogViewModel>(
      providerBase: providerBase(),
      onModelReady: (model) {
        model.getDestination();

        model.loadingStream.listen((value) {
          if (value) {
            AppProgress(context);
          } else {
            Navigator.pop(context);
          }
        });

        model.error.listen((event) {
          _showTopError(
              ErrorParser.getLocalisedStringError(
                error: event,
                localisedHelper: S.of(context),
              ),
              context);
          // if (event.type == ErrorType.UNAUTHORIZED_USER) {
          //   _showTopError(
          //       ErrorParser.getLocalisedStringError(
          //         error: event,
          //         localisedHelper: S.of(context),
          //       ),
          //       context);
          //   Navigator.pushNamedAndRemoveUntil(
          //       context, RoutePaths.OnBoarding, ModalRoute.withName(RoutePaths.Splash));
          // } else {
          //   _showTopError(
          //       ErrorParser.getLocalisedStringError(
          //         error: event,
          //         localisedHelper: S.of(context),
          //       ),
          //       context);
          // }
        });
      },
      builder: (context, model, child) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            insetPadding: EdgeInsets.only(left: 48.w, right: 48.w, bottom: 56.h, top: 204.0.h),
            child: Column(
              children: [
                Expanded(
                  child: FadingEdgeScrollView.fromSingleChildScrollView(
                    gradientFractionOnStart: 0.2,
                    gradientFractionOnEnd: 0.2,
                    child: SingleChildScrollView(
                      controller: model!.scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 40.0.h, bottom: 10.h),
                            child: Container(
                              height: 33,
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
                                                          model.rjBookingFlightTabOptionList[index].option,
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontWeight: FontWeight.w600,
                                                              color: AppColor.darkBlack,
                                                              fontSize: 14.t),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Container(
                                                          height: 2.h,
                                                          color: Colors.red,
                                                        )
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Text(
                                                          model.rjBookingFlightTabOptionList[index].option,
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontWeight: FontWeight.w600,
                                                              color: AppColor.gray1,
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
                                          destinationList: destinationResponse
                                              ?.data?.destinationContent?.destinationList, onDismissed: () {
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
                                            width: 16.w, height: 16.h, color: AppColor.dark_gray_1));
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
                                      height: 16.h, width: 16.w, color: AppColor.dark_gray_1));
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
                                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                                child: AppSvg.asset(AssetUtils.calendar,
                                                    color: AppColor.dark_gray_1));
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
                                  color: AppColor.gray_black),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            height: 79.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    /// selection cabin class based on index
                                    model.selectedCabinClass(index);
                                  },
                                  child: AppStreamBuilder<int>(
                                    stream: model.selectedCabinClassSubjectStream,
                                    initialData: 0,
                                    dataBuilder: (BuildContext context, data) {
                                      ///based on index changing cabin class container border color
                                      return data == index
                                          ? Container(
                                              width: 112.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: AppColor.brightBlue),
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
                                                        color: AppColor.veryDarkGray2),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container(
                                              width: 112.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: AppColor.white_gray),
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
                                                        color: AppColor.veryDarkGray2),
                                                  )
                                                ],
                                              ),
                                            );
                                    },
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
                                  color: AppColor.gray_black),
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
                                        arguments:
                                            RjBookingPageArguments(url: data.data?.content?.content?.link));
                                  }
                                },
                                dataBuilder: (context, getOneWayTripLinkResponse) {
                                  return AppStreamBuilder<Resource<GetTripResponse>>(
                                      stream: model.getOneWayLinkStream,
                                      initialData: Resource.none(),
                                      onData: (data) {
                                        if (data.status == Status.SUCCESS) {
                                          Navigator.pushNamed(context, RoutePaths.RjBookingInAppWebView,
                                              arguments: RjBookingPageArguments(
                                                  url: data.data?.content?.content?.link));
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
                                                      borderColor: AppColor.brightBlue,
                                                      textColor: AppColor.brightBlue,
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
                ),
                SizedBox(
                  height: 32.h,
                ),
                Container(
                  color: AppColor.white.withOpacity(0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          onSelected?.call('');
                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(top: 0.0, bottom: 32.h),
                          child: Center(
                            child: Text(
                              S.of(context).cancel,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.t,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.brightBlue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        context,
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
              decoration: BoxDecoration(color: AppColor.dark_brown, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).error,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0.t),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0.h, right: 16.0.w),
                          child: Text(message,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  // fontFamily: "Montserrat",
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.t)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1500),
        hideOutAnimationDuration: Duration(milliseconds: 500),
        showOutAnimationDuration: Duration(milliseconds: 700));
  }
}

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
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
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

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
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            insetPadding: EdgeInsets.only(left: 48, right: 48, bottom: 36, top: 204),
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  onDismissed?.call();
                }
              },
              child: Column(
                children: [
                  Expanded(
                    child: FadingEdgeScrollView.fromSingleChildScrollView(
                      gradientFractionOnStart: 0.2,
                      gradientFractionOnEnd: 0.2,
                      child: SingleChildScrollView(
                        controller: model!.scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(top: 40.0, bottom: 10),
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
                                        } else {
                                          /// selection of return tab
                                          model.selectedTab(1);
                                        }
                                      },
                                      child: Container(
                                        width: 60,
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
                                                                fontSize: 14),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            height: 2,
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
                                                                fontSize: 14),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
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
                                      width: 20,
                                    );
                                  },
                                  itemCount: model.rjBookingFlightTabOptionList.length,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            AppTextField(
                              labelText: S.of(context).rjFrom.toUpperCase(),
                              hintText: S.of(context).fromLabelForRJFlightBooking,
                              readOnly: false,
                              controller: model.fromController,
                              key: model.fromKey,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            AppTextField(
                              labelText: S.of(context).to.toUpperCase(),
                              hintText: S.of(context).pleaseSelect,
                              readOnly: true,
                              controller: model.toController,
                              key: model.toKey,
                              onPressed: () {
                                /// to dialog for country selection

                                ToDialog.show(context, title: S.of(context).to.toUpperCase(),
                                    onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.toController.text = value.searchCountry;
                                });
                              },
                              suffixIcon: (value, data) {
                                return Container(
                                    height: 16,
                                    width: 16,
                                    padding: EdgeInsetsDirectional.only(end: 8),
                                    child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            AppTextField(
                              labelText: S.of(context).departOn.toUpperCase(),
                              hintText: S.of(context).invalidPreferredDate,
                              readOnly: true,
                              controller: model.selectedDepartOnDateController,
                              key: model.selectedDepartOnDateKey,
                              onPressed: () {
                                /// opening calender dialog
                                DatePicker.show(context, initialDate: model.initialDate, onSelected: (date) {
                                  model.selectedDepartOnDateController.text =
                                      TimeUtils.getFormattedDOB(date.toString());
                                  model.initialDate = date;
                                }, onCancelled: () {
                                  Navigator.pop(context);
                                }, title: S.of(context).preferredDate);
                              },
                              suffixIcon: (value, data) {
                                return Container(
                                    height: 16,
                                    width: 16,
                                    padding: EdgeInsetsDirectional.only(end: 8),
                                    child: AppSvg.asset(AssetUtils.calendar, color: AppColor.dark_gray_1));
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
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText: S.of(context).returnOn.toUpperCase(),
                                            hintText: S.of(context).invalidPreferredDate,
                                            readOnly: true,
                                            controller: model.selectedReturnOnDateController,
                                            key: model.selectedReturnOnDateKey,
                                            onPressed: () {
                                              /// opening date dialog
                                              DatePicker.show(context, initialDate: model.initialDate,
                                                  onSelected: (date) {
                                                model.selectedReturnOnDateController.text =
                                                    TimeUtils.getFormattedDOB(date.toString());
                                                model.initialDate = date;
                                              }, onCancelled: () {
                                                Navigator.pop(context);
                                              }, title: S.of(context).preferredDate);
                                            },
                                            suffixIcon: (value, data) {
                                              return Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding: EdgeInsetsDirectional.only(end: 8),
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
                              height: 32,
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                S.of(context).cabinClass,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColor.gray_black),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 79,
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
                                                width: 112,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: AppColor.brightBlue),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(8),
                                                    )),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(model.cabinClassOptionList[index].icon),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      model.cabinClassOptionList[index].option,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColor.veryDarkGray2),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                width: 112,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: AppColor.white_gray),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(8),
                                                    )),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(model.cabinClassOptionList[index].icon),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      model.cabinClassOptionList[index].option,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 12,
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
                                    width: 8,
                                  );
                                },
                                itemCount: model.cabinClassOptionList.length,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                S.of(context).passengers,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColor.gray_black),
                              ),
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return PassengerWidget(passengerList: model.passengerList, index: index);
                                },
                                separatorBuilder: (context, int) {
                                  return SizedBox(
                                    height: 24,
                                  );
                                },
                                itemCount: model.passengerList.length),
                            SizedBox(
                              height: 32,
                            ),
                            GestureDetector(
                              onHorizontalDragEnd: (details) {
                                if (details.primaryVelocity!.isNegative) {
                                  //  Navigator.pushNamed(context, RoutePaths.RjFlightBookingDetailPage);
                                  Navigator.pushNamed(context, RoutePaths.RjBookingInAppWebView,
                                      arguments: RjBookingPageArguments('https://www.google.co.in/'));
                                }
                              },
                              child: AnimatedButton(
                                buttonText: S.of(context).swipeToProceed,
                                borderColor: AppColor.brightBlue,
                                textColor: AppColor.brightBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
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
                            padding: const EdgeInsetsDirectional.only(top: 0.0, bottom: 32),
                            child: Center(
                              child: Text(
                                S.of(context).cancel,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 14,
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
              ),
            ));
      },
    );
  }
}

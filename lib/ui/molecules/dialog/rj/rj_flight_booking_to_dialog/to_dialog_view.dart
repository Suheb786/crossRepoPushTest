import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/rj/destinations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/to_selected_country_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../app_scollable_list_view_widget.dart';
import '../../../button/app_primary_button.dart';

class ToDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(Destinations)? onSelected;
  final String? title;
  List<Destinations>? destinationList;

  bool _keyboardVisible = false;

  ToDialogView({this.onDismissed, this.onSelected, this.title, this.destinationList});

  ProviderBase providerBase() {
    return toDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<ToDialogViewModel>(
        builder: (context, model, child) {
          return Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: AnimatedContainer(
              margin: EdgeInsets.only(bottom: _keyboardVisible ? 0 : 56.h),
              duration: Duration(milliseconds: 100),
              child: Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  insetPadding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      bottom: _keyboardVisible ? 30.h : 56.h,
                      top: MediaQuery.of(context).padding.top + 35.h /*top: _keyboardVisible ? 36.h : 204.h*/
                      ),
                  child: AppStreamBuilder<Resource<List<Destinations>>>(
                    stream: model!.toSearchCountryStream,
                    initialData: Resource.none(),
                    dataBuilder: (context, data) {
                      return AppKeyBoardHide(
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomCenter,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 32.0.h),
                                  child: Center(
                                    child: Text(
                                      title!,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                                  child: AppTextField(
                                    labelText: '',
                                    controller: model.countrySearchController,
                                    textFieldBorderColor: AppColor.gray_1,
                                    hintTextColor: AppColor.gray_2,
                                    textColor: AppColor.black,
                                    hintText: S.of(context).searchCountry,
                                    containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                    onChanged: (value) {
                                      model.typeSearchCountry(value);
                                    },
                                    suffixIcon: (value, data) {
                                      return InkWell(
                                        onTap: () async {},
                                        child: Container(
                                            height: 16.h,
                                            width: 16.w,
                                            padding: EdgeInsets.all(6),
                                            child: AppSvg.asset(AssetUtils.search,
                                                color: Theme.of(context).primaryColorDark)),
                                      );
                                    },
                                  ),
                                ),
                                data!.status == Status.SUCCESS
                                    ? Expanded(
                                        child: data.data!.length > 0
                                            ? Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                                    child: Container(
                                                      height: 64.h,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(16),
                                                        color: AppColor.vividYellow,
                                                      ),
                                                    ),
                                                  ),
                                                  AppScrollableListViewWidget(
                                                    key: ValueKey(data.data!.length),
                                                    child: ClickableListWheelScrollView(
                                                      scrollController: model.scrollController,
                                                      itemHeight: 72.h,
                                                      itemCount: data.data!.length,
                                                      onItemTapCallback: (index) {
                                                        model.selectCountry(index);
                                                      },
                                                      child: ListWheelScrollView.useDelegate(
                                                          controller: model.scrollController,
                                                          itemExtent: 72,
                                                          onSelectedItemChanged: (int index) {
                                                            model.selectCountry(index);
                                                          },
                                                          physics: FixedExtentScrollPhysics(),
                                                          perspective: 0.0000000001,
                                                          childDelegate: ListWheelChildBuilderDelegate(
                                                              childCount: data.data!.length,
                                                              builder: (BuildContext context, int index) {
                                                                return ToSelectedCountryListWidget(
                                                                  item: data.data![index],
                                                                );
                                                              })),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Center(
                                                child: Text(
                                                  S.of(context).noDataFound,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14.t,
                                                      fontWeight: FontWeight.w400,
                                                      color: Theme.of(context).primaryColorDark),
                                                ),
                                              ))
                                    : Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  AssetUtils.BigSearchIcon,
                                                  height: 96.h,
                                                  width: 96.w,
                                                ),
                                                SizedBox(
                                                  height: 16.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 48.w, end: 48.w),
                                                  child: Text(
                                                    S.of(context).rjFlightBookingToDialogBoxDescription,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        color: AppColor.gray_black,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 42.h),
                                  child: AppPrimaryButton(
                                    onPressed: () {
                                      if (data.data != null && data.data!.length > 0) {
                                        onSelected!.call(model.selectedDestination);
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    text: S.of(context).confirm,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: -24.h,
                              child: InkWell(
                                onTap: () {
                                  onDismissed?.call();
                                },
                                child: Container(
                                    height: 48.h,
                                    width: 48.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).colorScheme.secondary),
                                    child: Image.asset(
                                      AssetUtils.close_bold,
                                      scale: 3.5,
                                    )),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )),
            ),
          );
        },
        onModelReady: (model) {
          model.addSearchList(destinationList ?? []);
        },
        providerBase: providerBase());
  }
}

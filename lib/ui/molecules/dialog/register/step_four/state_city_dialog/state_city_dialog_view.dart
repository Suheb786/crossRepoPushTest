import 'package:neo_bank/utils/clickable_scrall_view/list_wheel_scrall_view.dart';
import 'package:domain/model/country/state_list/state_city_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class StateCityDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(StateCityData)? onSelected;
  final StateCityTypeEnum? stateCityTypeEnum;
  final String? title;
  final List<StateCityData>? stateCityData;
  bool _keyboardVisible = false;
  final bool onWillPop;

  StateCityDialogView(
      {this.onDismissed,
      this.onSelected,
      this.stateCityTypeEnum,
      this.title,
      this.stateCityData,
      this.onWillPop = true});

  ProviderBase providerBase() {
    return stateCityDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<StateCityDialogViewModel>(
          builder: (context, model, child) {
            return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                insetPadding: EdgeInsets.only(
                    left: 24.w, right: 24.w, bottom: 56.h, top: _keyboardVisible ? 36.h : 204.h),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    AppKeyBoardHide(
                      child: AppStreamBuilder<int>(
                        stream: model!.currentIndexStream,
                        initialData: 0,
                        dataBuilder: (context, currentIndex) {
                          return AppStreamBuilder<Resource<List<StateCityData>>>(
                              stream: model.stateCityResponseStream,
                              initialData: Resource.none(),
                              dataBuilder: (context, stateCityResponse) {
                                return Column(
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
                                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                                      child: AppTextField(
                                        labelText: '',
                                        controller: model.controller,
                                        textFieldBorderColor: AppColor.gray_1,
                                        hintTextColor: AppColor.gray_2,
                                        textColor: AppColor.black,
                                        containerPadding:
                                            EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                        hintText: getHintText(stateCityTypeEnum, context),
                                        onChanged: (value) {
                                          model.searchStateCity(value, stateCityTypeEnum!);
                                        },
                                        suffixIcon: (value, data) {
                                          return InkWell(
                                            onTap: () async {},
                                            child: Container(
                                                height: 16.h,
                                                width: 16.w,
                                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                                                child: AppSvg.asset(AssetUtils.search)),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        child: stateCityResponse!.data!.length > 0
                                            ? Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                                    child: Container(
                                                      height: 64.h,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(16.w),
                                                        color: AppColor.vividYellow,
                                                      ),
                                                    ),
                                                  ),
                                                  AppScrollableListViewWidget(
                                                    key: ValueKey(stateCityResponse.data!.length),
                                                    child: ClickableListWheelScrollView(
                                                      scrollController: model.scrollController,
                                                      itemHeight: 64.h,
                                                      itemCount: stateCityResponse.data!.length,
                                                      onItemTapCallback: (index) {
                                                        model.selectCountry(index);
                                                      },
                                                      child: ListWheelScrollView.useDelegate(
                                                          controller: model.scrollController,
                                                          itemExtent: 64.h,
                                                          onSelectedItemChanged: (int index) {
                                                            model.selectCountry(index);
                                                          },
                                                          physics: FixedExtentScrollPhysics(),
                                                          perspective: 0.0000000001,
                                                          childDelegate: ListWheelChildBuilderDelegate(
                                                              childCount: stateCityResponse.data!.length,
                                                              builder: (BuildContext context, int index) {
                                                                return ListScrollWheelListWidget(
                                                                  label: stateCityTypeEnum ==
                                                                          StateCityTypeEnum.CITY
                                                                      ? stateCityResponse
                                                                          .data![index].cityName!
                                                                      : stateCityResponse
                                                                          .data![index].stateName!,
                                                                  textColor: stateCityResponse
                                                                          .data![index].isSelected
                                                                      ? Theme.of(context).primaryColorDark
                                                                      : AppColor.dark_gray_1,
                                                                  widgetColor: Colors.transparent,
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
                                              )),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                                      child: AppPrimaryButton(
                                        // isDisabled: isValid!,
                                        isDisabled: false,

                                        onPressed: () {
                                          onSelected!.call(model.selectedState);
                                        },

                                        text: S.of(context).confirm,
                                      ),
                                    ),
                                    SizedBox(height: 40.h),
                                  ],
                                );
                              });
                        },
                      ),
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
                    ),
                  ],
                ));
          },
          onModelReady: (model) {
            if (model.stateCityDataList.isEmpty) {
              model.setData(stateCityData!);
            }
          },
          providerBase: providerBase()),
    );
  }

  getHintText(StateCityTypeEnum? stateCityTypeEnum, BuildContext context) {
    switch (stateCityTypeEnum) {
      case StateCityTypeEnum.STATE:
        return S.of(context).searchState;
      case StateCityTypeEnum.CITY:
        return S.of(context).searchCity;
      default:
        return S.of(context).searchCity;
    }
  }
}

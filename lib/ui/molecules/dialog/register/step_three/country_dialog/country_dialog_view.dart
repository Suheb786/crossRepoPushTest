import 'package:neo_bank/ui/no_data_widget.dart';
import 'package:neo_bank/utils/clickable_scrall_view/list_wheel_scrall_view.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/employer_country_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../app_scollable_list_view_widget.dart';

class CountryDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(CountryData)? onSelected;
  final String? title;
  bool _keyboardVisible = false;

  CountryDialogView({this.onDismissed, this.onSelected, this.title});

  ProviderBase providerBase() {
    return employerCountryDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<CountryDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(
                  left: 24.0.w, right: 24.0.w, bottom: 36.0.h, top: _keyboardVisible ? 36.0.h : 204.0.h),
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    onDismissed?.call();
                  }
                },
                // onVerticalDragEnd: (details) {
                //   if (details.primaryVelocity!.isNegative) {
                //     onDismissed?.call();
                //   }
                // },
                child: AppStreamBuilder<int>(
                  stream: model!.currentIndexStream,
                  initialData: 0,
                  dataBuilder: (context, currentIndex) {
                    return AppStreamBuilder<Resource<List<CountryData>>>(
                      stream: model.getCountryListStream,
                      initialData: Resource.none(),
                      dataBuilder: (context, data) {
                        return AppKeyBoardHide(
                          child: Column(
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
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 14.0.t,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 32.0.h),
                                child: AppTextField(
                                  labelText: '',
                                  controller: model.countrySearchController,
                                  textFieldBorderColor: AppColor.gray_1,
                                  hintTextColor: AppColor.gray_2,
                                  textColor: AppColor.black,
                                  hintText: S.of(context).searchCountry,
                                  containerPadding:
                                      EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                                  onChanged: (value) {
                                    model.searchCountry(value);
                                  },
                                  suffixIcon: (value, data) {
                                    return InkWell(
                                      onTap: () async {},
                                      child: Container(
                                          height: 16.0.h,
                                          width: 16.0.w,
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
                                                    height: 64.0.h,
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
                                                    itemHeight: 72.0.h,
                                                    itemCount: data.data!.length,
                                                    onItemTapCallback: (index) {
                                                      model.selectCountry(index);
                                                    },
                                                    child: ListWheelScrollView.useDelegate(
                                                        controller: model.scrollController,
                                                        itemExtent: 72.0.h,
                                                        onSelectedItemChanged: (int index) {
                                                          model.selectCountry(index);
                                                        },
                                                        physics: FixedExtentScrollPhysics(),
                                                        perspective: 0.0000000001,
                                                        childDelegate: ListWheelChildBuilderDelegate(
                                                            childCount: data.data!.length,
                                                            builder: (BuildContext context, int index) {
                                                              return EmployerCountryListWidget(
                                                                item: data.data![index],
                                                              );
                                                            })),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Center(
                                              child: NoDataWidget(
                                                errorMessage: S.of(context).noCountriesFound,
                                              ),
                                            ))
                                  : Expanded(
                                      child: Container(),
                                    ),
                              InkWell(
                                onTap: () {
                                  onSelected!.call(model.selectedCountry!);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                                  height: 57.0.h,
                                  width: 57.0.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).textTheme.bodyLarge!.color!),
                                  child: AppSvg.asset(AssetUtils.tick,
                                      color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0.h, bottom: 16.0.h),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      //onDismissed?.call();
                                    },
                                    child: Text(
                                      S.of(context).swipeDownToCancel,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 10.0.t,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.dark_gray_1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ));
        },
        onModelReady: (model) {
          if (!model.isApiCalled) {
            model.isApiCalled = true;
            model.getCountries();

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
            });
          }
        },
        providerBase: providerBase());
  }

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
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
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.t)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1500),
        reverseAnimationDuration: Duration(milliseconds: 500),
        animationDuration: Duration(milliseconds: 700));
  }
}

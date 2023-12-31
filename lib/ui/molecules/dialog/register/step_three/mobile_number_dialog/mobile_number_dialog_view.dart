import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/mobile_number_dialog/mobile_number_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/allowed_mobile_number_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/clickable_scrall_view/list_wheel_scrall_view.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../../no_data_widget.dart';
import '../../../../app_scollable_list_view_widget.dart';

// ignore: must_be_immutable
class MobileNumberDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(CountryData)? onSelected;
  final String? title;
  final List<CountryData> countryDataList;
  bool _keyboardVisible = false;
  final CountryData selectedCountryData;
  final bool onWillPop;

  MobileNumberDialogView(
      {this.onDismissed,
      this.onSelected,
      this.title,
      required this.selectedCountryData,
      required this.countryDataList,
      this.onWillPop = true});

  ProviderBase providerBase() {
    return mobileNumberDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<MobileNumberDialogViewModel>(
          builder: (context, model, child) {
            return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                insetPadding: EdgeInsets.only(
                    left: 24.0.w, right: 24.0.w, bottom: 56.0.h, top: _keyboardVisible ? 36.0.h : 204.0.h),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    AppKeyBoardHide(
                      child: AppStreamBuilder<int>(
                        stream: model!.currentIndexStream,
                        initialData: 0,
                        dataBuilder: (context, currentIndex) {
                          return AppStreamBuilder<Resource<List<CountryData>>>(
                            stream: model.getAllowedCountryCodeStream,
                            initialData: Resource.none(),
                            dataBuilder: (context, data) {
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
                                            fontSize: 14.0.t,
                                            color: Theme.of(context).indicatorColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 32.0.h),
                                    child: AppTextField(
                                      labelText: '',
                                      controller: model.mobileNumberSearchController,
                                      textFieldBorderColor: AppColor.gray_1,
                                      hintTextColor: AppColor.gray_2,
                                      textColor: Theme.of(context).primaryColorDark,
                                      hintText: S.of(context).searchCountry,
                                      containerPadding:
                                          EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                                      onChanged: (value) {
                                        model.searchMobileNumber(value);
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
                                  Expanded(
                                      child: data!.data!.length > 0
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
                                                      model.selectMobileNumber(index);
                                                    },
                                                    child: ListWheelScrollView.useDelegate(
                                                        controller: model.scrollController,
                                                        itemExtent: 72.0.h,
                                                        onSelectedItemChanged: (int index) {
                                                          model.selectMobileNumber(index);
                                                        },
                                                        physics: FixedExtentScrollPhysics(),
                                                        perspective: 0.0000000001,
                                                        childDelegate: ListWheelChildBuilderDelegate(
                                                            childCount: data.data!.length,
                                                            builder: (BuildContext context, int index) {
                                                              return AllowedMobileNumberListWidget(
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
                                            )),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 40.h, left: 24.w, right: 24.w, top: 16.h),
                                    child: AppPrimaryButton(
                                      onPressed: () {
                                        onSelected!.call(model.selectedCountryData!);
                                      },
                                      text: S.of(context).confirm,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
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
            if (model.allCountryList == null || model.allCountryList!.isEmpty) {
              model.setResponse(countryDataList, selectedCountryData);
            }
          },
          providerBase: providerBase()),
    );
  }
}

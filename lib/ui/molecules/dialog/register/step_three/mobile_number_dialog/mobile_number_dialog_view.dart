import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/mobile_number_dialog/mobile_number_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/allowed_mobile_number_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

import '../../../../app_scollable_list_view_widget.dart';

class MobileNumberDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(CountryData)? onSelected;
  final String? title;
  final List<CountryData> countryDataList;
  bool _keyboardVisible = false;
  final CountryData selectedCountryData;

  MobileNumberDialogView(
      {this.onDismissed,
      this.onSelected,
      this.title,
      required this.selectedCountryData,
      required this.countryDataList});

  ProviderBase providerBase() {
    return mobileNumberDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<MobileNumberDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 36,
                  top: _keyboardVisible ? 36 : 204),
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    onDismissed?.call();
                  }
                },
                child: AppKeyBoardHide(
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
                                padding: const EdgeInsets.only(top: 32.0),
                                child: Center(
                                  child: Text(
                                    title!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 32),
                                child: AppTextField(
                                  labelText: '',
                                  controller:
                                      model.mobileNumberSearchController,
                                  textFieldBorderColor: AppColor.gray_1,
                                  hintTextColor: AppColor.gray_2,
                                  textColor: Theme.of(context).primaryColorDark,
                                  hintText: S.of(context).searchCountry,
                                  containerPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  onChanged: (value) {
                                    print(value);
                                    model.searchMobileNumber(value);
                                  },
                                  suffixIcon: (value, data) {
                                    return InkWell(
                                      onTap: () async {},
                                      child: Container(
                                          height: 16,
                                          width: 16,
                                          padding: EdgeInsets.all(6),
                                          child: AppSvg.asset(AssetUtils.search,
                                              color: Theme.of(context)
                                                  .primaryColorDark)),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Container(
                                                height: 64,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: AppColor.vividYellow,
                                                ),
                                              ),
                                            ),
                                            AppScrollableListViewWidget(
                                              key: ValueKey(data.data!.length),
                                              child:
                                                  ClickableListWheelScrollView(
                                                scrollController:
                                                    model.scrollController,
                                                itemHeight: 72,
                                                itemCount: data.data!.length,
                                                onItemTapCallback: (index) {
                                                  model.selectMobileNumber(
                                                      index);
                                                },
                                                child: ListWheelScrollView
                                                    .useDelegate(
                                                        controller: model
                                                            .scrollController,
                                                        itemExtent: 72,
                                                        onSelectedItemChanged:
                                                            (int index) {
                                                          model
                                                              .selectMobileNumber(
                                                                  index);
                                                        },
                                                        physics:
                                                            FixedExtentScrollPhysics(),
                                                        perspective:
                                                            0.0000000001,
                                                        childDelegate:
                                                            ListWheelChildBuilderDelegate(
                                                                childCount: data
                                                                    .data!
                                                                    .length,
                                                                builder: (BuildContext
                                                                        context,
                                                                    int index) {
                                                                  return AllowedMobileNumberListWidget(
                                                                    item: data
                                                                            .data![
                                                                        index],
                                                                  );
                                                                })),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Center(
                                          child: Text(
                                            S.of(context).noCountriesFound,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.dark_violet_4),
                                          ),
                                        )),
                              GestureDetector(
                                onVerticalDragEnd: (details) {
                                  if (!details.primaryVelocity!.isNegative) {
                                    onDismissed?.call();
                                  }
                                },
                                child: Container(
                                  color: AppColor.white.withOpacity(0),
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          onSelected!
                                              .call(model.selectedCountryData!);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          height: 57,
                                          width: 57,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1!
                                                  .color!),
                                          child: AppSvg.asset(AssetUtils.tick,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          onDismissed?.call();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 16),
                                          child: Center(
                                            child: Text(
                                              S.of(context).swipeDownToCancel,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.dark_gray_1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ));
        },
        onModelReady: (model) {
          if (model.allCountryList == null || model.allCountryList!.isEmpty) {
            model.setResponse(countryDataList,selectedCountryData);
          }
        },
        providerBase: providerBase());
  }
}

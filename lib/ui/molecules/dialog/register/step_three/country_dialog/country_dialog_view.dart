import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:neo_bank/utils/status.dart';
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 36,
                  top: _keyboardVisible ? 36 : 204),
              child: AppStreamBuilder<int>(
                stream: model!.currentIndexStream,
                initialData: 0,
                dataBuilder: (context, currentIndex) {
                  return SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: AppStreamBuilder<Resource<List<CountryData>>>(
                      stream: model.getCountryListStream,
                      initialData: Resource.none(),
                      dataBuilder: (context, data) {
                        switch (data!.status) {
                          case Status.SUCCESS:
                            return AppKeyBoardHide(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 32.0),
                                    child: Center(
                                      child: Text(
                                        title!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 32),
                                    child: AppTextField(
                                      labelText: '',
                                      controller: model.countrySearchController,
                                      textFieldBorderColor: AppColor.gray_1,
                                      hintTextColor: AppColor.gray_2,
                                      textColor: AppColor.black,
                                      hintText: S.of(context).searchCountry,
                                      onChanged: (value) {
                                        print(value);
                                        model.searchCountry(value);
                                      },
                                      suffixIcon: (value, data) {
                                        return InkWell(
                                          onTap: () async {},
                                          child: Container(
                                              height: 16,
                                              width: 16,
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                              child: AppSvg.asset(
                                                  AssetUtils.search)),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: data.data!.length > 0
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16.0),
                                                  child: Container(
                                                    height: 64,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color:
                                                          AppColor.vividYellow,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2.5,
                                                  child:
                                                      AppScrollableListViewWidget(
                                                    child:
                                                        ClickableListWheelScrollView(
                                                      scrollController: model
                                                          .scrollController,
                                                      itemHeight: 72,
                                                      itemCount:
                                                          data.data!.length,
                                                      onItemTapCallback:
                                                          (index) {
                                                        model.selectCountry(
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
                                                                    .selectCountry(
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
                                                                        return EmployerCountryListWidget(
                                                                          item:
                                                                              data.data![index],
                                                                        );
                                                                      })),
                                                    ),
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
                                                    color: Theme.of(context)
                                                        .primaryColorDark),
                                              ),
                                            )),
                                  InkWell(
                                    onTap: () {
                                      onSelected!.call(model.selectedCountry!);
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
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 16),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          onDismissed?.call();
                                        },
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
                            );

                          default:
                            return Container();
                        }
                      },
                    ),
                  );
                },
              ));
        },
        onModelReady: (model) {
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
        },
        providerBase: providerBase());
  }

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        context,
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColor.dark_brown,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).error,
                          style: TextStyle(
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0, right: 16),
                          child: Text(message,
                              style: TextStyle(
                                  // fontFamily: "Montserrat",
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
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

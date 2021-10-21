import 'package:domain/model/country/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/employer_country_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class CountryDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final String? title;

  const CountryDialogView({this.onDismissed, this.onSelected, this.title});

  ProviderBase providerBase() {
    return employerCountryDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CountryDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: AppStreamBuilder<int>(
                stream: model!.currentIndexStream,
                initialData: 0,
                dataBuilder: (context, currentIndex) {
                  return AppStreamBuilder<Resource<List<Country>>>(
                    stream: model.getCountryStream,
                    initialData: Resource.none(),
                    dataBuilder: (context, data) {
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
                                        padding: EdgeInsets.only(right: 8),
                                        child: AppSvg.asset(AssetUtils.search)),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                                child: data!.data!.length > 0
                                    ? Scrollbar(
                                        child: ListWheelScrollView.useDelegate(
                                            itemExtent: 72,
                                            onSelectedItemChanged: (int index) {
                                              model.selectCountry(index);
                                            },
                                            physics: FixedExtentScrollPhysics(),
                                            perspective: 0.0000000001,
                                            childDelegate:
                                                ListWheelChildBuilderDelegate(
                                                    childCount:
                                                        data.data!.length,
                                                    builder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return EmployerCountryListWidget(
                                                        item: data.data![index],
                                                      );
                                                    })),
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
                            InkWell(
                              onTap: () {
                                onSelected!
                                    .call(model.selectedCountry!.countryName!);
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                height: 57,
                                width: 57,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.dark_violet_4),
                                child: AppSvg.asset(AssetUtils.tick),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 16),
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
                    },
                  );
                },
              ));
        },
        onModelReady: (model) {
          model.getCountryList(context);
        },
        providerBase: providerBase());
  }
}

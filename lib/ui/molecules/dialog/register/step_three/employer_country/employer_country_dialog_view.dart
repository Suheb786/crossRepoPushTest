import 'package:domain/model/country/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employer_country/employer_country_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/employer_country_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class EmployerCountryDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const EmployerCountryDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return employerCountryDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EmployerCountryDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: AppStreamBuilder<int>(
                stream: model!.currentIndexStream,
                initialData: 0,
                dataBuilder: (context, currentIndex) {
                  return AppStreamBuilder<Resource<List<Country>>>(
                    stream: model.getEmployerCountryStream,
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
                                S.of(context).purposeOfOpeningAccount,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                              child: ListWheelScrollView.useDelegate(
                                  itemExtent: 72,
                                  onSelectedItemChanged: (int index) {
                                    model.selectCountry(index);
                                  },
                                  physics: FixedExtentScrollPhysics(),
                                  perspective: 0.0000000001,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                      childCount: data!.data!.length,
                                      builder:
                                          (BuildContext context, int index) {
                                        return EmployerCountryListWidget(
                                          item: data.data![index],
                                        );
                                      }))),
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
                              child: Text(
                                S.of(context).swipeDownToCancel,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.dark_gray_1),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ));
        },
        onModelReady: (model) {
          model.getEmployerCountryList(context);
        },
        providerBase: providerBase());
  }
}

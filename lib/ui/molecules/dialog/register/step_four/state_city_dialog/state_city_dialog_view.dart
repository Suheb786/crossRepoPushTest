import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class StateCityDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final StateCityTypeEnum? stateCityTypeEnum;
  final String? title;

  const StateCityDialogView(
      {this.onDismissed, this.onSelected, this.stateCityTypeEnum, this.title});

  ProviderBase providerBase() {
    return stateCityDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<StateCityDialogViewModel>(
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 32),
                        child: AppTextField(
                          labelText: '',
                          controller: model.controller,
                          textFieldBorderColor: AppColor.gray_1,
                          hintTextColor: AppColor.gray_2,
                          textColor: AppColor.black,
                          hintText: getHintText(stateCityTypeEnum, context),
                          onChanged: (value) {
                            //model.searchCountry(value);
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
                          child: ListWheelScrollView.useDelegate(
                              itemExtent: 64,
                              onSelectedItemChanged: (int index) {
                                model.currentIndexUpdate(index);
                              },
                              physics: FixedExtentScrollPhysics(),
                              perspective: 0.0000000001,
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount:
                                      model.getList(stateCityTypeEnum!).length,
                                  builder: (BuildContext context, int index) {
                                    return ListScrollWheelListWidget(
                                      label: model
                                          .getList(stateCityTypeEnum!)[index],
                                      textColor: currentIndex == index
                                          ? AppColor.white
                                          : AppColor.dark_gray_1,
                                      widgetColor: currentIndex == index
                                          ? AppColor.dark_violet_3
                                          : AppColor.white,
                                    );
                                  }))),
                      InkWell(
                        onTap: () {
                          onSelected!.call(
                              model.getList(stateCityTypeEnum!)[currentIndex!]);
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
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
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
              ));
        },
        providerBase: providerBase());
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

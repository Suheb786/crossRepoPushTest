import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/change_credit_limit/change_credit_limit_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ChangeCreditLimitPageView extends BasePageViewWidget<ChangeCreditLimitPageViewModel> {
  ChangeCreditLimitPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ChangeCreditLimitPageViewModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).changeCreditLimit.toUpperCase(),
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).changeCreditLimitDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
              child: Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity!.isNegative) {
                    Navigator.pushNamed(context, RoutePaths.CreditCardApplySuccess,
                        arguments: CreditCardApplySuccessArguments(
                            creditSuccessState: CreditSuccessState.Credit_Limit_Changed));
                  } else {}
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppStreamBuilder<SliderLimitValues>(
                                stream: model.sliderValueStream,
                                initialData: SliderLimitValues(maxValue: 1200, minValue: 200, divisions: 100),
                                dataBuilder: (context, sliderLimitValues) {
                                  return Column(
                                    children: [
                                      Text(
                                        S.of(context).changeCreditLimit.toUpperCase(),
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          AppStreamBuilder<double>(
                                              stream: model.valueStream,
                                              initialData: sliderLimitValues!.minValue!,
                                              dataBuilder: (context, value) {
                                                return Text(
                                                  value!.toInt().toString(),
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.w700),
                                                );
                                              }),
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(start: 4, top: 5),
                                            child: Text(
                                              S.of(context).JOD,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.verLightGray4),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 24),
                                        child: Container(
                                          height: 48,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).backgroundColor,
                                              borderRadius: BorderRadius.circular(100)),
                                          child: AppStreamBuilder<double>(
                                              stream: model.valueStream,
                                              initialData: sliderLimitValues.minValue!,
                                              dataBuilder: (context, val) {
                                                return SfTheme(
                                                  data: SfThemeData(
                                                      sliderThemeData: SfSliderThemeData(
                                                          activeTrackColor: Colors.transparent,
                                                          activeTrackHeight: 0,
                                                          thumbRadius: 20,
                                                          inactiveTrackColor: Colors.transparent,
                                                          thumbColor: Theme.of(context).textTheme.bodyMedium!.color!)),
                                                  child: SfSlider(
                                                    min: sliderLimitValues.minValue!,
                                                    max: sliderLimitValues.maxValue!,
                                                    stepSize: sliderLimitValues.divisions!.toDouble(),
                                                    value: val!,
                                                    onChanged: (value) {
                                                      model.updateValue(value);
                                                    },
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${sliderLimitValues.minValue!} ${S.of(context).JOD}',
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.gray,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              "${'${sliderLimitValues.maxValue!}'} ${S.of(context).JOD}",
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.gray,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: AnimatedButton(
                            buttonText: S.of(context).swipeToProceed,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              S.of(context).backToCardSettings,
                              style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.brightBlue,
                                letterSpacing: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
    ;
  }
}

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/tax_report_information/tax_report_information_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class TaxReportInformationPageView
    extends BasePageViewWidget<TaxReportInformationPageViewModel> {
  TaxReportInformationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Text(
          S.of(context).personalDetails,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 32),
          child: Text(
            S.of(context).taxReportInfoDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.very_dark_gray,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: AppStreamBuilder<bool>(
            stream: model.errorDetectorStream,
            initialData: false,
            dataBuilder: (context, error) {
              return ShakeAnimatedWidget(
                enabled: error ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: AppStreamBuilder<Resource<bool>>(
                  stream: model.taxReportInformationStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(registerViewModelProvider)
                          .registrationStepsController
                          .nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta!.isNegative) {
                          model.validateTaxReportInformation();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(registerStepThreeViewModelProvider)
                              .registrationStepThreePageController
                              .previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            decoration: BoxDecoration(
                              color: AppColor.very_soft_violet,
                              gradient: LinearGradient(
                                  colors: [
                                    AppColor.dark_violet,
                                    AppColor.dark_moderate_blue
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AppTextField(
                                    labelText: S.of(context).taxCountry,
                                    hintText: S.of(context).pleaseSelect,
                                    controller: model.countrySelectorController,
                                    key: model.countrySelectorKey,
                                    readOnly: true,
                                    suffixIcon: (value, data) {
                                      return InkWell(
                                        onTap: () async {},
                                        child: Container(
                                            height: 16,
                                            width: 16,
                                            padding: EdgeInsets.only(right: 8),
                                            child: AppSvg.asset(
                                                AssetUtils.downArrow)),
                                      );
                                    },
                                  ),
                                  AppStreamBuilder<bool>(
                                    stream: model.switchValue,
                                    initialData: true,
                                    dataBuilder: (context, isActive) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 28.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .doYouHaveTinAvailable,
                                                    maxLines: 5,
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        color: AppColor
                                                            .very_light_gray_white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                FlutterSwitch(
                                                  value: isActive!,
                                                  onToggle: (value) {
                                                    model.updateSwitchValue(
                                                        value);
                                                  },
                                                  activeText: S.of(context).yes,
                                                  activeTextColor:
                                                      AppColor.vivid_orange,
                                                  activeTextFontWeight:
                                                      FontWeight.w700,
                                                  activeToggleColor:
                                                      AppColor.vivid_orange,
                                                  inactiveTextColor:
                                                      AppColor.white,
                                                  showOnOff: true,
                                                  valueFontSize: 10,
                                                  switchBorder: Border.all(
                                                      color: AppColor
                                                          .mostly_desaturated_dark_violet),
                                                  inactiveText:
                                                      S.of(context).no,
                                                  inactiveTextFontWeight:
                                                      FontWeight.w500,
                                                  activeColor:
                                                      AppColor.dark_violet_4,
                                                  inactiveColor:
                                                      AppColor.dark_violet_4,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: isActive,
                                            child: AppTextField(
                                              labelText: S.of(context).tinNo,
                                              hintText:
                                                  S.of(context).pleaseEnter,
                                              controller: model.tinController,
                                            ),
                                          ),
                                          Visibility(
                                            visible: !isActive,
                                            child: AppTextField(
                                              labelText: S
                                                  .of(context)
                                                  .reasonOfUnavailability,
                                              hintText:
                                                  S.of(context).pleaseSelect,
                                              controller: model.tinController,
                                              key: model.tinKey,
                                              readOnly: true,
                                              suffixIcon: (value, data) {
                                                return InkWell(
                                                  onTap: () async {},
                                                  child: Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding: EdgeInsets.only(
                                                          right: 8),
                                                      child: AppSvg.asset(
                                                          AssetUtils
                                                              .downArrow)),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}

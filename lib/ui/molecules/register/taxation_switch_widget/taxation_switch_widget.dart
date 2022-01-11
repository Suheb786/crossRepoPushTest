import 'package:domain/constants/enum/additional_data_type_enum.dart';
import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/fatca_option_dialog/fatca_option_dialog.dart';
import 'package:neo_bank/ui/molecules/register/taxation_switch_widget/taxation_switch_widget_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class TaxationSwitchWidget extends StatelessWidget {
  final FatcaQuestionContentData data;
  final Function(bool)? onToggle;
  final Function? onInfoClick;
  final Function(AdditionalData, AdditionalDataDropDownData)?
      onDropDownSelection;
  final Function(AdditionalData, String)? onTextUpdate;

  const TaxationSwitchWidget(
      {Key? key,
      required this.data,
      this.onToggle,
      this.onInfoClick,
      this.onDropDownSelection,
      this.onTextUpdate})
      : super(key: key);

  ProviderBase provideBase() {
    return TaxationSwitchWidgetViewModelProvider().provide();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TaxationSwitchWidgetViewModel>(
      providerBase: provideBase(),
      builder: (context, model, widget) {
        return AppStreamBuilder<bool>(
          initialData: false,
          stream: model!.switchValue,
          onData: (isActive) {
            onToggle?.call(isActive);
          },
          dataBuilder: (context, isActive) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          data.labelEn!,
                          maxLines: 5,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      FlutterSwitch(
                        value: isActive!,
                        onToggle: (value) {
                          model.updateSwitchValue(value);
                        },
                        width: 70,
                        height: 40,
                        padding: 8,
                        activeText: S.of(context).yes,
                        activeTextColor: AppColor.white,
                        inactiveTextColor: AppColor.darkGray,
                        activeTextFontWeight: FontWeight.w500,
                        showOnOff: true,
                        valueFontSize: 10,
                        activeToggleColor: AppColor.white,
                        inactiveText: S.of(context).no,
                        inactiveToggleColor: AppColor.lightGrayishMagenta,
                        inactiveTextFontWeight: FontWeight.w500,
                        inactiveSwitchBorder:
                            Border.all(color: AppColor.gray_2),
                        activeColor:
                            Theme.of(context).accentTextTheme.bodyText1!.color!,
                        inactiveColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isActive,
                    child: ListView.builder(
                      itemCount: data.additionalData!.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        switch (data.additionalData![index].type) {
                          case AdditionalDataTypeEnum.DROPDOWN:
                            return FatcaDropDownField(
                              data: data.additionalData![index],
                              onSelect: (value) {
                                onDropDownSelection?.call(
                                    data.additionalData![index], value);
                              },
                            );

                          case AdditionalDataTypeEnum.TEXT_FIELD:
                            return Container(
                              margin: EdgeInsets.only(top: 16),
                              child: AppTextField(
                                  labelText: data.additionalData![index].label!,
                                  hintText: S.of(context).pleaseEnter,
                                  inputType: TextInputType.text,
                                  onChanged: (value) {
                                    onTextUpdate?.call(
                                        data.additionalData![index], value);
                                  }),
                            );
                          default:
                            return Container(
                              height: 16,
                            );
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: data.showInfo ?? false,
                    child: InkWell(
                      onTap: () {
                        onInfoClick?.call();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data.infoText ?? "",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class FatcaDropDownField extends StatelessWidget {
  final AdditionalData data;
  final Function(AdditionalDataDropDownData)? onSelect;

  const FatcaDropDownField({required this.data, this.onSelect});

  ProviderBase provideBase() {
    return FatcaDropDownFieldViewModelProvider().provide();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FatcaDropDownFieldViewModel>(
      onModelReady: (model) {},
      providerBase: provideBase(),
      builder: (context, model, child) {
        return Container(
          margin: EdgeInsets.only(top: 16),
          child: AppTextField(
            labelText: data.label ?? "",
            hintText: S.of(context).pleaseSelect,
            readOnly: true,
            controller: model?.controller,
            onPressed: () {
              FatcaOptionDialog.show(context, title: data.label ?? "",
                  onDismissed: () {
                Navigator.pop(context);
              }, onSelected: (value) {
                model?.controller.text = value.name!;
                onSelect?.call(value);
                Navigator.pop(context);
              }, fatcaOptionData: data.additionalDropDownData ?? []);
            },
            suffixIcon: (value, data) {
              return Container(
                  height: 16,
                  width: 16,
                  padding: EdgeInsets.only(right: 8),
                  child: AppSvg.asset(AssetUtils.downArrow,
                      color: AppColor.dark_gray_1));
            },
          ),
        );
      },
    );
  }
}

class FatcaDropDownFieldViewModel extends BaseViewModel {
  final TextEditingController controller = TextEditingController();
}

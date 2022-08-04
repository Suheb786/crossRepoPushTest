import 'package:domain/model/register/additional_income.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/additional_income_selector_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'additional_income_source_dialog_view_model.dart';

class AdditionIncomeSourceDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(AdditionalIncomeType)? onSelected;
  bool _keyboardVisible = false;

  AdditionIncomeSourceDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return additionalIncomeSourceDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<AdditionIncomeSourceDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: _keyboardVisible ? 36 : 204),
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    onDismissed?.call();
                  }
                },
                child: AppStreamBuilder<Resource<List<AdditionalIncome>>>(
                  stream: model!.getAdditionIncomeSourceStream,
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
                              S.of(context).additionalIncome,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                            child: FadingEdgeScrollView.fromScrollView(
                          gradientFractionOnStart: 0.3,
                          gradientFractionOnEnd: 0.3,
                          child: ListView.builder(
                            controller: model.scrollController,
                            itemBuilder: (context, index) {
                              if (index == data!.data!.length) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 24),
                                  child: AppTextField(
                                    labelText: S.of(context).totalAnnualIncome,
                                    hintText: '',
                                    controller: model.totalAnnualIncomeController,
                                    key: model.totalAnnualIncomeKey,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    textFieldBorderColor: AppColor.gray_1,
                                    textColor: AppColor.very_dark_gray_black,
                                    labelColor: AppColor.very_dark_gray_black,
                                    prefixIcon: () {
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.only(top: 8.0, end: 8),
                                        child: Text(
                                          S.of(context).JOD,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.very_dark_gray_black),
                                        ),
                                      );
                                    },
                                    onChanged: (value) {},
                                  ),
                                );
                              }
                              return AdditionalIncomeSelectorWidget(
                                additionalIncome: data.data![index],
                                onTap: () {
                                  model.selectAdditionalIncome(index);
                                },
                              );
                            },
                            itemCount: data!.data!.length + 1,
                          ),
                        )),
                        // Visibility(
                        //   visible: model.selectedAdditionalIncome!.isSelected,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 24, right: 24, bottom: 24),
                        //     child: AppTextField(
                        //       labelText: S.of(context).totalAnnualIncome,
                        //       hintText: '',
                        //       controller: model.totalAnnualIncomeController,
                        //       key: model.totalAnnualIncomeKey,
                        //       inputType: TextInputType.number,
                        //       inputAction: TextInputAction.done,
                        //       textFieldBorderColor: AppColor.gray_1,
                        //       textColor: AppColor.very_dark_gray_black,
                        //       labelColor: AppColor.very_dark_gray_black,
                        //       prefixIcon: () {
                        //         return Padding(
                        //           padding:
                        //               const EdgeInsets.only(top: 8.0, right: 8),
                        //           child: Text(
                        //             S.of(context).JOD,
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: AppColor.very_dark_gray_black),
                        //           ),
                        //         );
                        //       },
                        //       onChanged: (value) {},
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            onSelected!.call(AdditionalIncomeType(
                                additionalIncomeSource: model.selectedAdditionalIncome!.type!,
                                totalIncome: model.totalAnnualIncomeController.text));
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).accentTextTheme.bodyText1!.color),
                            child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                          child: Center(
                            child: Text(
                              S.of(context).swipeDownToCancel,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.dark_gray_1),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ));
        },
        providerBase: providerBase());
  }
}

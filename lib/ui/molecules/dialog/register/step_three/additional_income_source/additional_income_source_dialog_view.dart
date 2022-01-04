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

import 'additional_income_source_dialog_view_model.dart';

class AdditionIncomeSourceDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(AdditionalIncomeType)? onSelected;

  const AdditionIncomeSourceDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return additionalIncomeSourceDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AdditionIncomeSourceDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
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
                              return Visibility(
                                visible:
                                    model.selectedAdditionalIncome!.isSelected,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, bottom: 24),
                                  child: AppTextField(
                                    labelText: S.of(context).totalAnnualIncome,
                                    hintText: '',
                                    controller:
                                        model.totalAnnualIncomeController,
                                    key: model.totalAnnualIncomeKey,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    textFieldBorderColor: AppColor.gray_1,
                                    textColor: AppColor.very_dark_gray_black,
                                    labelColor: AppColor.very_dark_gray_black,
                                    prefixIcon: () {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 8),
                                        child: Text(
                                          S.of(context).JOD,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor
                                                  .very_dark_gray_black),
                                        ),
                                      );
                                    },
                                    onChanged: (value) {},
                                  ),
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
                      InkWell(
                        onTap: () {
                          onSelected!.call(AdditionalIncomeType(
                              additionalIncomeSource:
                              model.selectedAdditionalIncome!.type!,
                              totalIncome: model.totalAnnualIncomeController
                                  .text));
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
                                  .color),
                          child: AppSvg.asset(AssetUtils.tick,
                              color: Theme.of(context).accentColor),
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
}

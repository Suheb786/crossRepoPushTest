import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/fatca_option_dialog/fatca_option_dialog_viewmodel.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/fatca_option_dialog/fatca_option_item_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../app_scollable_list_view_widget.dart';

class FatcaOptionDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(AdditionalDataDropDownData)? onSelected;
  final String? title;
  final List<AdditionalDataDropDownData> dropDownData;
  bool _keyboardVisible = false;

  FatcaOptionDialogView({this.onDismissed, this.onSelected, this.title, required this.dropDownData});

  ProviderBase providerBase() {
    return fatcaOptionsDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<FatcaOptionDialogViewModel>(
      providerBase: providerBase(),
      onModelReady: (model) {
        if (model.allOptionalDataList == null || model.allOptionalDataList!.isEmpty) {
          model.setOptionData(dropDownData);
        }
      },
      builder: (context, model, child) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: _keyboardVisible ? 36 : 204),
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  onDismissed?.call();
                }
              },
              child: AppStreamBuilder<int>(
                stream: model!.currentIndexStream,
                initialData: 0,
                dataBuilder: (context, currentIndex) {
                  return AppStreamBuilder<Resource<List<AdditionalDataDropDownData>>>(
                    stream: model.optionalDataStream,
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
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: title == 'TAX COUNTRY' ? true : false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                              child: AppTextField(
                                labelText: '',
                                controller: model.mobileNumberSearchController,
                                textFieldBorderColor: AppColor.gray_1,
                                hintTextColor: AppColor.gray_2,
                                textColor: Theme.of(context).primaryColorDark,
                                hintText: S.of(context).searchCountry,
                                containerPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                onChanged: (value) {
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
                                            color: Theme.of(context).primaryColorDark)),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              child: data!.data!.length > 0
                                  ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Container(
                                            height: 64,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              color: AppColor.vividYellow,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height / 2.5,
                                          child: AppScrollableListViewWidget(
                                            key: ValueKey(data.data!.length),
                                            child: ClickableListWheelScrollView(
                                              scrollController: model.scrollController,
                                              itemHeight: 64,
                                              itemCount: data.data!.length,
                                              onItemTapCallback: (index) {
                                                model.selectMobileNumber(index);
                                              },
                                              child: ListWheelScrollView.useDelegate(
                                                  controller: model.scrollController,
                                                  itemExtent: 64,
                                                  onSelectedItemChanged: (int index) {
                                                    model.selectMobileNumber(index);
                                                  },
                                                  physics: FixedExtentScrollPhysics(),
                                                  perspective: 0.0000000001,
                                                  childDelegate: ListWheelChildBuilderDelegate(
                                                      childCount: data.data!.length,
                                                      builder: (BuildContext context, int index) {
                                                        return FatcaOptionItemWidget(
                                                          item: data.data![index],
                                                          showFlag: title == 'TAX COUNTRY',
                                                        );
                                                      })),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Text(
                                        "No Options Available",
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.dark_violet_4),
                                      ),
                                    )),
                          Container(
                            color: AppColor.white.withOpacity(0),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    print('selectedData--->${model.selectedOptionData!.name}');
                                    Navigator.pop(context);
                                    onSelected!.call(model.selectedOptionData!);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    height: 57,
                                    width: 57,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                    child:
                                        AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
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
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ));
      },
    );
  }
}

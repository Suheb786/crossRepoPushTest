import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
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
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../app_scollable_list_view_widget.dart';

class FatcaOptionDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(AdditionalDataDropDownData)? onSelected;
  final String? title;
  final String? titleAr;
  final List<AdditionalDataDropDownData> dropDownData;
  bool _keyboardVisible = false;

  FatcaOptionDialogView(
      {this.onDismissed, this.onSelected, this.title, required this.dropDownData, this.titleAr = ''});

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
            insetPadding:
                EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: _keyboardVisible ? 36.h : 204.h),
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
                            padding: EdgeInsets.only(top: 32.0.h),
                            child: Center(
                              child: Text(
                                StringUtils.isDirectionRTL(context) ? titleAr ?? '' : title!,
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
                              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                              child: AppTextField(
                                labelText: '',
                                controller: model.mobileNumberSearchController,
                                textFieldBorderColor: AppColor.gray_1,
                                hintTextColor: AppColor.gray_2,
                                textColor: Theme.of(context).primaryColorDark,
                                hintText: S.of(context).searchCountry,
                                containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                onChanged: (value) {
                                  model.searchMobileNumber(value);
                                },
                                suffixIcon: (value, data) {
                                  return InkWell(
                                    onTap: () async {},
                                    child: Container(
                                        height: 16.h,
                                        width: 16.w,
                                        padding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 6.h),
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
                                          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                          child: Container(
                                            height: 64.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16.w),
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
                                              itemHeight: 64.h,
                                              itemCount: data.data!.length,
                                              onItemTapCallback: (index) {
                                                model.selectMobileNumber(index);
                                              },
                                              child: ListWheelScrollView.useDelegate(
                                                  controller: model.scrollController,
                                                  itemExtent: 64.h,
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
                                        S.of(context).noDataFound,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14.t,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                    )),
                          Container(
                            color: AppColor.white.withOpacity(0),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    onSelected!.call(model.selectedOptionData!);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                    height: 57.h,
                                    width: 57.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).textTheme.bodyMedium!.color!),
                                    child:
                                        AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
                                  child: Center(
                                    child: Text(
                                      S.of(context).swipeDownToCancel,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 10.t,
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

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'occupation_dialog_view_model.dart';

class OccupationDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final String? title;
  final EmploymentStatusEnum? employmentStatusEnum;
  final List<GetComboValuesData>? businessTypeList;

  const OccupationDialogView(
      {this.onDismissed, this.onSelected, this.employmentStatusEnum, this.businessTypeList, this.title});

  ProviderBase providerBase() {
    return occupationDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<OccupationDialogViewModel>(
      builder: (context, model, child) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
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
                  return AppStreamBuilder<Resource<List<String>>>(
                    stream: model.getOccupationStream,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Stack(
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
                              AppScrollableListViewWidget(
                                key: ValueKey(model.businessTypeList.length),
                                child: ClickableListWheelScrollView(
                                  scrollController: model.scrollController,
                                  itemHeight: 64,
                                  itemCount: model.businessTypeList.length,
                                  onItemTapCallback: (index) {
                                    model.currentIndexUpdate(index);
                                  },
                                  child: ListWheelScrollView.useDelegate(
                                      itemExtent: 64,
                                      controller: model.scrollController,
                                      onSelectedItemChanged: (int index) {
                                        model.currentIndexUpdate(index);
                                      },
                                      physics: FixedExtentScrollPhysics(),
                                      perspective: 0.0000000001,
                                      childDelegate: ListWheelChildBuilderDelegate(
                                          childCount: model.businessTypeList.length,
                                          builder: (BuildContext context, int index) {
                                            return ListScrollWheelListWidget(
                                              label: model.businessTypeList[index].labelEn!,
                                              textColor: currentIndex == index
                                                  ? Theme.of(context).primaryColorDark
                                                  : AppColor.dark_gray_1,
                                              widgetColor: Colors.transparent,
                                            );
                                          })),
                                ),
                              ),
                            ],
                          )),
                          InkWell(
                            onTap: () {
                              onSelected!.call(model.businessTypeList[currentIndex!].labelEn!);
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: 57,
                              width: 57,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).accentTextTheme.bodyText1!.color!),
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
                  );
                },
              ),
            ));
      },
      providerBase: providerBase(),
      onModelReady: (model) {
        model.getOccupationList(employmentStatusEnum!);
        model.businessTypeList = businessTypeList!;
      },
    );
  }
}

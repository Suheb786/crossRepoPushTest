import 'package:domain/constants/enum/calendar_enum.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/year_month_dialog/year_month_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class YearMonthDialogView extends StatefulWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final CalendarEnum? calendarEnum;

  const YearMonthDialogView(
      {this.onDismissed, this.onSelected, this.calendarEnum});

  @override
  _YearMonthDialogViewState createState() => _YearMonthDialogViewState();
}

class _YearMonthDialogViewState extends State<YearMonthDialogView> {
  ProviderBase providerBase() {
    return yearMonthDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<YearMonthDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: AppStreamBuilder<Resource<List<String>>>(
                stream: model!.getListStream,
                initialData: Resource.none(),
                dataBuilder: (context, listData) {
                  return AppStreamBuilder<int>(
                    stream: model.currentIndexStream,
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
                                S.of(context).dateOfBirthSmall,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.calendarEnum == CalendarEnum.YEAR,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 32),
                              child: AppTextField(
                                labelText: '',
                                controller: model.yearController,
                                textFieldBorderColor: AppColor.gray_1,
                                hintTextColor: AppColor.gray_2,
                                textColor: AppColor.black,
                                hintText: S.of(context).searchYear,
                                onChanged: (value) {
                                  model.searchYear(value);
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
                          ),
                          Expanded(
                              child: listData!.data!.length > 0
                                  ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Container(
                                            height: 64,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: AppColor.dark_violet_3,
                                            ),
                                          ),
                                        ),
                                        Scrollbar(
                                          child: FadingEdgeScrollView
                                              .fromListWheelScrollView(
                                            gradientFractionOnStart: 0.3,
                                            gradientFractionOnEnd: 0.3,
                                            child:
                                                ListWheelScrollView.useDelegate(
                                                    controller:
                                                        model.scrollController,
                                                    itemExtent: 64,
                                                    onSelectedItemChanged:
                                                        (int index) {
                                                      model.currentIndexUpdate(
                                                          index);
                                                    },
                                                    physics:
                                                        FixedExtentScrollPhysics(),
                                                    perspective: 0.0000000001,
                                                    childDelegate:
                                                        ListWheelChildBuilderDelegate(
                                                            childCount: listData
                                                                .data!.length,
                                                            builder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return ListScrollWheelListWidget(
                                                                label: listData
                                                                        .data![
                                                                    index],
                                                                textColor: currentIndex ==
                                                                        index
                                                                    ? AppColor
                                                                        .white
                                                                    : AppColor
                                                                        .dark_gray_1,
                                                                widgetColor: Colors
                                                                    .transparent,
                                                              );
                                                            })),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Text(
                                        S.of(context).noMatchingYearFound,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.dark_violet_4),
                                      ),
                                    )),
                          InkWell(
                            onTap: () {
                              widget.onSelected
                                  ?.call(listData.data![currentIndex!]);
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
                            child: InkWell(
                              onTap: () {
                                widget.onDismissed?.call();
                              },
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
                          ),
                        ],
                      );
                    },
                  );
                },
              ));
        },
        onModelReady: (model) {
          model.getList(widget.calendarEnum!);
        },
        providerBase: providerBase());
  }
}

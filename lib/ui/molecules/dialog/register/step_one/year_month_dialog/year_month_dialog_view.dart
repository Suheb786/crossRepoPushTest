import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/constants/enum/calendar_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/year_month_dialog/year_month_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class YearMonthDialogView extends StatefulWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final CalendarEnum? calendarEnum;
  final String? title;

  const YearMonthDialogView({this.onDismissed, this.onSelected, this.calendarEnum, this.title});

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: AppStreamBuilder<Resource<List<String>>>(
                stream: model!.getListStream,
                initialData: Resource.none(),
                dataBuilder: (context, listData) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      AppKeyBoardHide(
                        child: AppStreamBuilder<int>(
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
                                      widget.title!,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: widget.calendarEnum == CalendarEnum.YEAR,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
                                              padding: EdgeInsetsDirectional.only(end: 8),
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
                                                key: ValueKey(listData.data!.length),
                                                child: ClickableListWheelScrollView(
                                                  scrollController: model.scrollController,
                                                  itemHeight: 64,
                                                  itemCount: listData.data!.length,
                                                  onItemTapCallback: (index) {
                                                    model.currentIndexUpdate(index);
                                                  },
                                                  child: ListWheelScrollView.useDelegate(
                                                      controller: model.scrollController,
                                                      itemExtent: 64,
                                                      onSelectedItemChanged: (int index) {
                                                        model.currentIndexUpdate(index);
                                                      },
                                                      physics: FixedExtentScrollPhysics(),
                                                      perspective: 0.0000000001,
                                                      childDelegate: ListWheelChildBuilderDelegate(
                                                          childCount: listData.data!.length,
                                                          builder: (BuildContext context, int index) {
                                                            return ListScrollWheelListWidget(
                                                              label: listData.data![index],
                                                              textColor: currentIndex == index
                                                                  ? Theme.of(context).primaryColorDark
                                                                  : AppColor.dark_gray_1,
                                                              widgetColor: Colors.transparent,
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
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context).textTheme.bodyMedium!.color!),
                                            ),
                                          )),

                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                                  child: AppPrimaryButton(
                                    // isDisabled: isValid!,
                                    isDisabled: false,

                                    onPressed: () {
                                      widget.onSelected?.call(listData.data![currentIndex!]);
                                    },

                                    text: S.of(context).confirm,
                                  ),
                                ),
                                SizedBox(height: 40.h),

                                // InkWell(
                                //   onTap: () {
                                //     widget.onSelected?.call(listData.data![currentIndex!]);
                                //   },
                                //   child: Container(
                                //     padding: EdgeInsets.all(16),
                                //     height: 57,
                                //     width: 57,
                                //     decoration: BoxDecoration(
                                //         shape: BoxShape.circle,
                                //         color: Theme.of(context).textTheme.bodyLarge!.color!),
                                //     child: AppSvg.asset(AssetUtils.tick,
                                //         color: Theme.of(context).colorScheme.secondary),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                                //   child: InkWell(
                                //     onTap: () {
                                //       widget.onDismissed?.call();
                                //     },
                                //     child: Center(
                                //       child: Text(
                                //         S.of(context).swipeDownToCancel,
                                //         style: TextStyle(
                                //             fontFamily: StringUtils.appFont,
                                //             fontSize: 10,
                                //             fontWeight: FontWeight.w400,
                                //             color: AppColor.dark_gray_1),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: -24.h,
                        child: InkWell(
                          onTap: () {
                            // onDismissed?.call();
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 48.h,
                              width: 48.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.secondary),
                              child: Image.asset(
                                AssetUtils.close_bold,
                                scale: 3.5,
                              )),
                        ),
                      ),
                    ],
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

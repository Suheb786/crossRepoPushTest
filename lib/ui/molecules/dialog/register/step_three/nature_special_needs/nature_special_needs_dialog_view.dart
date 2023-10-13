import 'package:neo_bank/utils/clickable_scrall_view/list_wheel_scrall_view.dart';
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
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'nature_special_needs_dialog_view_model.dart';

class NatureSpecialNeedsDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const NatureSpecialNeedsDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return natureSpecialNeedsDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<NatureSpecialNeedsDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, bottom: 36.0.h, top: 204.h),
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
                      stream: model.getNatureSpecialNeedsStream,
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
                                  S.of(context).natureSpecialNeeds,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 16.t,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Stack(
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
                                AppScrollableListViewWidget(
                                  key: ValueKey(data?.data!.length),
                                  child: ClickableListWheelScrollView(
                                    scrollController: model.scrollController,
                                    itemHeight: 64.h,
                                    itemCount: data!.data!.length,
                                    onItemTapCallback: (index) {
                                      model.currentIndexUpdate(index);
                                    },
                                    child: ListWheelScrollView.useDelegate(
                                        controller: model.scrollController,
                                        itemExtent: 64.h,
                                        onSelectedItemChanged: (int index) {
                                          model.currentIndexUpdate(index);
                                        },
                                        physics: FixedExtentScrollPhysics(),
                                        perspective: 0.0000000001,
                                        childDelegate: ListWheelChildBuilderDelegate(
                                            childCount: data.data!.length,
                                            builder: (BuildContext context, int index) {
                                              return ListScrollWheelListWidget(
                                                label: data.data![index],
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
                                onSelected!.call(data.data![currentIndex!]);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                height: 57.h,
                                width: 57.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).textTheme.bodyLarge!.color!),
                                child: AppSvg.asset(AssetUtils.tick,
                                    color: Theme.of(context).colorScheme.secondary),
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
                        );
                      },
                    );
                  },
                ),
              ));
        },
        providerBase: providerBase());
  }
}

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employment_status/employment_status_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EmploymentStatusDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const EmploymentStatusDialogView({this.onDismissed, this.onSelected});

  ProviderBase providerBase() {
    return employmentStatusDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EmploymentStatusDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dy > 0 || details.delta.dy.isNegative) {
                    onDismissed?.call();
                  }
                },
                child: AppStreamBuilder<int>(
                  stream: model!.currentIndexStream,
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
                              S.of(context).employmentStatusSmall,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                              key: ValueKey(model.employmentStatusList.length),
                              child: ClickableListWheelScrollView(
                                scrollController: model.scrollController,
                                itemHeight: 64,
                                itemCount: model.employmentStatusList.length,
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
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                            childCount: model
                                                .employmentStatusList.length,
                                            builder: (BuildContext context,
                                                int index) {
                                              return ListScrollWheelListWidget(
                                                label:
                                                    model.employmentStatusList[
                                                        index],
                                                textColor: currentIndex == index
                                                    ? Theme.of(context)
                                                        .primaryColorDark
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
                            onSelected!.call(
                                model.employmentStatusList[currentIndex!]);
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
                                    .color!),
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
                ),
              ));
        },
        providerBase: providerBase());
  }
}

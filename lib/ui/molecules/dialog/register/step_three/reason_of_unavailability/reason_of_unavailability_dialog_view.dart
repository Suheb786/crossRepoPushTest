import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/reason_of_unavailability/reason_of_unavailability_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/reason_unavailability_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ReasonOfUnavailabilityDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const ReasonOfUnavailabilityDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return reasonOfUnavailabilityDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ReasonOfUnavailabilityDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: AppStreamBuilder<int>(
                stream: model!.currentIndexStream,
                initialData: 0,
                dataBuilder: (context, currentIndex) {
                  return GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        onDismissed?.call();
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Center(
                            child: Text(
                              S.of(context).reasonOfUnavailabilitySmall,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont, fontSize: 16, fontWeight: FontWeight.w600),
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
                                height: 110,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColor.dark_violet_3,
                                ),
                              ),
                            ),
                            AppScrollableListViewWidget(
                              key: ValueKey(model.reasonOfUnavailabilityList.length),
                              child: ClickableListWheelScrollView(
                                scrollController: model.scrollController,
                                itemHeight: 110,
                                itemCount: model.reasonOfUnavailabilityList.length,
                                onItemTapCallback: (index) {
                                  model.currentIndexUpdate(index);
                                },
                                child: ListWheelScrollView.useDelegate(
                                    controller: model.scrollController,
                                    itemExtent: 110,
                                    onSelectedItemChanged: (int index) {
                                      model.currentIndexUpdate(index);
                                    },
                                    physics: FixedExtentScrollPhysics(),
                                    perspective: 0.0000000001,
                                    childDelegate: ListWheelChildBuilderDelegate(
                                        childCount: model.reasonOfUnavailabilityList.length,
                                        builder: (BuildContext context, int index) {
                                          return ReasonUnavailabilityListWidget(
                                            reasonOfUnavailability: model.reasonOfUnavailabilityList[index],
                                            labelColor: currentIndex == index
                                                ? AppColor.white
                                                : AppColor.very_dark_violet,
                                            descriptionColor: currentIndex == index
                                                ? AppColor.very_light_gray_white
                                                : AppColor.very_dark_violet,
                                            widgetColor: Colors.transparent,
                                          );
                                        })),
                              ),
                            ),
                          ],
                        )),
                        InkWell(
                          onTap: () {
                            onSelected!.call(model.reasonOfUnavailabilityList[currentIndex!].type!);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.dark_violet_4),
                            child: AppSvg.asset(AssetUtils.tick),
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
                  );
                },
              ));
        },
        providerBase: providerBase());
  }
}

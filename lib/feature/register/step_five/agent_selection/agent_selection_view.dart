import 'package:animated_widgets/animated_widgets.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/agent_selection/agent_selection_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/agent_selection_list_widget.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:riverpod/src/framework.dart';

class AgentSelectionView extends BasePageViewWidget<AgentSelectionViewModel> {
  AgentSelectionView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AgentSelectionViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: ShakeAnimatedWidget(
              enabled: false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.primaryDelta!.isNegative) {
                    ProviderScope.containerOf(context)
                        .read(registerStepFiveViewModelProvider)
                        .registrationStepFivePageController
                        .jumpToPage(4);
                  } else {
                    ProviderScope.containerOf(context)
                        .read(registerStepFiveViewModelProvider)
                        .registrationStepFivePageController
                        .previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  margin: EdgeInsets.zero,
                  shadowColor: AppColor.black.withOpacity(0.32),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColor.very_soft_violet,
                        gradient: LinearGradient(
                            colors: [
                              AppColor.dark_violet,
                              AppColor.dark_moderate_blue
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: Stack(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Container(
                                  height: 64,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                              AppScrollableListViewWidget(
                                child: ClickableListWheelScrollView(
                                  scrollController: model.scrollController,
                                  itemHeight: 72,
                                  itemCount: model.agentList.length,
                                  onItemTapCallback: (index) {
                                    model.selectAgent(index);
                                  },
                                  child: ListWheelScrollView.useDelegate(
                                      itemExtent: 72,
                                      controller: model.scrollController,
                                      onSelectedItemChanged: (int index) {
                                        model.selectAgent(index);
                                        ProviderScope.containerOf(context)
                                            .read(
                                                agentSelectionViewModelProvider)
                                            .notify();
                                      },
                                      physics: FixedExtentScrollPhysics(),
                                      perspective: 0.0000000001,
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                              childCount:
                                                  model.agentList.length,
                                              builder: (BuildContext context,
                                                  int index) {
                                                return AgentSelectionListWidget(
                                                  item: model.agentList[index],
                                                );
                                              })),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 45,
                            child: AnimatedButton(
                              buttonText: S.of(context).swipeToProceed,
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

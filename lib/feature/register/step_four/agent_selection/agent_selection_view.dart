import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/agent_selection/agent_selection_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
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
          Text(
            S.of(context).personalDetails,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36.0, bottom: 32),
            child: Text(
              S.of(context).agentSelectionHeader,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.very_dark_gray,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ShakeAnimatedWidget(
              enabled: false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.primaryDelta!.isNegative) {
                  } else {
                    ProviderScope.containerOf(context)
                        .read(registerStepFourViewModelProvider)
                        .registrationStepFourPageController
                        .previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                      child: Scrollbar(
                        child: ListWheelScrollView.useDelegate(
                            itemExtent: 72,
                            onSelectedItemChanged: (int index) {
                              model.selectAgent(index);
                              ProviderScope.containerOf(context)
                                  .read(agentSelectionViewModelProvider)
                                  .notify();
                            },
                            physics: FixedExtentScrollPhysics(),
                            perspective: 0.0000000001,
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: model.agentList.length,
                                builder: (BuildContext context, int index) {
                                  return AgentSelectionListWidget(
                                    item: model.agentList[index],
                                  );
                                })),
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

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/agent_selection/agent_selection_model.dart';
import 'package:neo_bank/feature/register/step_five/agent_selection/agent_selection_view.dart';
import 'package:riverpod/src/framework.dart';

class AgentSelectionPage extends BasePage<AgentSelectionViewModel> {
  @override
  AgentSelectionPageState createState() => AgentSelectionPageState();
}

class AgentSelectionPageState
    extends BaseStatefulPage<AgentSelectionViewModel, AgentSelectionPage> {
  @override
  ProviderBase provideBase() {
    return agentSelectionViewModelProvider;
  }

  @override
  void onModelReady(AgentSelectionViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Widget buildView(BuildContext context, AgentSelectionViewModel model) {
    return AgentSelectionView(provideBase());
  }
}

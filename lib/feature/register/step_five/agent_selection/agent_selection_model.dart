import 'package:domain/model/agent/agent.dart';
import 'package:domain/usecase/user/agent_selection_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AgentSelectionViewModel extends BasePageViewModel {
  final AgentSelectionUseCase _agentSelectionUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    notifyListeners();
  }

  FixedExtentScrollController scrollController =
      new FixedExtentScrollController();

  AgentSelectionViewModel(this._agentSelectionUseCase) {
    selectAgent(0);
  }

  Agent? selectedAgent = Agent();

  List<Agent> agentList = [
    Agent(icon: AssetUtils.anyAgent, agent: "Any Agent", isSelected: false),
    Agent(icon: AssetUtils.maleAgent, agent: "Male Agent", isSelected: false),
    Agent(icon: AssetUtils.female_agent, agent: "Female Agent", isSelected: false)
  ];

  void selectAgent(int index) {
    List<Agent>? selectAgentList = agentList;
    selectAgentList.forEach((element) {
      element.isSelected = false;
    });
    selectAgentList.elementAt(index).isSelected = true;
    selectedAgent =
        selectAgentList.firstWhere((element) => element.isSelected!);
  }
}

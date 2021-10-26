import 'package:domain/model/agent/agent.dart';
import 'package:domain/usecase/user/agent_selection_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AgentSelectionViewModel extends BasePageViewModel {
  final AgentSelectionUseCase _agentSelectionUseCase;

  FixedExtentScrollController scrollController =
      new FixedExtentScrollController();

  AgentSelectionViewModel(this._agentSelectionUseCase) {
    selectAgent(0);
  }

  Agent? selectedAgent = Agent();

  List<Agent> agentList = [
    Agent(icon: AssetUtils.infinite, agent: "Any Agent", isSelected: false),
    Agent(icon: AssetUtils.male, agent: "Male Agent", isSelected: false),
    Agent(icon: AssetUtils.female, agent: "Female Agent", isSelected: false)
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

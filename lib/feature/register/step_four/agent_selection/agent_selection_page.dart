import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/agent_selection/agent_selection_model.dart';
import 'package:neo_bank/feature/register/step_four/agent_selection/agent_selection_view.dart';
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
  Widget buildView(BuildContext context, AgentSelectionViewModel model) {
    return AgentSelectionView(provideBase());
  }
}

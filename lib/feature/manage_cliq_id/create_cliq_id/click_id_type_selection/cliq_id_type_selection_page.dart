import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/click_id_type_selection/cliq_id_type_selection_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/click_id_type_selection/cliq_id_type_selection_page_view_model.dart';

class CliqIdTypeSelectionPage
    extends BasePage<CliqIdTypeSelectionPageViewModel> {
  @override
  CliqIdTypeSelectionPageState createState() => CliqIdTypeSelectionPageState();
}

class CliqIdTypeSelectionPageState extends BaseStatefulPage<
    CliqIdTypeSelectionPageViewModel,
    CliqIdTypeSelectionPage> with AutomaticKeepAliveClientMixin {
  CliqIdTypeSelectionPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return cliqIdTypeSelectionViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(
      BuildContext context, CliqIdTypeSelectionPageViewModel model) {
    return CliqIdTypeSelectionPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Future<bool> onBackPressed(CliqIdTypeSelectionPageViewModel model,
      {param}) async {
    var parentModel =
        ProviderScope.containerOf(context).read(createCliqIdViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CliqIdListPage extends BasePage<CliqIdListPageViewModel> {
  @override
  CliqIdListPageState createState() => CliqIdListPageState();
}

class CliqIdListPageState extends BaseStatefulPage<CliqIdListPageViewModel, CliqIdListPage> {
  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 18.0.w),
            child: Container(
              width: 28.w,
            ),
          ),
          Text(
            S.of(context).manageCliqId,
            style: TextStyle(
              fontSize: 14.t,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: StringUtils.appFont,
            ),
          ),
          InkWell(
            onTap: () async {
              Navigator.pushNamed(context, RoutePaths.CreateCliqId);

              ///LOG EVENT TO FIREBASE
              await FireBaseLogUtil.fireBaseLog(
                  "navigation_alias_creation", {"navigated_alias_creation": true});
            },
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 24.0.w),
              child: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildView(BuildContext context, CliqIdListPageViewModel model) {
    return CliqIdListPageView(provideBase());
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  void onModelReady(CliqIdListPageViewModel model) {
    //  model.getAlias(true);
    super.onModelReady(model);
  }

  @override
  ProviderBase provideBase() {
    return cliqIdListViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}

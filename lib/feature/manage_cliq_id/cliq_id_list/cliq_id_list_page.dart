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

import '../../../ui/molecules/app_svg.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';

class CliqIdListPage extends BasePage<CliqIdListPageViewModel> {
  @override
  CliqIdListPageState createState() => CliqIdListPageState();
}

class CliqIdListPageState extends BaseStatefulPage<CliqIdListPageViewModel, CliqIdListPage> {
  @override
  Widget buildView(BuildContext context, CliqIdListPageViewModel model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 45.0.h),
          height: 80.h,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Container(
                padding: EdgeInsets.only(top: 7.0.h),
                child: Text(
                  S.of(context).manageCliqId,
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 14.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              PositionedDirectional(
                end: 24.0.w,
                top: 0,
                bottom: 8,
                child: Container(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pushNamed(context, RoutePaths.CreateCliqId);

                      ///LOG EVENT TO FIREBASE
                      await FireBaseLogUtil.fireBaseLog(
                          "navigation_alias_creation", {"navigated_alias_creation": true});
                    },
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: 24.h),
                padding: EdgeInsets.only(top: 47.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
                child: CliqIdListPageView(provideBase()),
              ),
              Positioned(
                top: 0.h,
                child: InkWell(
                  onTap: () {
                    // ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateBackToMainPage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                        ]),
                    child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  void onModelReady(CliqIdListPageViewModel model) {
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

class CliqIdListPage extends BasePage<CliqIdListPageViewModel> {
  @override
  CliqIdListPageState createState() => CliqIdListPageState();
}

class CliqIdListPageState extends BaseStatefulPage<CliqIdListPageViewModel, CliqIdListPage> {
  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 18.0),
            child: Container(
              width: 28,
            ),
          ),
          Text(
            S.of(context).manageCliqId,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).accentColor,
            ),
          ),
          InkWell(
            onTap: () {
              /*    CliqInformationDialog.show(context,
                  image: AssetUtils.walletIcon,
                  title: S.of(context).changeDefaultAccount,
                  description: S.of(context).areYourToChangeDefaultAccountOfYourCliqId,
                  subDescription: S.of(context).whenAcceptingCreationOfYourCliqId, onSelected: () {
                Navigator.pop(context);
              }, onDismissed: () {
                Navigator.pop(context);
              });*/

              Navigator.pushNamed(context, RoutePaths.CreateCliqId);
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 24.0),
              child: Icon(Icons.add, color: Theme.of(context).accentColor),
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

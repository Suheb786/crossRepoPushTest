import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_list/cliq_id_list_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CliqIdListPageView extends BasePageViewWidget<CliqIdListPageViewModel> {
  CliqIdListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CliqIdListPageViewModel model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 24),
            height: 4,
            width: 64,
            decoration: BoxDecoration(color: AppColor.white_gray, borderRadius: BorderRadius.circular(4)),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 96,
                          width: 96,
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).inputDecorationTheme.hintStyle!.color!)),
                          child: Container(
                              padding: EdgeInsets.all(32), child: AppSvg.asset(AssetUtils.cliqLogo)),
                        ),
                        Text(
                          S.of(context).NoCliqContactYet,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.CreateCliqId);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        padding: EdgeInsets.all(18),
                        height: 56,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).accentTextTheme.bodyText1?.color,
                        ),
                        child: Center(
                          child: Text(S.of(context).createCliqId,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  color: Theme.of(context).accentColor)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

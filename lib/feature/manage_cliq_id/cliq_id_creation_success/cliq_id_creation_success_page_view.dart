import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_creation_success/cliq_id_creation_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CliqIdCreationSuccessPageView
    extends BasePageViewWidget<CliqIdCreationSuccessPageViewModel> {
  CliqIdCreationSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 92),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AssetUtils.line),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 111.37,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.vividYellow,
                    ),
                    child: Center(child: AppSvg.asset(AssetUtils.right)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 56),
              child: Text(
                S.of(context).cliqIdCreateSuccessFully,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, right: 24, left: 24),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).alias,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "zeinmalhas3",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.only(top: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvg.asset(AssetUtils.share,
                        color:
                            Theme.of(context).accentTextTheme.bodyText1!.color),
                    Padding(
                      padding: EdgeInsets.only(left: 11),
                      child: Text(
                        S.of(context).shareCliqId,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .color),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            AnimatedButton(
              buttonText: S.of(context).swipeToProceed,
              borderColor: Theme.of(context).accentColor,
              textColor: Theme.of(context).accentColor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 9, bottom: 16),
              child: Text(
                S.of(context).toManageCliq,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

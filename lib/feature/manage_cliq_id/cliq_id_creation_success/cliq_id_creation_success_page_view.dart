import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/cliq_id_creation_success/cliq_id_creation_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CliqIdCreationSuccessPageView extends BasePageViewWidget<CliqIdCreationSuccessPageViewModel> {
  CliqIdCreationSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          ProviderScope.containerOf(context).read(cliqIdListViewModelProvider).getAlias(true);
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 92.h),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AssetUtils.line),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 111.37.h,
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
              padding: EdgeInsets.only(top: 56.h),
              child: Text(
                S.of(context).cliqIdCreateSuccessFully,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.t),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 40.h, end: 24.w, start: 24.w),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ProviderScope.containerOf(context)
                                  .read(cliqIdTypeSelectionViewModelProvider)
                                  .cliqIdTypeController
                                  .text ==
                              S.of(context).alias
                          ? S.of(context).alias
                          : S.of(context).mobileNumber,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.t,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ProviderScope.containerOf(context)
                                  .read(cliqIdTypeSelectionViewModelProvider)
                                  .cliqIdTypeController
                                  .text ==
                              S.of(context).alias
                          ? ProviderScope.containerOf(context)
                              .read(cliqIdTypeSelectionViewModelProvider)
                              .aliasController
                              .text
                          : ProviderScope.containerOf(context)
                              .read(cliqIdTypeSelectionViewModelProvider)
                              .mobileNumberController
                              .text,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.t,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: GestureDetector(
                onTap: () {
                  model.shareFiles(context,
                      "${S.of(context).cliqIdType} - ${model.arguments.cliqType} \n${S.of(context).cliqID} -  ${model.arguments.cliqName}");
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 23.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSvg.asset(AssetUtils.share,
                          color: Theme.of(context).accentTextTheme.bodyText1!.color),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 11.w),
                        child: Text(
                          S.of(context).shareCliqId,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.t,
                              color: Theme.of(context).accentTextTheme.bodyText1!.color),
                        ),
                      )
                    ],
                  ),
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
              padding: EdgeInsets.only(top: 9.h, bottom: 16.h),
              child: Text(
                S.of(context).toManageCliq,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).accentColor,
                    fontSize: 12.t,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

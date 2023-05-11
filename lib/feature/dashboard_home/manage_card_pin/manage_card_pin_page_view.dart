import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ManageCardPinPageView extends BasePageViewWidget<ManageCardPinViewModel> {
  ManageCardPinPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        int sensitivity = 8;
        if (details.primaryVelocity! > sensitivity) {
          Navigator.pop(context);
        } else if (details.primaryVelocity! < -sensitivity) {}
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Center(
            child: Text(
              S.of(context).manageCardPin,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.t),
            ),
          ),
          SizedBox(
            height: 35.h,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Column(
              children: [
                Container(
                  height: 4.h,
                  width: 64.w,
                  margin: EdgeInsets.only(top: 8.h),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColor.whiteGray),
                ),
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Column(children: [
                    AppStreamBuilder<Resource<bool>>(
                      initialData: Resource.none(),
                      stream: model.unblockCardPinStream,
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          Navigator.pushReplacementNamed(context, RoutePaths.CardPinUnBlockSuccess,
                              arguments: model.manageCardPinArguments);
                        }
                      },
                      dataBuilder: (context, data) {
                        return InkWell(
                          onTap: () {
                            InformationDialog.show(context,
                                image: AssetUtils.cardIcon,
                                title: S.of(context).unBlockPin,
                                descriptionWidget: Text(
                                  S.of(context).unBlockPinDescription,
                                  style:
                                      TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.t, height: 1.7),
                                ), onSelected: () {
                              Navigator.pop(context);
                              if (model.manageCardPinArguments?.cardType == CardType.DEBIT) {
                                if (model.manageCardPinArguments!.freezeCardStatusEnum ==
                                    FreezeCardStatusEnum.PRE) {
                                  model.unBlockDebitCardPin(
                                      pinCode: '', tokenizedPan: model.manageCardPinArguments!.tokenizedPan);
                                }
                              } else {
                                if (model.manageCardPinArguments!.freezeCardStatusEnum ==
                                    FreezeCardStatusEnum.B) {
                                  model.unBlockCreditCardPin(
                                      cardCode: model.manageCardPinArguments!.tokenizedPan);
                                }
                              }
                            }, onDismissed: () {
                              Navigator.pop(context);
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  S.of(context).unblockCardPin,
                                  style:
                                      TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600),
                                )),
                                AppSvg.asset(AssetUtils.rightChevron,
                                    width: 20.w,
                                    height: 20.h,
                                    color: Theme.of(context).primaryTextTheme.bodyText1!.color)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    AppDivider(),
                    InkWell(
                      onTap: (model.manageCardPinArguments?.isChangePinEnabled ?? true)
                          ? () {
                              Navigator.pushNamed(context, RoutePaths.ChangeCardPin);
                            }
                          : () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              S.of(context).changeCardPin,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w600,
                                  color: (model.manageCardPinArguments?.isChangePinEnabled ?? true)
                                      ? Theme.of(context).primaryColorDark
                                      : Theme.of(context).inputDecorationTheme.hintStyle!.color ??
                                          AppColor.gray1),
                            )),
                            AppSvg.asset(AssetUtils.rightChevron,
                                width: 20.w,
                                height: 20.h,
                                color: (model.manageCardPinArguments?.isChangePinEnabled ?? true)
                                    ? Theme.of(context).primaryTextTheme.bodyText1!.color
                                    : Theme.of(context).inputDecorationTheme.hintStyle!.color ??
                                        AppColor.gray1),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

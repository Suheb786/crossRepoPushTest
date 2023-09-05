import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/offer_campaign/offer_campaign_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import 'offer_for_you_page_view.dart';
import 'offer_for_you_page_view_model.dart';

class OfferForYouPage extends BasePage<OfferForYouPageViewModel> {
  OfferForYouPage();

  @override
  OfferForYouPageState createState() => OfferForYouPageState();
}

class OfferForYouPageState extends BaseStatefulPage<OfferForYouPageViewModel, OfferForYouPage> {
  @override
  ProviderBase provideBase() {
    return offerForYouPageViewModelProvider;
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.onSecondaryContainer;
  }

  @override
  Widget buildView(BuildContext context, OfferForYouPageViewModel model) {
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
                  S.of(context).forYou,
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 14.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary),
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
                margin: EdgeInsetsDirectional.only(
                  top: 24.h,
                ),
                padding: EdgeInsets.only(top: 47.h, left: 24.w, right: 24.w),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
                child: OfferForYouPageView(provideBase()),
              ),
              Positioned(
                top: 0.h,
                child: InkWell(
                  onTap: () {
                    model.animateBackToDashboard(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1.w),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                        ]),
                    child: AppSvg.asset(
                      AssetUtils.down,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

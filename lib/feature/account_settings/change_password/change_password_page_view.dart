import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/change_password_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_password/enter_new_password/enter_new_password_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ChangePasswordPageView
    extends BasePageViewWidget<ChangePasswordPageViewModel> {
  final pages = [EnterNewPasswordPage(), BaseCardPage()];

  ChangePasswordPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme
          .of(context)
          .primaryColor,
      padding: EdgeInsets.only(top: 56),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: AppSvg.asset(AssetUtils.leftArrow,
                    color: Theme
                        .of(context)
                        .accentColor),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 36),
                child: AppStreamBuilder<int>(
                  stream: model.currentPageStream,
                  initialData: 0,
                  dataBuilder: (context, currentStep) {
                    return Column(
                      children: [
                        Text(
                          S
                              .of(context)
                              .changePassword
                              .toUpperCase(),
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 32, left: 24, right: 24),
                          child: ShowUpAnimation(
                            key: ValueKey(currentStep),
                            delayStart: Duration(milliseconds: 50),
                            animationDuration: Duration(milliseconds: 750),
                            curve: Curves.easeInOut,
                            direction: Direction.vertical,
                            offset: 0.5,
                            child: Text(
                              StepTextHelper.changePasswordTextHelper(
                                  currentStep ?? 0,
                                  S
                                      .of(context)
                                      .createYourLoginPassword),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AppSwiper(
                            pages: pages,
                            pageController: model.swiperController,
                            onIndexChanged: (index) {
                              model.changeCurrentPage(index);
                            },
                            currentStep: currentStep,
                          ),
                        )
                      ],
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}

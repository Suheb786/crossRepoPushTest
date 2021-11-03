import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/terms_and_condition/terms_and_condition_modules.dart';
import 'package:neo_bank/feature/terms_and_condition/terms_and_condition_page_view.dart';
import 'package:neo_bank/feature/terms_and_condition/terms_and_condition_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class TermsAndConditionPage extends BasePage<TermsAndConditionPageViewModel> {
  @override
  TermsAndConditionPageState createState() => TermsAndConditionPageState();
}

class TermsAndConditionPageState extends BaseStatefulPage<
    TermsAndConditionPageViewModel, TermsAndConditionPage> {
  @override
  ProviderBase provideBase() {
    return termsAndConditionViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 106),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: AppSvg.asset(AssetUtils.leftArrow),
              ),
            ),
            Text(
              S.of(context).termsConditions,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.very_dark_gray),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Container(
                width: 28,
              ),
            )
          ],
        ));
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color scaffoldBackgroundColor() {
    return AppColor.very_pale_blue_white;
  }

  @override
  Widget buildView(BuildContext context, TermsAndConditionPageViewModel model) {
    return TermsAndConditionPageView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/static_content/static_content_modules.dart';
import 'package:neo_bank/feature/static_content/reference_number/reference_number_page_view-model.dart';
import 'package:neo_bank/feature/static_content/reference_number/reference_number_page_view.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ReferenceNumberPage extends BasePage<ReferenceNumberPageViewModel> {
  @override
  ReferenceNumberPageState createState() => ReferenceNumberPageState();
}

class ReferenceNumberPageState extends BaseStatefulPage<
    ReferenceNumberPageViewModel,
    ReferenceNumberPage> {
  @override
  ProviderBase provideBase() {
    return referenceNumberViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
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
            Flexible(
              child: Text(
                S
                    .of(context)
                    .referenceNumberSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme
                        .of(context)
                        .accentColor),
              ),
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
  Color? scaffoldBackgroundColor() {
    return Theme
        .of(context)
        .primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ReferenceNumberPageViewModel model) {
    return ReferenceNumberPageView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/static_content/static_content_modules.dart';
import 'package:neo_bank/feature/static_content/exempt_payee_code/exempt_payee_code_page_view.dart';
import 'package:neo_bank/feature/static_content/exempt_payee_code/exempt_payee_code_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ExemptPayeeCodePage extends BasePage<ExemptPayeeCodePageViewModel> {
  @override
  ExemptPayeeCodePageState createState() => ExemptPayeeCodePageState();
}

class ExemptPayeeCodePageState extends BaseStatefulPage<ExemptPayeeCodePageViewModel, ExemptPayeeCodePage> {
  @override
  ProviderBase provideBase() {
    return exemptPayeeCodeViewModelProvider;
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
                padding: const EdgeInsetsDirectional.only(start: 24.0),
                child: AppSvg.asset(AssetUtils.leftArrow,
                    matchTextDirection: true, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Text(
              S.of(context).exemptPayeeCode,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 18.0),
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
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ExemptPayeeCodePageViewModel model) {
    return ExemptPayeeCodePageView(provideBase());
  }
}

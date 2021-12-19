import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/my_documents/my_documents_page_view.dart';
import 'package:neo_bank/feature/account_settings/my_documents/my_documents_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class MyDocumentsPage extends BasePage<MyDocumentsPageViewModel> {
  @override
  MyDocumentsPageState createState() => MyDocumentsPageState();
}

class MyDocumentsPageState
    extends BaseStatefulPage<MyDocumentsPageViewModel, MyDocumentsPage> {
  @override
  ProviderBase provideBase() {
    return myDocumentsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme
        .of(context)
        .primaryColor;
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
            Text(
              S
                  .of(context)
                  .myDocuments,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme
                      .of(context)
                      .accentColor),
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
  Widget buildView(BuildContext context, MyDocumentsPageViewModel model) {
    return MyDocumentsPageView(provideBase());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog.dart';
import 'package:neo_bank/utils/color_utils.dart';

class DashboardPage extends BasePage<DashboardPageViewModel> {
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState
    extends BaseStatefulPage<DashboardPageViewModel, DashboardPage> {
  @override
  ProviderBase provideBase() {
    return dashboardViewModelProvider;
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Color scaffoldBackgroundColor() {
    return AppColor.very_pale_blue_white;
  }

  @override
  void onModelReady(DashboardPageViewModel model) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      BiometricLoginDialog.show(context, mayBeLater: () {
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget buildView(BuildContext context, DashboardPageViewModel model) {
    return DashboardPageView(provideBase());
  }
}

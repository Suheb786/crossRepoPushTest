import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard_dialog/dashboard_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/utils/color_utils.dart';

class DashboardDialogView extends StatelessWidget {
  const DashboardDialogView();

  ProviderBase providerBase() {
    return dashboardDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).primaryColorDark.withOpacity(0.4),
        child: Padding(
          padding: EdgeInsets.only(top: 500.0),
          child: BaseWidget<DashboardDialogViewModel>(
              builder: (data, model, child) {
                return Column(
                  children: [
                    Expanded(
                      child: AppSwiper(
                        pageController: model!.pageController,
                        pages: [
                          Container(
                            child: AspectRatio(
                              aspectRatio: 0.64,
                              child: Container(
                                color: AppColor.vivid_red,
                              ),
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 0.64,
                            child: Container(
                              color: AppColor.whiteGray,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              providerBase: providerBase()),
        ));
  }
}

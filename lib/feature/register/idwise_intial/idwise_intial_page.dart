import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/idwise_intial/idwise_intial_page_view.dart';
import 'package:neo_bank/feature/register/idwise_intial/idwise_intial_page_view_model.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:riverpod/src/framework.dart';

class IdWiseIntialPage extends BasePage<IdWiseIntialPageViewModel> {
  @override
  State<StatefulWidget> createState() => IdWiseIntialPageState();
}

class IdWiseIntialPageState extends BaseStatefulPage<IdWiseIntialPageViewModel, IdWiseIntialPage> {
  @override
  Widget buildView(BuildContext context, IdWiseIntialPageViewModel model) {
    return IdWiseIntialPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return idWiseIntialPageViewModel;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            children: [
              SizedBox(
                height: 56.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: index == 0
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.background,
                    ),
                    height: 4.h,
                    width: 63.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

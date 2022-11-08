import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pall_all_postpaid_bills_page.dart';
import 'package:neo_bank/feature/postpaid_bills/view_postpaid_bills/view_postpaid_bills_page.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

import 'launcher_page_view_model.dart';

class LauncherPageView extends BasePageViewWidget<LauncherPageViewModel> {
  LauncherPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, LauncherPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutePaths.PayAllPostPaidBillsPage,
                      arguments:
                          PayAllPostPaidBillsPageArguments(PostPaidBillsPayTypeOptionEnum.PAYALLBILLS));
                },
                child: Text('All Pay Bills')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutePaths.ViewPostPaidBillsPage,
                      arguments: ViewPostPaidBillsPageArguments(PostPaidBillsPayTypeOptionEnum.VIEWMYBILLS));
                },
                child: Text('view my Bills')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.NewBillsPage,
                  );
                },
                child: Text('Swipe Up for NewBillsPage')),
          ],
        ),
      ),
    );
  }
}

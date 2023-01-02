import 'dart:async';
import 'dart:io';

import 'package:data/helper/dynamic_link.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

class AppHomePage extends BasePage<AppHomeViewModel> {
  @override
  AppHomePageState createState() => AppHomePageState();
}

class AppHomePageState extends BaseStatefulPage<AppHomeViewModel, AppHomePage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  ProviderBase provideBase() {
    return appHomeViewModelProvider;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (Platform.isIOS) {
        debugPrint('-----Inside here------');
        getViewModel().timer = new Timer(
          const Duration(milliseconds: 1000),
          () {
            debugPrint('-----Inside here tooo------');
            getViewModel().initDynamicLink();
          },
        );
      } else {
        getViewModel().initDynamicLink();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onModelReady(AppHomeViewModel model) {
    // model.initDynamicLinkRequestStream.listen((event) {
    //   if (event.status == Status.SUCCESS) {
    //     debugPrint('------>${event?.path}');
    //     if (event != null ? event!.queryParameters.isNotEmpty : false) {
    //       var accountTitle = event?.queryParameters['accountTitle'];
    //       var accountNo = event?.queryParameters['accountNo'];
    //       var requestAmt = event?.queryParameters['requestAmt'];
    //       var dateTime = event?.queryParameters['dateTime'];
    //       if ((accountNo ?? '').isNotEmpty) {
    //         Navigator.pushNamed(context, RoutePaths.SendMoneyQrScanning,
    //             arguments: SendMoneyQRScanningArguments(
    //                 amount: requestAmt ?? '',
    //                 accountHolderName: accountTitle ?? '',
    //                 accountNo: accountNo ?? ''));
    //       }
    //     }
    //   }
    // });
    DynamicLinksService().initDynamicLinkRequestStream.listen((event) {
      if (event != null ? event.queryParameters.isNotEmpty : false) {
        var requestId = event.queryParameters['requestId'];

        model.verifyQR(requestId: requestId ?? '');
      }
    });

    super.onModelReady(model);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, AppHomeViewModel model) {
    model.deviceSize = MediaQuery.of(context).size;

    return AppHomePageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AppProgress {
  AppProgress(BuildContext context) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        barrierColor: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        useSafeArea: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
                child: Lottie.asset(AssetUtils.loaderAnimation1,
                    fit: BoxFit.cover, alignment: Alignment.center, width: 60, height: 60)),
          );
        });
  }
}

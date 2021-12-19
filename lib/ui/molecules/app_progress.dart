import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppProgress {
  AppProgress(BuildContext context) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.01),
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColor.verySoftRed.withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            AppColor.brightRed,
                          ),
                          strokeWidth: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

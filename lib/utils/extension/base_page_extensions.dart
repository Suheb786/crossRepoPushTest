import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_toast.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension PageExtensions on BaseStatefulPage {
  showShortToast(String message) {
    AppToast.showToast(message, duration: Toast.LENGTH_SHORT);
  }

  showLongToast(String message) {
    AppToast.showToast(message, duration: Toast.LENGTH_LONG);
  }

  showTopError(String message) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: EdgeInsetsDirectional.all(16),
              decoration: BoxDecoration(color: AppColor.dark_brown, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).error,
                          style: TextStyle(
                              // fontFamily: "Montserrat",
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 4.0, end: 16),
                          child: Text(message,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 5000),
        reverseAnimationDuration: Duration(milliseconds: 500),
        animationDuration: Duration(milliseconds: 700));
  }

  showTopSuccess(String message) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: EdgeInsetsDirectional.all(16),
              decoration: BoxDecoration(
                  color: AppColor.darkModerateLimeGreen, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).success,
                          style: TextStyle(
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 4.0, end: 16),
                          child: Text(message,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1000),
        reverseAnimationDuration: Duration(milliseconds: 200),
        animationDuration: Duration(milliseconds: 500));
  }

  showSuccessToastWithTitleAndDescription(String title, String description) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: EdgeInsetsDirectional.all(16),
              decoration: BoxDecoration(
                  color: AppColor.darkModerateLimeGreen, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 4.0, end: 16),
                          child: Text(description,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1000),
        reverseAnimationDuration: Duration(milliseconds: 200),
        animationDuration: Duration(milliseconds: 500));
  }
}

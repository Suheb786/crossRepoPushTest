import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../../utils/parser/error_parser.dart';
import 'change_my_email_dialog_view_model.dart';

class ChangeMyEmailDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  bool _keyboardVisible = false;
  final Function()? showError;

  ChangeMyEmailDialogView({this.onDismissed, this.onSelected, this.showError});

  ProviderBase providerBase() {
    return changeMyEmailDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<ChangeMyEmailDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36, top: _keyboardVisible ? 36.h : 204.h),
              child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      onDismissed?.call();
                    }
                  },
                  child: AppKeyBoardHide(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppTextField(
                            labelText: S.of(context).emailAddress,
                            hintText: S.of(context).pleaseEnter,
                            controller: model?.emailController,
                            key: model?.emailKey,
                            inputAction: TextInputAction.go,
                            inputType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              if (Validator.isEmpty(model?.emailController.text ?? '')) {
                                model?.showToastWithError(AppError(
                                    error: ErrorInfo(message: ''),
                                    type: ErrorType.EMPTY_EMAIL,
                                    cause: Exception()));
                              } else if (!Validator.validateEmail(model?.emailController.text ?? '')) {
                                model?.showToastWithError(AppError(
                                    error: ErrorInfo(message: ''),
                                    type: ErrorType.INVALID_EMAIL,
                                    cause: Exception()));
                              } else {
                                onSelected?.call(model?.emailController.text ?? '');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                              height: 57.h,
                              width: 57.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).textTheme.bodyLarge!.color!),
                              child: AppSvg.asset(AssetUtils.tick,
                                  color: Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0.h),
                            child: Center(
                              child: Text(
                                S.of(context).swipeDownToCancel,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 10.t,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.dark_gray_1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
        },
        onModelReady: (model) {
          model.error.listen((event) {
            _showTopError(
                ErrorParser.getLocalisedStringError(
                  error: event,
                  localisedHelper: S.of(context),
                ),
                context);
          });
        },
        providerBase: providerBase());
  }
}

_showTopError(String message, BuildContext context) {
  showTopSnackBar(
      Overlay.of(context),
      Material(
        color: AppColor.white.withOpacity(0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                            fontFamily: StringUtils.appFont,
                            color: AppColor.light_grayish_violet,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.t),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0.h, right: 16.w),
                        child: Text(message,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.t)),
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
      displayDuration: Duration(milliseconds: 1500),
      reverseAnimationDuration: Duration(milliseconds: 500),
      animationDuration: Duration(milliseconds: 700));
}

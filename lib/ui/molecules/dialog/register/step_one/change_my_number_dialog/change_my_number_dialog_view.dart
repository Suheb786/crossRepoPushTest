import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/change_my_number_dialog/change_my_number_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/mobile_number_dialog/mobile_number_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChangeMyNumberDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(CountryData, String)? onSelected;
  bool _keyboardVisible = false;
  final List<CountryData> countryDataList;
  final Function()? showError;

  ChangeMyNumberDialogView(
      {this.onDismissed, this.onSelected, required this.countryDataList, this.showError});

  ProviderBase providerBase() {
    return changeMyNumberDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<ChangeMyNumberDialogViewModel>(
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
                          AppStreamBuilder<CountryData>(
                            initialData: CountryData(),
                            stream: model!.getSelectedCountryStream,
                            dataBuilder: (context, selectedCountry) {
                              return AppTextField(
                                labelText: S.of(context).mobileNumber.toUpperCase(),
                                hintText: S.of(context).mobileNumberHint,
                                inputType: TextInputType.phone,
                                inputAction: TextInputAction.done,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(model.countryData.mobileMax),
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                controller: model.mobileNumberController,
                                key: model.mobileNumberKey,
                                onChanged: (value) {},
                                prefixIcon: () {
                                  return InkWell(
                                    onTap: () {
                                      MobileNumberDialog.show(context,
                                          title: S.of(context).mobileNumber,
                                          selectedCountryData: model.countryData, onSelected: (data) {
                                        Navigator.pop(context);
                                        model.countryData = data;
                                        model.setSelectedCountry(data);
                                      }, onDismissed: () {
                                        Navigator.pop(context);
                                      }, countryDataList: countryDataList);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.0.h),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColorDark,
                                              shape: BoxShape.circle,
                                            ),
                                            child: AppSvg.asset(selectedCountry!.isoCode3 != null
                                                ? "${AssetUtils.flags}${selectedCountry.isoCode3?.toLowerCase()}.svg"
                                                : "assets/flags/jor.svg"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(
                                                selectedCountry.phoneCode!.isNotEmpty
                                                    ? '+${selectedCountry.phoneCode!}'
                                                    : "",
                                                style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: Theme.of(context).indicatorColor,
                                                  fontSize: 14.t,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: 16.h,
                                              width: 16.w,
                                              margin: EdgeInsetsDirectional.only(end: 8.w),
                                              child: AppSvg.asset(
                                                AssetUtils.downArrow,
                                                color: Theme.of(context).indicatorColor,
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              if (model.mobileNumberController.text.isEmpty ||
                                  model.mobileNumberController.text.length < model.countryData.mobileMin!) {
                                model.showToastWithError(AppError(
                                    cause: Exception(),
                                    error: ErrorInfo(message: ''),
                                    type: ErrorType.INVALID_MOBILE));
                              } else {
                                onSelected?.call(model.countryData, model.mobileNumberController.text);
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
          if (!model.initialDataSet) {
            if (countryDataList.length > 0) {
              model.countryData = countryDataList.firstWhere((element) => element.isoCode3 == 'JOR',
                  orElse: () => countryDataList.first);
              model.setSelectedCountry(model.countryData);
              model.initialDataSet = true;
            }
          }
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
}

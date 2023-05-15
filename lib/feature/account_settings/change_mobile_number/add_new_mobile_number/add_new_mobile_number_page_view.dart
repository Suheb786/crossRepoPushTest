import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/add_new_mobile_number/add_new_mobile_number_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/mobile_number_dialog/mobile_number_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AddNewMobileNumberPageView extends BasePageViewWidget<AddNewMobileNumberPageViewModel> {
  AddNewMobileNumberPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
        stream: model.errorDetectorStream,
        initialData: false,
        dataBuilder: (context, isValid) {
          return ShakeAnimatedWidget(
            enabled: isValid ?? false,
            duration: Duration(milliseconds: 100),
            shakeAngle: Rotation.deg(z: 1),
            curve: Curves.easeInOutSine,
            child: AppStreamBuilder<Resource<bool>>(
              stream: model.addNewMobileStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  ProviderScope.containerOf(context).read(changeMobileNumberViewModelProvider).nextPage();
                  // .next(animation: true);
                  // ProviderScope?.containerOf(context)
                  //         .read(enterOtpForNewMobileNumberViewModelProvider)
                  //         .countDownController =
                  //     CountdownTimerController(
                  //         endTime: ProviderScope?.containerOf(context)
                  //             .read(enterOtpForNewMobileNumberViewModelProvider)
                  //             .endTime);
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    FocusScope.of(context).unfocus();
                    if (StringUtils.isDirectionRTL(context)) {
                      if (!details.primaryVelocity!.isNegative) {
                        model.changeMobileNumber();
                      }
                    } else {
                      if (details.primaryVelocity!.isNegative) {
                        model.changeMobileNumber();
                      }
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                  physics: ClampingScrollPhysics(),
                                  child: AppStreamBuilder<Resource<AllowedCountryListResponse>>(
                                    stream: model.getAllowedCountryStream,
                                    initialData: Resource.none(),
                                    dataBuilder: (context, country) {
                                      return AppStreamBuilder<CountryData>(
                                        stream: model.getSelectedCountryStream,
                                        initialData: CountryData(),
                                        dataBuilder: (context, countryData) {
                                          return AppTextField(
                                            labelText: S.of(context).mobileNumber.toUpperCase(),
                                            hintText: S.of(context).mobileNumberHint,
                                            inputType: TextInputType.phone,
                                            inputAction: TextInputAction.done,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(model.countryData.mobileMax),
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            ],
                                            controller: model.mobileController,
                                            key: model.mobileKey,
                                            onChanged: (value) {
                                              model.validate();
                                            },
                                            prefixIcon: () {
                                              return InkWell(
                                                onTap: () {
                                                  MobileNumberDialog.show(context,
                                                      title: S.of(context).mobileNumber,
                                                      selectedCountryData: model.countryData,
                                                      onSelected: (data) {
                                                    Navigator.pop(context);
                                                    model.countryData = data;
                                                    model.setSelectedCountry(data);
                                                  }, onDismissed: () {
                                                    Navigator.pop(context);
                                                  },
                                                      countryDataList:
                                                          country!.data!.contentData!.countryData);
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
                                                        child: AppSvg.asset(countryData!.isoCode3 != null
                                                            ? "${AssetUtils.flags}${countryData.isoCode3?.toLowerCase()}.svg"
                                                            : "assets/flags/jor.svg"),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                                        child: Directionality(
                                                          textDirection: TextDirection.ltr,
                                                          child: Text(
                                                            countryData.phoneCode!.isNotEmpty
                                                                ? '+${countryData.phoneCode!}'
                                                                : "",
                                                            style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              color: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.color,
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
                                                          child: AppSvg.asset(AssetUtils.downArrow,
                                                              color: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .bodyLarge
                                                                  ?.color))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0.h),
                              child: AppStreamBuilder<bool>(
                                  stream: model.showButtonStream,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return Visibility(
                                      visible: isValid!,
                                      child: AnimatedButton(
                                        buttonHeight: 50,
                                        buttonText: S.of(context).swipeToProceed,
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/mobile_number_dialog/mobile_number_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../utils/color_utils.dart';

class AddNumberPageView extends BasePageViewWidget<AddNumberViewModel> {
  AddNumberPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
              enabled: isError ?? false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: AppStreamBuilder<Resource<bool>>(
                stream: model.registerNumberStream,
                initialData: Resource.none(),
                onData: (data) {
                  print("data.status ${data.status}");
                  if (data.status == Status.SUCCESS) {
                    var event = {
                      "definitionId": "UserEvents",
                      "properties": {"emailId": '', "mobileNumber": model.mobileNumberController.text}
                    };
                    InfobipMobilemessaging.submitEventImmediately(event);
                    ProviderScope.containerOf(context).read(accountRegistrationViewModelProvider).nextPage();
                  } else if (data.status == Status.ERROR) {
                    model.showToastWithError(data.appError!);
                  }
                },
                dataBuilder: (context, data) {
                  return Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                        child: Column(
                          children: [
                            AppStreamBuilder<Resource<AllowedCountryListResponse>>(
                              initialData: Resource.success(data: AllowedCountryListResponse()),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  ProviderScope.containerOf(context)
                                      .read(accountRegistrationViewModelProvider)
                                      .countryDataList = data.data!.contentData!.countryData!;
                                }
                              },
                              stream: model.getAllowedCountryStream,
                              dataBuilder: (context, country) {
                                return AppStreamBuilder<CountryData>(
                                  initialData: CountryData(isoCode3: 'JOR', phoneCode: '962'),
                                  stream: model.getSelectedCountryStream,
                                  dataBuilder: (context, selectedCountry) {
                                    return AppStreamBuilder<Resource<CheckUsername>>(
                                      initialData: Resource.none(),
                                      stream: model.checkUserMobileStream,
                                      onData: (data) {
                                        if (data.status == Status.ERROR) {
                                          if (data.appError!.type == ErrorType.MOBILE_ALREADY_EXIST) {
                                            model.isMobileNoExist = 1;
                                          }
                                          model.showToastWithError(data.appError!);
                                          model.showErrorState();
                                        } else if (data.status == Status.SUCCESS) {
                                          ProviderScope.containerOf(context)
                                              .read(accountRegistrationViewModelProvider)
                                              .updateMobileNumber(MobileNumberParams(
                                                  mobileCode: model.countryData.phoneCode!,
                                                  mobileNumber: model.mobileNumberController.text));
                                        }
                                      },
                                      dataBuilder: (context, data) {
                                        debugPrint(
                                            'model.countryData.mobileMax--${model.countryData.mobileMax}');
                                        return Focus(
                                          onFocusChange: (hasFocus) {
                                            debugPrint('hasFocus--> ${hasFocus}');
                                            model.validateMobile();
                                          },
                                          child: AppTextField(
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
                                                    print('selectedData---->${data.phoneCode}');
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
                                                        height: 16.h,
                                                        width: 16.w,
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
                                                              color: Theme.of(context).indicatorColor,
                                                              fontSize: 14.t,
                                                              fontFamily: StringUtils.appFont,
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
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0.h),
                                  child: AppStreamBuilder<bool>(
                                      stream: model.showButtonStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return AppPrimaryButton(
                                          isDisabled: !isValid!,
                                          text: S.of(context).next,
                                          onPressed: () {
                                            model.validateNumber();
                                          },
                                        );
                                      }),
                                ),
                                InkWell(
                                  onTap: () {
                                    ProviderScope.containerOf(context)
                                        .read(accountRegistrationViewModelProvider)
                                        .previousPage();
                                  },
                                  child: Text(
                                    S.of(context).back,
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.brightBlue,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).viewInsets.bottom,
                            // ),
                          ],
                        )),
                  );
                },
              ),
            );
          }),
    );
  }
}

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_new_mobile_number/dc_enter_new_mobile_number_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/mobile_number_dialog/mobile_number_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class DcEnterNewMobileNumberPageView
    extends BasePageViewWidget<DcEnterNewMobileNumberPageViewModel> {
  DcEnterNewMobileNumberPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<bool>>(
          stream: model.enterMobileStream,
          onData: (data) {
            if (data.status == Status.SUCCESS) {
              ProviderScope.containerOf(context)
                  .read(dcChangeLinkedMobileNumberViewModelProvider)
                  .nextPage();
            } else if (data.status == Status.ERROR) {
              model.showToastWithError(data.appError!);
            }
          },
          initialData: Resource.none(),
          dataBuilder: (context, data) {
            return AppStreamBuilder<bool>(
              initialData: false,
              stream: model.errorDetectorStream,
              dataBuilder: (context, isError) {
                return ShakeAnimatedWidget(
                  enabled: isError ?? false,
                  duration: Duration(milliseconds: 100),
                  shakeAngle: Rotation.deg(z: 1),
                  curve: Curves.easeInOutSine,
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (ProviderScope.containerOf(context)
                              .read(dcChangeLinkedMobileNumberViewModelProvider)
                              .appSwiperController
                              .page ==
                          0.0) {
                        if (details.primaryVelocity!.isNegative) {
                          FocusScope.of(context).unfocus();
                          model.validateMobile(
                              ProviderScope.containerOf(context)
                                  .read(
                                      dcChangeLinkedMobileNumberViewModelProvider)
                                  .arguments!
                                  .tokenizedPan,
                              ProviderScope.containerOf(context)
                                  .read(
                                      dcChangeLinkedMobileNumberViewModelProvider)
                                  .arguments!
                                  .cardType);
                        } else {}
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                        child: Column(
                          children: [
                            AppStreamBuilder<
                                Resource<AllowedCountryListResponse>>(
                              initialData: Resource.success(
                                  data: AllowedCountryListResponse()),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  ProviderScope.containerOf(context)
                                          .read(
                                              accountRegistrationViewModelProvider)
                                          .countryDataList =
                                      data.data!.contentData!.countryData!;
                                }
                              },
                              stream: model.getAllowedCountryStream,
                              dataBuilder: (context, country) {
                                return AppStreamBuilder<CountryData>(
                                  initialData: CountryData(
                                      isoCode3: 'JOR', phoneCode: '962'),
                                  stream: model.getSelectedCountryStream,
                                  dataBuilder: (context, selectedCountry) {
                                    return AppTextField(
                                      labelText: S
                                          .of(context)
                                          .newMobileNumber
                                          .toUpperCase(),
                                      hintText: S.of(context).mobileNumberHint,
                                      inputType: TextInputType.phone,
                                      inputAction: TextInputAction.done,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                            model.countryData.mobileMax),
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
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
                                                title:
                                                    S.of(context).mobileNumber,
                                                selectedCountryData:
                                                    model.countryData,
                                                onSelected: (data) {
                                              Navigator.pop(context);
                                              model.countryData = data;
                                              model.setSelectedCountry(data);
                                            }, onDismissed: () {
                                              Navigator.pop(context);
                                            },
                                                countryDataList:
                                                    country!.status ==
                                                            Status.SUCCESS
                                                        ? country
                                                            .data!
                                                            .contentData!
                                                            .countryData
                                                        : []);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  height: 16,
                                                  width: 16,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColorDark,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: AppSvg.asset(selectedCountry!
                                                              .isoCode3 !=
                                                          null
                                                      ? "${AssetUtils.flags}${selectedCountry.isoCode3?.toLowerCase()}.svg"
                                                      : "assets/flags/jor.svg"),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    selectedCountry.phoneCode!
                                                            .isNotEmpty
                                                        ? '+${selectedCountry.phoneCode!}'
                                                        : "",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    height: 16,
                                                    width: 16,
                                                    margin: EdgeInsets.only(
                                                        right: 8),
                                                    child: AppSvg.asset(
                                                        AssetUtils.downArrow,
                                                        color: Theme.of(context)
                                                            .primaryTextTheme
                                                            .bodyText1!
                                                            .color))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                S.of(context).changeMobileNumberInfo,
                                style: TextStyle(
                                    color: AppColor.dark_gray_1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: AppStreamBuilder<bool>(
                                  stream: model.showButtonStream,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return Visibility(
                                      visible: isValid!,
                                      child: AnimatedButton(
                                        buttonText:
                                            S.of(context).swipeToProceed,
                                      ),
                                    );
                                  }),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                S.of(context).backToCardSettings,
                                style: TextStyle(
                                  color: AppColor.brightBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).viewInsets.bottom,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

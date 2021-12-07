import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

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
                    ProviderScope.containerOf(context)
                        .read(accountRegistrationViewModelProvider)
                        .pageController
                        .next();
                  } else if (data.status == Status.ERROR) {
                    model.showToastWithError(data.appError!);
                  }
                },
                dataBuilder: (context, data) {
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        model.validateNumber();
                      } else {
                        ProviderScope.containerOf(context)
                            .read(accountRegistrationViewModelProvider)
                            .pageController
                            .previous(animation: true);
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          child: Column(
                            children: [
                              AppStreamBuilder<Resource<CheckUsername>>(
                                initialData: Resource.none(),
                                stream: model.checkUserNameStream,
                                onData: (data) {
                                  if (data.status == Status.ERROR) {
                                    model.showToastWithError(data.appError!);
                                    model.showErrorState();
                                  }
                                },
                                dataBuilder: (context, data) {
                                  return AppTextField(
                                    labelText: S.of(context).emailAddress,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.emailController,
                                    key: model.emailKey,
                                    inputAction: TextInputAction.go,
                                    inputType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      model.validateEmail();
                                      model.validate();
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppStreamBuilder<
                                  Resource<AllowedCountryListResponse>>(
                                initialData: Resource.success(
                                    data: AllowedCountryListResponse()),
                                stream: model.getAllowedCountryStream,
                                dataBuilder: (context, country) {
                                  return AppStreamBuilder<
                                      Resource<CheckUsername>>(
                                    initialData: Resource.none(),
                                    stream: model.checkUserMobileStream,
                                    onData: (data) {
                                      if (data.status == Status.ERROR) {
                                        model
                                            .showToastWithError(data.appError!);
                                        model.showErrorState();
                                      }
                                    },
                                    dataBuilder: (context, data) {
                                      return AppTextField(
                                        labelText: S
                                            .of(context)
                                            .mobileNumber
                                            .toUpperCase(),
                                        hintText:
                                            S.of(context).mobileNumberHint,
                                        inputType: TextInputType.number,
                                        inputAction: TextInputAction.done,
                                        controller:
                                            model.mobileNumberController,
                                        key: model.mobileNumberKey,
                                        onChanged: (value) {
                                          model.validateMobile();
                                          model.validate();
                                        },
                                        prefixIcon: () {
                                          return InkWell(
                                            onTap: () {
                                              ///TODO: open country code dialog
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ///TODO:add country Flag
                                                  Container(
                                                      height: 16,
                                                      width: 16,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        shape: BoxShape.circle,
                                                      )),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Text(
                                                      country!
                                                                  .data!
                                                                  .contentData!
                                                                  .countryData!
                                                                  .first
                                                                  .phoneCode !=
                                                              null
                                                          ? '+${country.data!.contentData!.countryData!.first.phoneCode}'
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
                                                          color: Theme.of(
                                                                  context)
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
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}

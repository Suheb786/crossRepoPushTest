import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/add_new_mobile_number/add_new_mobile_number_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class AddNewMobileNumberPageView
    extends BasePageViewWidget<AddNewMobileNumberPageViewModel> {
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
                  ProviderScope.containerOf(context)
                      .read(changeMobileNumberViewModelProvider)
                      .swiperController
                      .next(animation: true);
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
                    if (details.primaryVelocity!.isNegative) {
                      model.changeMobileNumber();
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                  physics: ClampingScrollPhysics(),
                                  child: AppTextField(
                                    labelText: S
                                        .of(context)
                                        .mobileNumber
                                        .toUpperCase(),
                                    hintText: S.of(context).mobileNumberHint,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(9),
                                    ],
                                    controller: model.mobileController,
                                    key: model.mobileKey,
                                    onChanged: (value) {
                                      model.validate();
                                    },
                                    prefixIcon: () {
                                      return InkWell(
                                        onTap: () {},
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
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text(
                                                  '+962',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  height: 16,
                                                  width: 16,
                                                  margin:
                                                      EdgeInsets.only(right: 8),
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
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: AppStreamBuilder<bool>(
                                  stream: model.showButtonStream,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return Visibility(
                                      visible: isValid!,
                                      child: AnimatedButton(
                                        buttonHeight: 50,
                                        buttonText:
                                            S.of(context).swipeToProceed,
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

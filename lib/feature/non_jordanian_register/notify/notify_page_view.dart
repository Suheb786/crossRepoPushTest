import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/user/register_interest/register_interest_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/non_jordanian_register/notify/notify_page_view_model.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class NotifyPageView extends BasePageViewWidget<NotifyPageViewModel> {
  NotifyPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
                initialData: false,
                stream: model.errorDetectorStream,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<RegisterInterestResponse>>(
                      stream: model.notifyStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          Navigator.pushReplacementNamed(context, RoutePaths.NotifySuccess,
                              arguments: NotifySuccessArguments(
                                  referenceNo: data.data?.registerInterestContent?.referenceNo ?? '-'));
                        } else if (data.status == Status.ERROR) {
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, data) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            FocusScope.of(context).unfocus();
                            if (StringUtils.isDirectionRTL(context)) {
                              if (!details.primaryVelocity!.isNegative) {
                                model.notifyDetails();
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                model.notifyDetails();
                              }
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 2,
                            color: Theme.of(context).cardTheme.copyWith(color: AppColor.white).color,
                            margin: EdgeInsets.zero,
                            shadowColor: AppColor.black.withOpacity(0.32),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextField(
                                      labelText: S.of(context).emailAddress,
                                      hintText: S.of(context).pleaseEnter,
                                      controller: model.emailController,
                                      key: model.emailKey,
                                      inputAction: TextInputAction.go,
                                      inputType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        model.validate();
                                      },
                                    ),
                                    Column(
                                      children: [
                                        AppStreamBuilder<bool>(
                                            stream: model.showButtonStream,
                                            initialData: false,
                                            dataBuilder: (context, isValid) {
                                              return Visibility(
                                                visible: isValid!,
                                                child: AnimatedButton(
                                                  buttonText: S.of(context).swipeToProceed,
                                                ),
                                              );
                                            }),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            S.of(context).backToRegistration,
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
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/notify/notify_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class NotifyPageView extends BasePageViewWidget<NotifyPageViewModel> {
  NotifyPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Text(
            S.of(context).notifyMe,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 32),
            child: Text(
              S.of(context).pleaseEnterLatestEmail,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.very_dark_gray,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
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
                    child: AppStreamBuilder<Resource<bool>>(
                      stream: model.notifyStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          Navigator.pushReplacementNamed(
                              context, RoutePaths.NotifySuccess);
                        } else if (data.status == Status.ERROR) {
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, data) {
                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (details.primaryDelta!.isNegative) {
                              model.notifyDetails();
                            } else {
                              ProviderScope.containerOf(context)
                                  .read(registerStepOneViewModelProvider)
                                  .pageController
                                  .previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 24),
                                decoration: BoxDecoration(
                                  color: AppColor.very_soft_violet,
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColor.dark_violet,
                                        AppColor.dark_moderate_blue
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
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
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                      ],
                                    ),
                                    AppStreamBuilder<bool>(
                                        stream: model.showButtonStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return Visibility(
                                            visible: isValid!,
                                            child: Positioned(
                                              bottom: 0,
                                              left: 45,
                                              right: 45,
                                              child: AnimatedButton(
                                                buttonText: S
                                                    .of(context)
                                                    .swipeToProceed,
                                              ),
                                            ),
                                          );
                                        })
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

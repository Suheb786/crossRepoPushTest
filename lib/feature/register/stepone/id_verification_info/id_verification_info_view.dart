import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class IdVerificationInfoView
    extends BasePageViewWidget<IdVerificationInfoViewModel> {
  IdVerificationInfoView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, IdVerificationInfoViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.idVerificationResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            ProviderScope.containerOf(context)
                                .read(registerStepOneViewModelProvider)
                                .pageController
                                .nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                          } else if (data.status == Status.ERROR) {
                            model.showToastWithError(AppError(
                                error: ErrorInfo(message: ''),
                                type: ErrorType.INVALID_DECLARATION_SELECTION,
                                cause: Exception()));
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              if (details.primaryDelta!.isNegative) {
                                model.idVerificationInfo();
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
                              elevation: 2,
                              margin: EdgeInsets.zero,
                              shadowColor: AppColor.black.withOpacity(0.32),
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
                                      SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            InformationText(
                                                image: AssetUtils.sunny,
                                                title: S
                                                    .of(context)
                                                    .idVerificationPlaceInfo),
                                            SizedBox(
                                              height: 32,
                                            ),
                                            InformationText(
                                                image: AssetUtils.scan,
                                                title:
                                                    S.of(context).idScanInfo),
                                            SizedBox(
                                              height: 32,
                                            ),
                                            InformationText(
                                                image: AssetUtils.correct,
                                                title: S.of(context).onIdFit),
                                            SizedBox(
                                              height: 144,
                                            ),
                                            Row(
                                              children: [
                                                AppStreamBuilder<bool>(
                                                    stream: model
                                                        .isRetrievedConditionStream,
                                                    initialData: false,
                                                    dataBuilder:
                                                        (context, isChecked) {
                                                      return InkWell(
                                                        onTap: () {
                                                          if (isChecked ==
                                                              false) {
                                                            model
                                                                .updateIsRetrievedConditionStream(
                                                                    true);
                                                          } else {
                                                            model
                                                                .updateIsRetrievedConditionStream(
                                                                    false);
                                                          }
                                                        },
                                                        child: isChecked ==
                                                                false
                                                            ? AppSvg.asset(
                                                                AssetUtils
                                                                    .ellipse)
                                                            : AppSvg.asset(
                                                                AssetUtils
                                                                    .checkBox),
                                                      );
                                                    }),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .termsAndConditions,
                                                    style: TextStyle(
                                                        color: AppColor.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 45,
                                        child: AppStreamBuilder<bool>(
                                            stream: model
                                                .isRetrievedConditionStream,
                                            initialData: false,
                                            dataBuilder: (context, isChecked) {
                                              return Visibility(
                                                visible: isChecked!,
                                                child: AnimatedButton(
                                                  buttonText: S
                                                      .of(context)
                                                      .swipeToProceed,
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9/fatca_us_relevant_w9_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class FatcaUSRelevantW9PageView
    extends BasePageViewWidget<FatcaUSRelevantW9PageViewModel> {
  FatcaUSRelevantW9PageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Expanded(
          child: AppStreamBuilder<bool>(
            stream: model.errorDetectorStream,
            initialData: false,
            dataBuilder: (context, error) {
              return ShakeAnimatedWidget(
                enabled: error ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: AppStreamBuilder<Resource<bool>>(
                  stream: model.fatcaUSRelevantW8Stream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      model.updateData(context);
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope.containerOf(context)
                            .read(registerStepFourViewModelProvider)
                            .nextPage();
                        // .next();
                      });
                      ProviderScope.containerOf(context)
                          .read(fatcaUSRelevantW9AddressPageViewModelProvider)
                          .getStateList('USA');
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (ProviderScope.containerOf(context)
                                .read(registerStepFourViewModelProvider)
                                .appSwiperController
                                .page ==
                            4.0) {
                          if (details.primaryVelocity!.isNegative) {
                            model.validateFatcaUSRelevantW9Details();
                          } else {
                            Future.delayed(Duration(milliseconds: 500), () {
                              ProviderScope.containerOf(context)
                                  .read(registerStepFourViewModelProvider)
                                  .moveToPage(0);
                              // .move(0,animation:false);
                            });
                          }
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        color: Theme.of(context)
                            .cardTheme
                            .copyWith(color: AppColor.white)
                            .color,
                        margin: EdgeInsets.zero,
                        shadowColor: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.32),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        AppTextField(
                                          labelText: S
                                              .of(context)
                                              .nameAsPerIncomeTaxReturn,
                                          hintText: S.of(context).pleaseEnter,
                                          controller: model
                                              .nameAsPerTaxReturnController,
                                          key: model.nameAsPerTaxReturnKey,
                                          inputAction: TextInputAction.go,
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        AppTextField(
                                          labelText: S
                                              .of(context)
                                              .businessNameOptional,
                                          hintText: S.of(context).pleaseEnter,
                                          controller:
                                              model.businessNameController,
                                          inputType: TextInputType.text,
                                          inputAction: TextInputAction.go,
                                          key: model.businessNameKey,
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            S
                                                .of(context)
                                                .isBusinessNameDifferent,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 32),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.allFieldValidatorStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return (isValid!)
                                              ? AnimatedButton(
                                                  buttonText: S
                                                      .of(context)
                                                      .swipeToProceed,
                                                  buttonHeight: 50,
                                                )
                                              : Container();
                                        }),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}

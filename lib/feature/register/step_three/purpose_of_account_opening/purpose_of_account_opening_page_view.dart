import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/bank_smart/purpose_of_account_opening_response.dart';
import 'package:domain/model/register/expected_Transactionss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/purpose_of_account_opening/purpose_of_account_opening_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog.dart';
import 'package:neo_bank/ui/molecules/register/expected_transactions_selector_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PurposeOfAccountOpeningPageView extends BasePageViewWidget<PurposeOfAccountOpeningPageViewModel> {
  PurposeOfAccountOpeningPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Expanded(
          child: AppKeyBoardHide(
              child: AppStreamBuilder<bool>(
            stream: model.errorDetectorStream,
            initialData: false,
            dataBuilder: (context, error) {
              return ShakeAnimatedWidget(
                enabled: error ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: AppStreamBuilder<Resource<PurposeOfAccountOpeningResponse>>(
                  stream: model.purposeOfAccountOpeningStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope.containerOf(context)
                            .read(registerViewModelProvider)
                            .registrationStepsController
                            .nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                      });
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        FocusScope.of(context).unfocus();
                        if (StringUtils.isDirectionRTL(context)) {
                          if (!details.primaryVelocity!.isNegative) {
                            model.validatePurposeOfAccountOpening();
                          }
                        } else {
                          if (details.primaryVelocity!.isNegative) {
                            model.validatePurposeOfAccountOpening();
                          }
                        }
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom - 50.h <= 0
                                  ? 0
                                  : MediaQuery.of(context).viewInsets.bottom - 48.h),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                            physics: ClampingScrollPhysics(),
                            child: Column(
                              children: [
                                AppTextField(
                                  labelText: S.of(context).purposeOfAccountOpening,
                                  hintText: S.of(context).pleaseSelect,
                                  controller: model.purposeOfAccountOpeningController,
                                  key: model.purposeOfAccountOpeningKey,
                                  readOnly: true,
                                  onPressed: () {
                                    PurposeOfAccountOpeningDialog.show(context, onDismissed: () {
                                      Navigator.pop(context);
                                    }, onSelected: (value, englishValue) {
                                      Navigator.pop(context);
                                      model.updatePurposeOfAccountOpening(value, englishValue);
                                      model.isValid();
                                    });
                                  },
                                  suffixIcon: (value, data) {
                                    return Container(
                                        height: 16.h,
                                        width: 16.w,
                                        padding: EdgeInsetsDirectional.only(end: 8.w),
                                        child:
                                            AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                                  },
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                AppStreamBuilder<Resource<List<ExpectedTransactions>>>(
                                  stream: model.getExpectedTransactionsStream,
                                  initialData: Resource.none(),
                                  dataBuilder: (context, expectedTransactions) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).typeOfExpectedTransactions,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: Theme.of(context).primaryColorDark,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.t),
                                        ),
                                        ListView.builder(
                                          itemBuilder: (context, index) {
                                            return ExpectedTransactionsSelectorWidget(
                                              expectedTransactions: expectedTransactions!.data![index],
                                              onTap: () {
                                                model.selectExpectedTransactions(index);
                                              },
                                            );
                                          },
                                          physics: ClampingScrollPhysics(),
                                          padding: EdgeInsetsDirectional.only(top: 16.h, bottom: 8.h),
                                          itemCount: expectedTransactions!.data!.length,
                                          shrinkWrap: true,
                                        )
                                      ],
                                    );
                                  },
                                ),
                                AppTextField(
                                  labelText: S.of(context).expectedMonthlyAmount.toUpperCase(),
                                  hintText: '',
                                  controller: model.expectedMonthlyTransactionController,
                                  key: model.expectedMonthlyTransactionKey,
                                  inputType: TextInputType.number,
                                  inputAction: TextInputAction.done,
                                  prefixIcon: () {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.only(top: 8.0.h, end: 8.w),
                                      child: Text(
                                        S.of(context).JOD,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14.t,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryTextTheme.bodyMedium?.color!),
                                      ),
                                    );
                                  },
                                  onChanged: (value) {
                                    model.isValid();
                                  },
                                ),
                                Visibility(
                                  visible: false,
                                  child: SizedBox(
                                    height: 16.h,
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: AppTextField(
                                    labelText: S.of(context).expectedAnnualTransactions,
                                    hintText: '',
                                    controller: model.expectedAnnualTransactionController,
                                    key: model.expectedAnnualTransactionKey,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    prefixIcon: () {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.only(top: 8.0.h, end: 8.w),
                                        child: Text(
                                          S.of(context).JOD,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).primaryTextTheme.bodyLarge?.color!),
                                        ),
                                      );
                                    },
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(top: 24.h),
                                  child: AppStreamBuilder<bool>(
                                      stream: model.allFieldValidatorStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return (isValid!)
                                            ? AnimatedButton(
                                                buttonText: S.of(context).swipeToProceed,
                                                buttonHeight: 50,
                                              )
                                            : Container();
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )),
        ),
      ],
    );
  }
}

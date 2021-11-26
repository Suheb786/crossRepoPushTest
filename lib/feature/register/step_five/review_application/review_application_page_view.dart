import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/review_application/review_application_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/register/review_application_non_editable_items.dart';
import 'package:neo_bank/ui/molecules/register/start_over_widget.dart';
import 'package:neo_bank/ui/molecules/review_application/review_item.dart';
import 'package:neo_bank/ui/molecules/review_application/review_term_cond_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ReviewApplicationPageView
    extends BasePageViewWidget<ReviewApplicationPageViewModel> {
  ReviewApplicationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
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
                  child: AppStreamBuilder<Resource<String>>(
                    stream: model.getConfirmApplicationDataStream,
                    initialData: Resource.none(),
                    onData: (getConfirmApplicationData) {
                      if (getConfirmApplicationData.status == Status.SUCCESS) {
                        ///TODO:update ui with response data
                      }
                    },
                    dataBuilder: (context, data) {
                      return AppStreamBuilder<Resource<List<String>>>(
                        stream: model.reviewAppStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            ///check for videocall call status
                            model.checkVideoCallStatus();
                          } else if (data.status == Status.ERROR) {
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, response) {
                          return AppStreamBuilder<
                              Resource<CheckVideoCallResponse>>(
                            stream: model.checkVideoCallStream,
                            initialData: Resource.none(),
                            onData: (data) {
                              ///video call status is false then call get account
                              if (data.status == Status.SUCCESS) {
                                if (!(data.data!.checkVideoCallResponseContent!
                                    .status!)) {
                                  model.getAccount();
                                }
                              }
                            },
                            dataBuilder: (context, status) {
                              return AppStreamBuilder<
                                  Resource<GetAccountResponse>>(
                                stream: model.getAccountStream,
                                initialData: Resource.none(),
                                onData: (getAccountResponse) {
                                  if (getAccountResponse.status ==
                                      Status.SUCCESS) {
                                    ///create account called
                                    model.createAccount(
                                        getAccountResponse
                                            .data!.content!.accountDetails!,
                                        getAccountResponse.data!.content!
                                            .customerInformation!);
                                  }
                                },
                                dataBuilder: (context, data) {
                                  return AppStreamBuilder<Resource<String>>(
                                    stream: model.createAccountStream,
                                    initialData: Resource.none(),
                                    onData: (createAccountResponse) {
                                      if (createAccountResponse.status ==
                                          Status.SUCCESS) {
                                        ProviderScope.containerOf(context)
                                            .read(
                                                registerStepFiveViewModelProvider)
                                            .registrationStepFivePageController
                                            .nextPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeInOut);
                                      }
                                    },
                                    dataBuilder: (context, data) {
                                      return GestureDetector(
                                        onHorizontalDragEnd: (details) {
                                          if (details
                                              .primaryVelocity!.isNegative) {
                                            model.validateReviewDetails();
                                          }
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          elevation: 2,
                                          color: Theme.of(context)
                                              .cardTheme
                                              .copyWith(color: AppColor.white)
                                              .color,
                                          margin: EdgeInsets.zero,
                                          shadowColor:
                                              AppColor.black.withOpacity(0.32),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 32, horizontal: 24),
                                            child: FadingEdgeScrollView
                                                .fromSingleChildScrollView(
                                              gradientFractionOnEnd: 0.3,
                                              gradientFractionOnStart: 0.3,
                                              child: SingleChildScrollView(
                                                controller:
                                                    model.scrollController,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    StartOverWidget(
                                                      onTap: () {},
                                                      title: S
                                                          .of(context)
                                                          .startOverDesc,
                                                      labelText: S
                                                          .of(context)
                                                          .startOver,
                                                    ),
                                                    SizedBox(height: 32),

                                                    ///address details
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .residentCountrySmall,
                                                      controller: model
                                                          .residentCountryController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .homeAddressSmall,
                                                      controller: model
                                                          .homeAddressController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .streetAddressSmall,
                                                      controller: model
                                                          .streetAddressController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .buildingNameNo,
                                                      controller: model
                                                          .buildingNameOrNoController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),

                                                    ///permanent address
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 24.0),
                                                      child: Container(
                                                        height: 1,
                                                        color:
                                                            AppColor.white_gray,
                                                      ),
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .permanentHomeAddress,
                                                      controller: model
                                                          .residentPermanentAddressCountryController,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .citySmall,
                                                      controller: model
                                                          .residentPermanentAddressCityController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),

                                                    /// personal details
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 24.0),
                                                      child: Container(
                                                        height: 1,
                                                        color:
                                                            AppColor.white_gray,
                                                      ),
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .spouseName,
                                                      controller: model
                                                          .spouseNameController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .natureSpecialNeeds,
                                                      controller: model
                                                          .specialNeedsPersonController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .employmentStatusSmall,
                                                      controller: model
                                                          .employmentStatusController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),

                                                    ///occupation
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 24.0),
                                                      child: Container(
                                                        height: 1,
                                                        color:
                                                            AppColor.white_gray,
                                                      ),
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .occupationSmall,
                                                      controller: model
                                                          .occupationController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .mainAnnualIncomeSmall,
                                                      controller: model
                                                          .mainAnnualIncomeController,
                                                      prefixWidget: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 40.0,
                                                                bottom: 12),
                                                        child: Text(
                                                          S.of(context).JOD,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                        ),
                                                      ),
                                                      textInputType:
                                                          TextInputType.number,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .employerNameSmall,
                                                      controller: model
                                                          .employerNameController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .employerCountrySmall,
                                                      controller: model
                                                          .employerCountryController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .employerCitySmall,
                                                      controller: model
                                                          .employerCityController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .employerContactSmall,
                                                      controller: model
                                                          .employerContactController,
                                                      textInputType:
                                                          TextInputType.phone,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .addIncome1,
                                                      initialValue:
                                                          "Rent Income JOD 25,000",
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .addIncome2,
                                                      initialValue:
                                                          "Investments JOD 75,000",
                                                    ),

                                                    ///purpose of account opening
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 24.0),
                                                      child: Container(
                                                        height: 1,
                                                        color:
                                                            AppColor.white_gray,
                                                      ),
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .purposeOfAccount,
                                                      controller: model
                                                          .purposeOfAccountOpeningController,
                                                      textInputType:
                                                          TextInputType.text,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .typeOfTransactionsSmall(
                                                              '1'),
                                                      initialValue: "Transfers",
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .typeOfTransactionsSmall(
                                                              '2'),
                                                      initialValue:
                                                          "Cash Deposit",
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .expMonthlyTransactions,
                                                      controller: model
                                                          .expectedMonthlyTransactionsController,
                                                      prefixWidget: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 40.0,
                                                                bottom: 12),
                                                        child: Text(
                                                          S.of(context).JOD,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                        ),
                                                      ),
                                                      textInputType:
                                                          TextInputType.number,
                                                    ),
                                                    ReviewApplicationEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .expAnnualTransactions,
                                                      controller: model
                                                          .expectedAnnualTransactionsController,
                                                      prefixWidget: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 40.0,
                                                                bottom: 12),
                                                        child: Text(
                                                          S.of(context).JOD,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                        ),
                                                      ),
                                                      textInputType:
                                                          TextInputType.number,
                                                    ),

                                                    ///Tax and PEP questions
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 24.0),
                                                      child: Container(
                                                        height: 1,
                                                        color:
                                                            AppColor.white_gray,
                                                      ),
                                                    ),
                                                    ReviewApplicationNonEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .areYouUSCitizen,
                                                      value: "No",
                                                    ),
                                                    ReviewApplicationNonEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .areYouUSTaxResident,
                                                      value: "No",
                                                    ),
                                                    ReviewApplicationNonEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .wereBornInUS,
                                                      value: "No",
                                                    ),
                                                    ReviewApplicationNonEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .areYouTaxResidentQ,
                                                      value: "No",
                                                    ),
                                                    ReviewApplicationNonEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .areYouAnyFirstDegreeQ,
                                                      value: "Yes",
                                                    ),
                                                    ReviewApplicationNonEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .relationshipWithPEP,
                                                      value: "Father",
                                                    ),
                                                    ReviewApplicationNonEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .personsName,
                                                      value: "Salah Mawajdeh",
                                                    ),
                                                    ReviewApplicationNonEditableItem(
                                                      title: S
                                                          .of(context)
                                                          .personsRole,
                                                      value:
                                                          "Minister of Health",
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 24.0),
                                                      child: Container(
                                                        height: 1,
                                                        color:
                                                            AppColor.white_gray,
                                                      ),
                                                    ),
                                                    AppStreamBuilder<bool>(
                                                      stream: model
                                                          .declarationSelectedStream,
                                                      initialData: false,
                                                      dataBuilder: (context,
                                                          isSelected) {
                                                        return ReviewTCWidget(
                                                          isSelected:
                                                              isSelected,
                                                          title: S
                                                              .of(context)
                                                              .confirmInfoTC,
                                                          subTitle: S
                                                              .of(context)
                                                              .termsAndCondition,
                                                          onTermsAndConditionTap:
                                                              () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                RoutePaths
                                                                    .TermsAndCondition);
                                                          },
                                                          onTap: () {
                                                            model.updateDeclarationSelection(
                                                                !(isSelected!));
                                                          },
                                                        );
                                                      },
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 24),
                                                      child: AppStreamBuilder<
                                                              bool>(
                                                          stream: model
                                                              .declarationSelectedStream,
                                                          initialData: false,
                                                          dataBuilder: (context,
                                                              isChecked) {
                                                            return Visibility(
                                                              visible:
                                                                  isChecked!,
                                                              child:
                                                                  AnimatedButton(
                                                                buttonText: S
                                                                    .of(context)
                                                                    .swipeToProceed,
                                                              ),
                                                            );
                                                          }),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}

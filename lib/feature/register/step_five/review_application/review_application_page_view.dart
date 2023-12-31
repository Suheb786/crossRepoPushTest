import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/enum/customer_status_enum.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data_response.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/utils/validator.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_page.dart';
import 'package:neo_bank/feature/register/step_five/review_application/review_application_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/register/additional_income_list_widget.dart';
import 'package:neo_bank/ui/molecules/register/review_application_non_editable_items.dart';
import 'package:neo_bank/ui/molecules/register/start_over_widget.dart';
import 'package:neo_bank/ui/molecules/review_application/review_item.dart';
import 'package:neo_bank/ui/molecules/review_application/review_term_cond_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/launch_urls_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';

class ReviewApplicationPageView extends BasePageViewWidget<ReviewApplicationPageViewModel> {
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
                    child: AppStreamBuilder<Resource<bool>>(
                      initialData: Resource.none(),
                      stream: model.removeDebitLockStream,
                      onData: (removeDebitLockData) {
                        if (removeDebitLockData.status == Status.SUCCESS) {
                          model.getCustomerStatus();
                        }
                      },
                      dataBuilder: (context, removeDebitLock) {
                        return AppStreamBuilder<Resource<CreateAccountResponse>>(
                          stream: model.createAccountStream,
                          initialData: Resource.none(),
                          onData: (createAccountData) {
                            if (createAccountData.status == Status.SUCCESS) {
                              model.saveUserData();
                              model.getCustomerStatus();
                            }
                          },
                          dataBuilder: (context, createAccountData) {
                            return AppStreamBuilder<Resource<GetAccountResponse>>(
                              stream: model.getAccountStream,
                              initialData: Resource.none(),
                              onData: (getAccountData) {
                                if (getAccountData.status == Status.SUCCESS) {
                                  model.createAccount(getAccountData.data!.content!.accountDetails!,
                                      getAccountData.data!.content!.customerInformation!);
                                }
                              },
                              dataBuilder: (context, getAccountData) {
                                return AppStreamBuilder<Resource<CustomerStatus>>(
                                  stream: model.customerStatusStream,
                                  initialData: Resource.none(),
                                  onData: (userStatus) {
                                    if (userStatus.status == Status.SUCCESS) {
                                      switch (userStatus.data!.nextPage) {
                                        case CustomerStatusEnum.HOLD:
                                          Navigator.pushReplacementNamed(context, RoutePaths.AccountHold,
                                              arguments: AccountHoldArguments(
                                                  applicationId: userStatus.data!.applicationId));
                                          break;
                                        case CustomerStatusEnum.ACCOUNT_PAGE:
                                          model.getAccount();
                                          break;
                                        case CustomerStatusEnum.SUCCESS:
                                          Navigator.pushReplacementNamed(context, RoutePaths.AccountReady,
                                              arguments: AccountReadyArguments(isDocumentUploaded: false));
                                          break;
                                        case CustomerStatusEnum.DOC_UPLOAD:
                                          Future.delayed(Duration(milliseconds: 500), () {
                                            ProviderScope.containerOf(context)
                                                .read(registerStepFiveViewModelProvider)
                                                .moveToPage(4);
                                            // .move(4, animation: false);
                                          });

                                          break;
                                        case CustomerStatusEnum.VIDEO_CALL:
                                          Future.delayed(Duration(milliseconds: 500), () {
                                            ProviderScope.containerOf(context)
                                                .read(registerStepFiveViewModelProvider)
                                                .nextPage();
                                            // .next();
                                            ProviderScope.containerOf(context)
                                                .read(videoCallInfoViewModelProvider)
                                                .checkExistingScheduledCall();
                                          });
                                          break;
                                        case CustomerStatusEnum.REMOVE_DEBIT_LOCK:
                                          model.removeDebitLock();
                                          break;
                                        case CustomerStatusEnum.CARD_ISSUANCE:
                                          Navigator.pushReplacementNamed(context, RoutePaths.CardDelivery);
                                          break;
                                      }
                                    }
                                  },
                                  dataBuilder: (context, userStatus) {
                                    return AppStreamBuilder<Resource<bool>>(
                                      stream: model.reviewAppStream,
                                      initialData: Resource.none(),
                                      onData: (reviewData) {
                                        if (reviewData.status == Status.SUCCESS) {
                                          model.getCustomerStatus();
                                        } else if (reviewData.status == Status.ERROR) {
                                          model.showToastWithError(reviewData.appError!);
                                        }
                                      },
                                      dataBuilder: (context, reviewData) {
                                        return Card(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom - 50.h <= 0
                                                    ? 0
                                                    : MediaQuery.of(context).viewInsets.bottom - 48.h),
                                            child:
                                                AppStreamBuilder<Resource<GetConfirmApplicationDataResponse>>(
                                              stream: model.getConfirmApplicationDataStream,
                                              initialData: Resource.none(),
                                              onData: (getConfirmApplicationData) {
                                                if (getConfirmApplicationData.status == Status.SUCCESS) {
                                                  model.updateTextFieldData(getConfirmApplicationData.data!
                                                      .getApplicationData!.getConfirmApplicationDataContent!);
                                                }
                                              },
                                              dataBuilder: (context, getConfirmApplicationData) {
                                                switch (getConfirmApplicationData!.status) {
                                                  case Status.SUCCESS:
                                                    return FadingEdgeScrollView.fromSingleChildScrollView(
                                                      gradientFractionOnEnd: 0.3,
                                                      gradientFractionOnStart: 0.1,
                                                      child: SingleChildScrollView(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 32, horizontal: 24),
                                                        controller: model.scrollController,
                                                        physics: ClampingScrollPhysics(),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          children: [
                                                            ///For now fields should not be editable so commented description
                                                            Visibility(
                                                              visible: false,
                                                              child: StartOverWidget(
                                                                onTap: () {},
                                                                title: S
                                                                    .of(context)
                                                                    .clickToEditSomeMayBeDisabled,
                                                                labelText: S.of(context).startOver,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: false,
                                                              child: SizedBox(height: 32.h),
                                                            ),

                                                            ///Id card details
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).nameAsPerID,
                                                              controller: model.idCardNameController,
                                                              initialValue: model.idCardNameController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).nationalID,
                                                              controller: model.idCardNationalIDController,
                                                              initialValue:
                                                                  model.idCardNationalIDController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).dateOfBirthSmall,
                                                              controller: model.idCardDOBController,
                                                              initialValue: model.idCardDOBController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).placeOfBirth,
                                                              controller: model.idCardPlaceOfBirthController,
                                                              initialValue:
                                                                  model.idCardPlaceOfBirthController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).genderSmall,
                                                              controller: model.idCardGenderController,
                                                              initialValue: model.idCardGenderController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).mothersName,
                                                              controller: model.idCardMotherNameController,
                                                              initialValue:
                                                                  model.idCardMotherNameController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).legalDocumentNo,
                                                              controller:
                                                                  model.idCardLegalDocumentNoController,
                                                              initialValue:
                                                                  model.idCardLegalDocumentNoController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).issuingDate,
                                                              controller: model.idCardIssuingDateController,
                                                              initialValue:
                                                                  model.idCardIssuingDateController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).expiryDateS,
                                                              controller: model.idCardExpiryDateController,
                                                              initialValue:
                                                                  model.idCardExpiryDateController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).issuingPlace,
                                                              controller: model.idCardIssuingPlaceController,
                                                              initialValue:
                                                                  model.idCardIssuingPlaceController.text,
                                                              textInputType: TextInputType.text,
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.symmetric(vertical: 24.0.h),
                                                              child: Container(
                                                                height: 1,
                                                                color: AppColor.white_gray,
                                                              ),
                                                            ),

                                                            ///address details
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).residentCountrySmall,
                                                              controller: model.residentCountryController,
                                                              initialValue:
                                                                  model.residentCountryController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).buildingNameNo,
                                                              controller: model.buildingNameOrNoController,
                                                              initialValue:
                                                                  model.buildingNameOrNoController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).streetAddressSmall,
                                                              controller: model.streetAddressController,
                                                              initialValue:
                                                                  model.streetAddressController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            Visibility(
                                                              visible: false,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).areaSmall,
                                                                controller: model.districtController,
                                                                initialValue: model.districtController.text,
                                                                textInputType: TextInputType.text,
                                                              ),
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).citySmall,
                                                              controller: model.cityController,
                                                              initialValue: model.cityController.text,
                                                              textInputType: TextInputType.text,
                                                            ),

                                                            ///address details
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).residentCountrySmall,
                                                              controller: model.residentCountryController,
                                                              initialValue:
                                                                  model.residentCountryController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).buildingNameNo,
                                                              controller: model.buildingNameOrNoController,
                                                              initialValue:
                                                                  model.buildingNameOrNoController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).streetAddressSmall,
                                                              controller: model.streetAddressController,
                                                              initialValue:
                                                                  model.streetAddressController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            Visibility(
                                                              visible: false,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).areaSmall,
                                                                controller: model.districtController,
                                                                initialValue: model.districtController.text,
                                                                textInputType: TextInputType.text,
                                                              ),
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).citySmall,
                                                              controller: model.cityController,
                                                              initialValue: model.cityController.text,
                                                              textInputType: TextInputType.text,
                                                            ),

                                                            ///permanent address
                                                            Visibility(
                                                              visible: (model
                                                                      .residentPermanentCountryController
                                                                      .text
                                                                      .isNotEmpty &&
                                                                  model.residentPermanentCityController.text
                                                                      .isNotEmpty),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical: 24.0.h),
                                                                    child: Container(
                                                                      height: 1,
                                                                      color: AppColor.white_gray,
                                                                    ),
                                                                  ),
                                                                  ReviewApplicationEditableItem(
                                                                    title: S.of(context).permanentCountry,
                                                                    initialValue: model
                                                                        .residentPermanentCountryController
                                                                        .text,
                                                                    controller: model
                                                                        .residentPermanentCountryController,
                                                                  ),
                                                                  ReviewApplicationEditableItem(
                                                                    title: S.of(context).permanentCity,
                                                                    controller:
                                                                        model.residentPermanentCityController,
                                                                    initialValue: model
                                                                        .residentPermanentCityController.text,
                                                                    textInputType: TextInputType.text,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            /// personal details
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(vertical: 24.0.h),
                                                              child: Container(
                                                                height: 1,
                                                                color: AppColor.white_gray,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible:
                                                                  model.spouseNameController.text.isNotEmpty,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).spouseName,
                                                                controller: model.spouseNameController,
                                                                initialValue: model.spouseNameController.text,
                                                                textInputType: TextInputType.text,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: model.specialNeedsPersonController.text
                                                                  .isNotEmpty,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).natureSpecialNeeds,
                                                                controller:
                                                                    model.specialNeedsPersonController,
                                                                initialValue:
                                                                    model.specialNeedsPersonController.text,
                                                                textInputType: TextInputType.text,
                                                              ),
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).employmentStatusSmall,
                                                              controller: model.employmentStatusController,
                                                              initialValue:
                                                                  model.employmentStatusController.text,
                                                              textInputType: TextInputType.text,
                                                            ),

                                                            ///occupation
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(vertical: 24.0.h),
                                                              child: Container(
                                                                height: 1,
                                                                color: AppColor.white_gray,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible:
                                                                  model.occupationController.text.isNotEmpty,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).occupationBusinessType,
                                                                controller: model.occupationController,
                                                                initialValue: model.occupationController.text,
                                                                textInputType: TextInputType.text,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: model
                                                                  .mainAnnualIncomeController.text.isNotEmpty,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).annualIncomeSmall,
                                                                controller: model.mainAnnualIncomeController,
                                                                initialValue:
                                                                    model.mainAnnualIncomeController.text,
                                                                isPrefix: true,
                                                                prefixWidget: Padding(
                                                                  padding: const EdgeInsetsDirectional.only(
                                                                      start: 40.0, bottom: 12),
                                                                  child: Text(
                                                                    S.of(context).JOD,
                                                                    textAlign: TextAlign.end,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark),
                                                                  ),
                                                                ),
                                                                textInputType: TextInputType.number,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: model
                                                                  .employerNameController.text.isNotEmpty,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).employerNameSmall,
                                                                controller: model.employerNameController,
                                                                initialValue:
                                                                    model.employerNameController.text,
                                                                textInputType: TextInputType.text,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: model
                                                                  .employerCountryController.text.isNotEmpty,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).employerCountrySmall,
                                                                controller: model.employerCountryController,
                                                                initialValue:
                                                                    model.employerCountryController.text,
                                                                textInputType: TextInputType.text,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: model
                                                                  .employerCityController.text.isNotEmpty,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).employerCitySmall,
                                                                controller: model.employerCityController,
                                                                initialValue:
                                                                    model.employerCityController.text,
                                                                textInputType: TextInputType.text,
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: model
                                                                  .employerContactController.text.isNotEmpty,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).employerPhoneNo,
                                                                controller: model.employerContactController,
                                                                initialValue:
                                                                    model.employerContactController.text,
                                                                textInputType: TextInputType.phone,
                                                              ),
                                                            ),

                                                            getConfirmApplicationData
                                                                        .data!
                                                                        .getApplicationData!
                                                                        .getConfirmApplicationDataContent!
                                                                        .jobDetailInfo!
                                                                        .additionalIncomeInfo!
                                                                        .length >
                                                                    0
                                                                ? ListView.builder(
                                                                    itemBuilder: (context, index) {
                                                                      return AdditionalIncomeListWidget(
                                                                        title: S.of(context).otherIncome,
                                                                        additionalIncomeInfo:
                                                                            getConfirmApplicationData
                                                                                .data!
                                                                                .getApplicationData!
                                                                                .getConfirmApplicationDataContent!
                                                                                .jobDetailInfo!
                                                                                .additionalIncomeInfo![index],
                                                                      );
                                                                    },
                                                                    itemCount: getConfirmApplicationData
                                                                        .data!
                                                                        .getApplicationData!
                                                                        .getConfirmApplicationDataContent!
                                                                        .jobDetailInfo!
                                                                        .additionalIncomeInfo!
                                                                        .length,
                                                                    shrinkWrap: true,
                                                                    physics: NeverScrollableScrollPhysics())
                                                                : Container(),

                                                            ///purpose of account opening
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(vertical: 24.0.h),
                                                              child: Container(
                                                                height: 1,
                                                                color: AppColor.white_gray,
                                                              ),
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).purposeOfAccount,
                                                              controller:
                                                                  model.purposeOfAccountOpeningController,
                                                              initialValue: model
                                                                  .purposeOfAccountOpeningController.text,
                                                              textInputType: TextInputType.text,
                                                            ),
                                                            Visibility(
                                                              visible: getConfirmApplicationData
                                                                  .data!
                                                                  .getApplicationData!
                                                                  .getConfirmApplicationDataContent!
                                                                  .accountPurposeInfo!
                                                                  .isCashDeposit!,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).expectedTransactions,
                                                                initialValue:
                                                                    StringUtils.isDirectionRTL(context)
                                                                        ? 'ايداع نقدي '
                                                                        : "CashDeposit",
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: getConfirmApplicationData
                                                                  .data!
                                                                  .getApplicationData!
                                                                  .getConfirmApplicationDataContent!
                                                                  .accountPurposeInfo!
                                                                  .isTransfer!,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).expectedTransactions,
                                                                initialValue:
                                                                    StringUtils.isDirectionRTL(context)
                                                                        ? 'تحويلات مالية '
                                                                        : "Transfers",
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: getConfirmApplicationData
                                                                  .data!
                                                                  .getApplicationData!
                                                                  .getConfirmApplicationDataContent!
                                                                  .accountPurposeInfo!
                                                                  .isBillPayment!,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).expectedTransactions,
                                                                initialValue:
                                                                    StringUtils.isDirectionRTL(context)
                                                                        ? 'دفع فواتير'
                                                                        : "Bill Payment",
                                                              ),
                                                            ),
                                                            ReviewApplicationEditableItem(
                                                              title: S.of(context).expectedMonthlyAmount,
                                                              controller:
                                                                  model.expectedMonthlyTransactionsController,
                                                              isPrefix: true,
                                                              initialValue: model
                                                                  .expectedMonthlyTransactionsController.text,
                                                              prefixWidget: Padding(
                                                                padding: EdgeInsetsDirectional.only(
                                                                    start: 40.0.w, bottom: 12.h),
                                                                child: Text(
                                                                  S.of(context).JOD,
                                                                  textAlign: TextAlign.end,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 12.t,
                                                                      fontWeight: FontWeight.w600,
                                                                      color:
                                                                          Theme.of(context).primaryColorDark),
                                                                ),
                                                              ),
                                                              textInputType: TextInputType.number,
                                                            ),
                                                            Visibility(
                                                              visible: false,
                                                              child: ReviewApplicationEditableItem(
                                                                title: S.of(context).expectedAnnualAmount,
                                                                controller: model
                                                                    .expectedAnnualTransactionsController,
                                                                initialValue: model
                                                                    .expectedAnnualTransactionsController
                                                                    .text,
                                                                isPrefix: true,
                                                                prefixWidget: Padding(
                                                                  padding: EdgeInsetsDirectional.only(
                                                                      start: 40.0.w, bottom: 12.h),
                                                                  child: Text(
                                                                    S.of(context).JOD,
                                                                    textAlign: TextAlign.end,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark),
                                                                  ),
                                                                ),
                                                                textInputType: TextInputType.number,
                                                              ),
                                                            ),

                                                            ///Tax and PEP questions
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(vertical: 24.0.h),
                                                              child: Container(
                                                                height: 1,
                                                                color: AppColor.white_gray,
                                                              ),
                                                            ),
                                                            ReviewApplicationNonEditableItem(
                                                              title: S.of(context).areYouUSCitizen,
                                                              value: getValue(
                                                                  getConfirmApplicationData
                                                                      .data!
                                                                      .getApplicationData!
                                                                      .getConfirmApplicationDataContent!
                                                                      .fatcaCrsInfo!
                                                                      .response1!,
                                                                  context),
                                                            ),
                                                            ReviewApplicationNonEditableItem(
                                                              title: S.of(context).areYouUSTaxResident,
                                                              value: getValue(
                                                                  getConfirmApplicationData
                                                                      .data!
                                                                      .getApplicationData!
                                                                      .getConfirmApplicationDataContent!
                                                                      .fatcaCrsInfo!
                                                                      .response2!,
                                                                  context),
                                                            ),
                                                            ReviewApplicationNonEditableItem(
                                                              title: S.of(context).wereBornInUS,
                                                              value: getValue(
                                                                  getConfirmApplicationData
                                                                      .data!
                                                                      .getApplicationData!
                                                                      .getConfirmApplicationDataContent!
                                                                      .fatcaCrsInfo!
                                                                      .response3!,
                                                                  context),
                                                            ),
                                                            ReviewApplicationNonEditableItem(
                                                              title: S.of(context).areYouTaxResidentQ,
                                                              value: getValue(
                                                                  getConfirmApplicationData
                                                                      .data!
                                                                      .getApplicationData!
                                                                      .getConfirmApplicationDataContent!
                                                                      .fatcaCrsInfo!
                                                                      .response4!,
                                                                  context),
                                                            ),
                                                            ReviewApplicationNonEditableItem(
                                                              title: S.of(context).areYouAnyFirstDegreeQ,
                                                              value: getValue(
                                                                  getConfirmApplicationData
                                                                      .data!
                                                                      .getApplicationData!
                                                                      .getConfirmApplicationDataContent!
                                                                      .fatcaCrsInfo!
                                                                      .response5!,
                                                                  context),
                                                            ),
                                                            Visibility(
                                                                visible: getConfirmApplicationData
                                                                    .data!
                                                                    .getApplicationData!
                                                                    .getConfirmApplicationDataContent!
                                                                    .fatcaCrsInfo!
                                                                    .response5!,
                                                                child: Column(
                                                                  children: [
                                                                    ReviewApplicationNonEditableItem(
                                                                      title:
                                                                          S.of(context).relationshipWithPEP,
                                                                      value: StringUtils.isDirectionRTL(
                                                                              context)
                                                                          ? Validator.isNotEmptyNull(
                                                                                  getConfirmApplicationData
                                                                                      .data!
                                                                                      .getApplicationData!
                                                                                      .getConfirmApplicationDataContent!
                                                                                      .fatcaCrsInfo!
                                                                                      .relationshipWithPEPNameAr)
                                                                              ? getConfirmApplicationData
                                                                                  .data!
                                                                                  .getApplicationData!
                                                                                  .getConfirmApplicationDataContent!
                                                                                  .fatcaCrsInfo!
                                                                                  .relationshipWithPEPNameAr
                                                                              : ''
                                                                          : Validator.isNotEmptyNull(
                                                                                  getConfirmApplicationData
                                                                                      .data!
                                                                                      .getApplicationData!
                                                                                      .getConfirmApplicationDataContent!
                                                                                      .fatcaCrsInfo!
                                                                                      .relationshipWithPEPName)
                                                                              ? getConfirmApplicationData
                                                                                  .data!
                                                                                  .getApplicationData!
                                                                                  .getConfirmApplicationDataContent!
                                                                                  .fatcaCrsInfo!
                                                                                  .relationshipWithPEPName
                                                                              : '',
                                                                    ),
                                                                    ReviewApplicationNonEditableItem(
                                                                      title: S.of(context).personsName,
                                                                      value: Validator.isNotEmptyNull(
                                                                              getConfirmApplicationData
                                                                                  .data!
                                                                                  .getApplicationData!
                                                                                  .getConfirmApplicationDataContent!
                                                                                  .fatcaCrsInfo!
                                                                                  .personName)
                                                                          ? getConfirmApplicationData
                                                                              .data!
                                                                              .getApplicationData!
                                                                              .getConfirmApplicationDataContent!
                                                                              .fatcaCrsInfo!
                                                                              .personName
                                                                          : '',
                                                                    ),
                                                                    ReviewApplicationNonEditableItem(
                                                                      title: S.of(context).personsRole,
                                                                      value: Validator.isNotEmptyNull(
                                                                              getConfirmApplicationData
                                                                                  .data!
                                                                                  .getApplicationData!
                                                                                  .getConfirmApplicationDataContent!
                                                                                  .fatcaCrsInfo!
                                                                                  .personRole)
                                                                          ? getConfirmApplicationData
                                                                              .data!
                                                                              .getApplicationData!
                                                                              .getConfirmApplicationDataContent!
                                                                              .fatcaCrsInfo!
                                                                              .personRole
                                                                          : '',
                                                                    ),
                                                                  ],
                                                                )),

                                                            Padding(
                                                              padding: EdgeInsets.symmetric(vertical: 24.0.h),
                                                              child: Container(
                                                                height: 1,
                                                                color: AppColor.white_gray,
                                                              ),
                                                            ),
                                                            AppStreamBuilder<bool>(
                                                              stream: model.declarationSelectedStream,
                                                              initialData: false,
                                                              dataBuilder: (context, isSelected) {
                                                                return ReviewTCWidget(
                                                                  isSelected: isSelected,
                                                                  title: S.of(context).confirmInfoTC,
                                                                  subTitle: S.of(context).termsAndCondition,
                                                                  onTermsAndConditionTap: () {
                                                                    LaunchUrlUtils.launchDigitalService(StringUtils
                                                                            .isDirectionRTL(context)
                                                                        ? AppConstantsUtils
                                                                            .ONBOARDING_DIGITAL_SERVICE_LINK_LIVE_AR
                                                                        : AppConstantsUtils
                                                                            .ONBOARDING_DIGITAL_SERVICE_LINK_LIVE);
                                                                  },
                                                                  onTap: () {
                                                                    model.updateDeclarationSelection(
                                                                        !(isSelected!));
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets.only(top: 24.h, bottom: 16.h),
                                                                child: AppStreamBuilder<bool>(
                                                                    stream: model.declarationSelectedStream,
                                                                    initialData: false,
                                                                    dataBuilder: (context, isChecked) {
                                                                      return AppPrimaryButton(
                                                                        text: S.of(context).next,
                                                                        isDisabled: !isChecked!,
                                                                        onPressed: () {
                                                                          if (ProviderScope.containerOf(
                                                                                      context)
                                                                                  .read(
                                                                                      registerStepFiveViewModelProvider)
                                                                                  .appSwiperController
                                                                                  .page ==
                                                                              0.0) {
                                                                            model.validateReviewDetails();
                                                                          }
                                                                        },
                                                                      );
                                                                    }),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );

                                                  default:
                                                    return Container();
                                                }
                                              },
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
                    ));
              }),
        ),
      ],
    );
  }

  String getValue(bool value, BuildContext context) {
    switch (value) {
      case false:
        return S.of(context).no;

      default:
        return S.of(context).yes;
    }
  }
}

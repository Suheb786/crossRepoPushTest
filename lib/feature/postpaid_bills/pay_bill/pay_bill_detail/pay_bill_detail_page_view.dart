import 'dart:ui';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'package:domain/model/bill_payments/add_new_prepaid_biller/add_new_prepaid_biller_model.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/pay_bill_detail/pay_bill_detail_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/card/postpaid_setting_title_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/accounts_dialog/accounts_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/denomintion_dialog/denomination_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/postpaid_bill/pay_bill_detail/bill_name/bill_name_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/postpaid_bill/pay_bill_detail/service/select_service_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PayBillDetailPageView
    extends BasePageViewWidget<PayBillDetailPageViewModel> {
  late PayBillDetailPageViewModel model;
  late BuildContext context;

  PayBillDetailPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    this.model = model;
    this.context = context;
    return AppStreamBuilder<Resource<AddNewPrepaidBillerModel>>(
      stream: model.addNewPrepaidBillerStream,
      initialData: Resource.none(),
      onData: (event) {
        if (event.status == Status.SUCCESS) {
          //MAKE CONDITION TRUE AFTER COMPLETION OF FLOW
          AppConstantsUtils.IS_NEW_PAYMENT = true;
          AppConstantsUtils.SELECTED_AMOUNT = model.amountTextControl.text;
          AppConstantsUtils.NICK_NAME = model.nicknameTextControl.text;
          AppConstantsUtils.SELECTED_BILLING_NUMBER =
              model.billingNumberTextControl.text;
          // Navigator.pushNamed(RoutePaths.billerAdded);
        } else if (event.status == Status.ERROR) {
          model.showToastWithError(event.appError!);
        }
      },
      dataBuilder: (context, snapshot) {
        return AppStreamBuilder<Resource<AddNewPostpaidBillerModel>>(
          stream: model.addNewPostpaidStream,
          initialData: Resource.none(),
          onData: (event) {
            if (event.status == Status.SUCCESS) {
              AppConstantsUtils.SELECTED_BILLER_CODE =
                  event.data!.addNewPostpaidBillerModelData!.billerCode!;
              AppConstantsUtils.SELECTED_BILLING_NUMBER =
                  event.data!.addNewPostpaidBillerModelData!.billingNo!;
              AppConstantsUtils.SELECTED_SERVICE_TYPE =
                  event.data!.addNewPostpaidBillerModelData!.serviceType!;
              AppConstantsUtils.NICK_NAME =
                  event.data!.addNewPostpaidBillerModelData!.nickName!;

              Navigator.pushNamed(context, RoutePaths.PaidBillsSuccessPage,
                  arguments: PaidBillsSuccessPageArguments(
                      ProviderScope.containerOf(context)
                          .read(payBillDetailPageViewModelProvider)
                          .amountTextControl
                          .text,
                      ProviderScope.containerOf(context)
                          .read(payBillDetailPageViewModelProvider)
                          .serviceTypeTextControl
                          .text,
                      ProviderScope.containerOf(context)
                          .read(payBillDetailPageViewModelProvider)
                          .nicknameTextControl
                          .text,
                      ProviderScope.containerOf(context)
                          .read(payBillDetailPageViewModelProvider)
                          .refNoController
                          .text));
            } else if (event.status == Status.ERROR) {
              model.showToastWithError(event.appError!);
            }
          },
          dataBuilder: (context, snapshot) {
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
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (ProviderScope.containerOf(context)
                                  .read(payBillPageViewModelProvider)
                                  .appSwiperController
                                  .page ==
                              0.0) {
                            if (StringUtils.isDirectionRTL(context)) {
                              if (details.primaryVelocity!.isNegative) {
                                ProviderScope.containerOf(context)
                                    .read(payBillPageViewModelProvider)
                                    .previousPage();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(payBillPageViewModelProvider)
                                    .nextPage();
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                ProviderScope.containerOf(context)
                                    .read(payBillPageViewModelProvider)
                                    .nextPage();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(payBillPageViewModelProvider)
                                    .previousPage();
                              }
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0.w, horizontal: 15.0.h),
                          child: Card(
                            //  clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.zero,
                            child:
                                FadingEdgeScrollView.fromSingleChildScrollView(
                              gradientFractionOnEnd: 0.2,
                              gradientFractionOnStart: 0.2,
                              child: SingleChildScrollView(
                                controller: model.controller,
                                child: AppStreamBuilder<bool>(
                                  initialData: false,
                                  stream: model.totalBillAmtDueStream,
                                  dataBuilder:
                                      (BuildContext context, isSwitchActive) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 32.h, horizontal: 24.w),
                                      child: Column(children: [
                                        _billDetailsTitle(),
                                        _billerCategoryTitleWidget(),
                                        _billerNameAppTextField(),
                                        _servicesAppTextField(),
                                        _billingNumberTypeTextField(
                                            context, model),
                                        _ShowDenomination(),
                                        _showAmountForPrepaid(),
                                        _refNoAppTextField(),
                                        _payFromAppTextField(),
                                        _addThisBillerSwitch(
                                            context, isSwitchActive),
                                        _nickNameAppTextField(
                                            context, isSwitchActive),
                                        _SwipeToProceedButton(),
                                        _backToPaymentsButton()
                                      ]),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          },
        );
      },
    );
  }

  Widget _billingNumberTypeTextField(context, model) {
    return AppStreamBuilder<bool>(
      stream: model.isShowBillerNumberStream,
      initialData: false,
      dataBuilder: (_, isShowBillerNumber) {
        return Visibility(
            visible: isShowBillerNumber!,
            child: Padding(
              padding: EdgeInsets.only(top: 16.0.h),
              child: AppTextField(
                labelText: model.fieldTextLabelEn,
                hintText: S.of(context).pleaseEnter,
                controller: model.billingNumberTextControl,
                inputType: TextInputType.number,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ));
      },
    );
  }

  _billDetailsTitle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(S.of(context).billDetails,
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontWeight: FontWeight.w600,
              fontSize: 14.t,
              color: AppColor.gray_black)),
    );
  }

  _billerCategoryTitleWidget() {
    return Row(
      children: [
        Expanded(
          child: PostPaidSettingTitleWidget(
            title: AppConstantsUtils.BILLER_CATEGORY_API_VALUE,
            tileIcon: ProviderScope.containerOf(context)
                    .read(newBillsPageViewModelProvider)
                    .titleIcon ??
                "",
          ),
        )
      ],
    );
  }

  _billerNameAppTextField() {
    return AppTextField(
      labelText: S.of(context).billName.toUpperCase(),
      hintText: S.of(context).pleaseSelect,
      controller: model.billerNameTextController,
      readOnly: true,
      onPressed: () {
        PayBillDialog.show(context, title: S.of(context).billName,
            onDismissed: () {
          Navigator.pop(context);
        }, onSelected: (billerDetails) {
          // Navigator.pop(context);
          model.billerNameTextController.text =
              AppConstantsUtils.LANGUAGE_KEY == "EN"
                  ? billerDetails.billerNameEn!
                  : billerDetails.billerNameAr!;
          AppConstantsUtils.BILLER_NAME = AppConstantsUtils.LANGUAGE_KEY == "EN"
              ? billerDetails.billerNameEn!
              : billerDetails.billerNameAr!;
          AppConstantsUtils.SELECTED_BILLER_CODE = billerDetails.billerCode!;
          model.billerCodeTextControl.text =
              billerDetails.billerCode.toString();
          model.billerCodeString = billerDetails.billerCode.toString();
          model.billerService = billerDetails.billerService!;
          model.validateData();
        });
      },
      suffixIcon: (value, data) {
        return Container(
            height: 16.h,
            width: 16.w,
            padding: EdgeInsets.only(right: 8.w),
            child: AppSvg.asset(AssetUtils.downArrow,
                color: AppColor.dark_gray_1));
      },
    );
  }

  _servicesAppTextField() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h),
      child: AppTextField(
        labelText: S.of(context).services.toUpperCase(),
        hintText: S.of(context).pleaseSelect,
        controller: model.serviceTypeTextControl,
        readOnly: true,
        onPressed: () {
          model.amountTextControl.text = "";
          AppConstantsUtils.SELECTED_AMOUNT = "";
          AppConstantsUtils.PREPAID_CATEGORY_CODE = "";
          AppConstantsUtils.PREPAID_CATEGORY_DESCRIPTION = "";
          AppConstantsUtils.PREPAID_CATEGORY_TYPE = "";
          model.denominationTextController.text = "";
          if (model.billerService != null && model.billerService.isNotEmpty) {
            SelectServiceDialog.show(
                context, model.billerService, model.billerCodeString.toString(),
                title: S.of(context).services, onDismissed: () {
              Navigator.pop(context);
            }, onSelected: (billerServices) {
              _onSelectServiceDialogSelected(model, billerServices);
            });
          }
          model.validateData();
        },
        suffixIcon: (value, data) {
          return Container(
              height: 16.h,
              width: 16.w,
              padding: EdgeInsets.only(right: 8.w),
              child: AppSvg.asset(AssetUtils.downArrow,
                  color: AppColor.dark_gray_1));
        },
      ),
    );
  }

  _refNoAppTextField() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h),
      child: AppTextField(
        labelText: S.of(context).referenceNo.toUpperCase(),
        hintText: S.of(context).pleaseEnter,
        controller: model.refNoController,
        inputType: TextInputType.number,
        onPressed: () {
          FocusScope.of(context).unfocus();
        },
        onChanged: (val){
          model.validateData();
        },
      ),
    );
  }

  _payFromAppTextField() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h),
      child: AppTextField(
        labelText: S.of(context).payFrom,
        hintText: S.of(context).searchBill,
        controller: model.payFromController,
        readOnly: true,
        onChanged: (val){
          model.validateData();
        },
        onPressed: () {
          AccountsDialog.show(context, label: S.of(context).selectAccount,
              onDismissed: () {
            Navigator.pop(context);
          }, onSelected: (value) {
            model.payFromController.text = value;
            Navigator.pop(context);
          }, accountsList: [
            ProviderScope.containerOf(context)
                    .read(appHomeViewModelProvider)
                    .dashboardDataContent
                    .account
                    ?.accountNo ??
                ''
          ]);
        },
        suffixIcon: (value, data) {
          return Container(
              height: 16.h,
              width: 16.w,
              padding: EdgeInsets.only(right: 8.w),
              child: AppSvg.asset(AssetUtils.downArrow,
                  color: AppColor.dark_gray_1));
        },
      ),
    );
  }

  _addThisBillerSwitch(context, bool? isSwitchActive) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(S.of(context).addThisBillToSaveList,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.t,
                    color: AppColor.gray_black)),
          ),
          FlutterSwitch(
              height: 40.h,
              width: 70.w,
              padding: 8,
              activeTextFontWeight: FontWeight.w500,
              showOnOff: true,
              valueFontSize: 10.t,
              inactiveColor: AppColor.gray1,
              activeColor: AppColor.brightBlue,
              activeText: S.of(context).yes.toUpperCase(),
              inactiveText: S.of(context).no.toUpperCase(),
              activeTextColor: AppColor.white,
              inactiveTextColor: AppColor.darkGray,
              value: isSwitchActive ?? false,
              onToggle: (isActive) {
                model.addThisBillerToSaveList(isActive);

                model.switchStatus(isActive);
              })
        ],
      ),
    );
  }

  _nickNameAppTextField(context, bool? isSwitchActive) {
    return Visibility(
      visible: isSwitchActive ?? false,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0.h),
        child: AppTextField(
          labelText: S.of(context).nickName.toUpperCase(),
          hintText: S.of(context).pleaseEnter,
          controller: model.nicknameTextControl,
          onPressed: () {
            FocusScope.of(context).unfocus();
          },
          onChanged: (val){
            model.validateData();
          },
        ),
      ),
    );
  }

  _SwipeToProceedButton() {
    return Padding(
      padding: EdgeInsets.only(top: 32.0.h),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
            ProviderScope.containerOf(context)
                .read(payBillPageViewModelProvider)
                .nextPage();
            ProviderScope.containerOf(context).read(confirmBillPaymentAmountPageViewModelProvider).setData(model.setData());
          } else {
            ProviderScope.containerOf(context)
                .read(payBillPageViewModelProvider)
                .previousPage();
          }

        },
        child: AppStreamBuilder<bool>(
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
      ),
    );
  }

  _backToPaymentsButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 23.0.h,
        ),
        child: Text(S.of(context).backToPayments,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 14.t,
                color: AppColor.brightBlue)),
      ),
    );
  }

  /// on Service Dialog Selected
  void _onSelectServiceDialogSelected(
      PayBillDetailPageViewModel model, BillerService billerServices) {
    model.showAmountField = false;
    model.updateStreamForBillingNumber(true);
    model.serviceTypeTextControl.text = AppConstantsUtils.LANGUAGE_KEY == "EN"
        ? billerServices.serviceDescriptionEn!
        : billerServices.serviceDescriptionAr!;
    model.serviceTypeApiVal = billerServices.serviceType!;
    model.serviceDescriptionEn.text = billerServices.serviceDescriptionEn ?? "";
    AppConstantsUtils.SELECTED_SERVICE_DESCRIPTION_EN =
        billerServices.serviceDescriptionEn ?? "";
    AppConstantsUtils.SELECTED_SERVICE_TYPE = billerServices.serviceType!;
    AppConstantsUtils.SELECTED_SERVICE_CODE = billerServices.serviceCode!;
    AppConstantsUtils.BILLER_TYPE = billerServices.paymentType!;
    AppConstantsUtils.IS_NEW_PAYMENT = true;
    if (billerServices.paymentType! == AppConstantsUtils.PREPAID_KEY) {
      _paymentTypePrePaid(model, billerServices);
    } else if (billerServices.paymentType! == AppConstantsUtils.POSTPAID_KEY) {
      _paymentTypePostPaid(model, billerServices);
    }
  }

  void _paymentTypePrePaid(
      PayBillDetailPageViewModel model, BillerService billerServices) {
    model.updateStreamForShowAmount(billerServices.containPrepaidCat!);
    model.fieldTextLabelEn = AppConstantsUtils.LANGUAGE_KEY == "EN"
        ? billerServices.fieldLabelEn!
        : billerServices.fieldLabelAr!;
    model.updateStreamForBillingNumber(billerServices.billingNoRequired!);
    Future.delayed(Duration(milliseconds: 200)).then((value) => {
          model.getPrePaidCategoresList(
            AppConstantsUtils.SELECTED_SERVICE_CODE,
            AppConstantsUtils.SELECTED_BILLER_CODE,
          )
        });
  }

  void _paymentTypePostPaid(
      PayBillDetailPageViewModel model, BillerService billerServices) {
    model.fieldTextLabelEn = AppConstantsUtils.LANGUAGE_KEY == "EN"
        ? billerServices.fieldLabelEn!
        : billerServices.fieldLabelAr!;
    model.updateStreamForBillingNumber(true);
    model.updateStreamForShowAmount(false);
  }

  ///show pre paid categories dialog
  Widget _ShowDenomination() {
    return AppStreamBuilder<bool>(
      stream: model.isShowAmountStream,
      initialData: false,
      dataBuilder: (_, isShowAmount) {
        return Visibility(
          visible: isShowAmount!,
          child: Padding(
            padding: EdgeInsets.only(top: 16.0.h),
            child: AppTextField(
              labelText: "Denomination".toUpperCase(),
              // labelText: S.of(context).denomination.toUpperCase(),
              hintText: S.of(context).pleaseSelect,
              controller: model.denominationTextController,
              readOnly: true,
              onPressed: () {
                AppConstantsUtils.PREPAID_CATEGORY_CODE = "";
                AppConstantsUtils.PREPAID_CATEGORY_DESCRIPTION = "";
                AppConstantsUtils.PREPAID_CATEGORY_TYPE = "";
                model.denominationTextController.text = "";
                _showPrePaidCategoriesList(context);
              },
              suffixIcon: (value, data) {
                return Container(
                    height: 16.h,
                    width: 16.w,
                    padding: EdgeInsets.only(right: 8.w),
                    child: AppSvg.asset(AssetUtils.downArrow,
                        color: AppColor.dark_gray_1));
              },
            ),
          ),
        );
      },
    );
  }

  Widget _showAmountForPrepaid() {
    return Visibility(
      visible: model.showAmountField,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0.h),
        child: AppTextField(
          labelText: S.of(context).amount.toUpperCase(),
          hintText: S.of(context).pleaseEnter,
          controller: model.amountTextControl,
          inputType: TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
          ],
          onChanged: (text) {
            model.amountTextControl.text = text;
            model.amountTextControl.selection = TextSelection.fromPosition(
                TextPosition(offset: model.amountTextControl.text.length));
            model.validateData();
          },
          onPressed: () {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  void _showPrePaidCategoriesList(BuildContext context) {
    DenominationsDialog.show(context,
        getPrePaidCategoriesList: model.getPrepaidCategoriesModelData,
        label: S.of(context).selectAccount,
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        serviceCode: AppConstantsUtils.SELECTED_SERVICE_CODE, onDismissed: () {
      Navigator.pop(context);
    }, onSelected: (value) {
      model.payFromController.text = value.description.toString();
      AppConstantsUtils.PREPAID_CATEGORY_CODE = value.code.toString();
      AppConstantsUtils.PREPAID_CATEGORY_DESCRIPTION =
          value.description.toString();
      AppConstantsUtils.PREPAID_CATEGORY_TYPE = value.type.toString();
      model.denominationTextController.text = value.description.toString();
      model.validateData();

      Navigator.pop(context);
    });
  }
}

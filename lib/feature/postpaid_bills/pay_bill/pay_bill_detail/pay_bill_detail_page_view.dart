import 'dart:ui';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_details.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/pay_bill_detail/pay_bill_detail_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/card/postpaid_setting_title_widget.dart';
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

class PayBillDetailPageView extends BasePageViewWidget<PayBillDetailPageViewModel> {
  late PayBillDetailPageViewModel model;
  late BuildContext context;

  PayBillDetailPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    this.model = model;
    this.context = context;
    return AppStreamBuilder<Resource<GetPrePaidCategoriesModel>>(
        stream: model.gerPrePaidCategoriesStream,
        initialData: Resource.none(),
        onData: (event) {
          if (event.status == Status.SUCCESS) {
            model.validateData(context);
          }
          if (event.status == Status.ERROR) {
            model.validateData(context);
          }
        },
        dataBuilder: (context, activities) {
          return AppStreamBuilder<Resource<GetBillerLookUpList>>(
              stream: model.getBillerLookupStream,
              initialData: Resource.none(),
              onData: (event) {
                if (event.status == Status.SUCCESS) {
                  AppConstantsUtils.billerDetailsCacheList[AppConstantsUtils.billerDetailsCacheListKey] =
                      event.data?.content?.billerDetailsList;
                  model.billerDetailsList = event.data?.content?.billerDetailsList;
                  _showBillerNameDialog(model.billerDetailsList);
                }
              },
              dataBuilder: (context, activities) {
                return AppStreamBuilder<bool>(
                    stream: model.showButtonStream,
                    initialData: false,
                    dataBuilder: (context, isValid) {
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
                                    model.validateData(context);
                                    if (ProviderScope.containerOf(context)
                                            .read(payBillPageViewModelProvider)
                                            .appSwiperController
                                            .page ==
                                        0.0) {
                                      if (StringUtils.isDirectionRTL(context)) {
                                        if (details.primaryVelocity!.isNegative) {
                                          if (ProviderScope.containerOf(context)
                                                  .read(payBillPageViewModelProvider)
                                                  .appSwiperController
                                                  .page ==
                                              1.0) {
                                            ProviderScope.containerOf(context)
                                                .read(payBillPageViewModelProvider)
                                                .previousPage();
                                          }
                                        } else {
                                          if (isValid == true) {
                                            ProviderScope.containerOf(context)
                                                .read(payBillPageViewModelProvider)
                                                .nextPage();
                                            ProviderScope.containerOf(context)
                                                .read(confirmBillPaymentAmountPageViewModelProvider)
                                                .setData(model.setData());

                                            if (AppConstantsUtils.PRE_PAID_FLOW) {
                                              if (model.isPrepaidCategoryListEmpty == false) {
                                                /// prepaid bill details inquiry
                                                ProviderScope.containerOf(context)
                                                    .read(confirmBillPaymentAmountPageViewModelProvider)
                                                    .validatePrePaidBill();
                                              }
                                            } else if (AppConstantsUtils.POST_PAID_FLOW) {
                                              /// post paid bill details inquiry
                                              ProviderScope.containerOf(context)
                                                  .read(confirmBillPaymentAmountPageViewModelProvider)
                                                  .postPaidBillInquiry();
                                            }
                                          } else {
                                            model.showToastWithError(AppError(
                                                cause: Exception(),
                                                error: ErrorInfo(message: ''),
                                                type: !model.isNickNameValid
                                                    ? ErrorType.INVALID_NICK_NAME
                                                    : ErrorType.ENTER_BILL_DETAILS));
                                          }
                                        }
                                      } else {
                                        if (details.primaryVelocity!.isNegative) {
                                          if (isValid == true) {
                                            ProviderScope.containerOf(context)
                                                .read(payBillPageViewModelProvider)
                                                .nextPage();
                                            ProviderScope.containerOf(context)
                                                .read(confirmBillPaymentAmountPageViewModelProvider)
                                                .setData(model.setData());

                                            if (AppConstantsUtils.PRE_PAID_FLOW) {
                                              if (model.isPrepaidCategoryListEmpty == false) {
                                                /// prepaid bill details inquiry
                                                ProviderScope.containerOf(context)
                                                    .read(confirmBillPaymentAmountPageViewModelProvider)
                                                    .validatePrePaidBill();
                                              }
                                            } else if (AppConstantsUtils.POST_PAID_FLOW) {
                                              /// post paid bill details inquiry
                                              ProviderScope.containerOf(context)
                                                  .read(confirmBillPaymentAmountPageViewModelProvider)
                                                  .postPaidBillInquiry();
                                            }
                                          } else {
                                            model.showToastWithError(AppError(
                                                cause: Exception(),
                                                error: ErrorInfo(message: ''),
                                                type: !model.isNickNameValid
                                                    ? ErrorType.INVALID_NICK_NAME
                                                    : ErrorType.ENTER_BILL_DETAILS));
                                          }
                                        } else {
                                          if (ProviderScope.containerOf(context)
                                                  .read(payBillPageViewModelProvider)
                                                  .appSwiperController
                                                  .page ==
                                              1.0) {
                                            ProviderScope.containerOf(context)
                                                .read(payBillPageViewModelProvider)
                                                .previousPage();
                                          }
                                        }
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom - 50.0.h <= 0
                                            ? 0
                                            : MediaQuery.of(context).viewInsets.bottom - 48.h),
                                    child: Card(
                                      //  clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.zero,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onPanDown: (_) {
                                          FocusScope.of(context).requestFocus(FocusNode());
                                        },
                                        child: FadingEdgeScrollView.fromSingleChildScrollView(
                                          gradientFractionOnEnd: 0.2,
                                          gradientFractionOnStart: 0.2,
                                          child: SingleChildScrollView(
                                            controller: model.controller,
                                            child: AppStreamBuilder<bool>(
                                              initialData: false,
                                              stream: model.totalBillAmtDueStream,
                                              dataBuilder: (BuildContext context, isSwitchActive) {
                                                return Container(
                                                  padding:
                                                      EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                                  child: Column(children: [
                                                    _billDetailsTitle(),
                                                    _billerCategoryTitleWidget(),
                                                    _billerNameAppTextField(),
                                                    _servicesAppTextField(),
                                                    _billingNumberTypeTextField(context),
                                                    _ShowDenomination(),
                                                    _showAmountForPrepaid(),
                                                    // _refNoAppTextField(),
                                                    _payFromAppTextField(),
                                                    _addThisBillerSwitch(context, isSwitchActive),
                                                    _nickNameAppTextField(context, isSwitchActive),
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
                                ),
                              );
                            }),
                      );
                    });
              });
        });
  }

  Widget _billingNumberTypeTextField(context) {
    return AppStreamBuilder<bool>(
      stream: model.isShowBillerNumberStream,
      initialData: false,
      dataBuilder: (_, isShowBillerNumber) {
        return Visibility(
            visible: isShowBillerNumber!,
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 16.0.h),
              child: AppTextField(
                labelText: model.fieldTextLabelEn.toUpperCase(),
                hintText: S.of(context).pleaseEnter,
                controller: model.billingNumberTextControl,
                inputType: model.fieldTextLabelEn.toUpperCase() == "ENTER USERNAME"
                    ? TextInputType.text
                    : TextInputType.number,
                onPressed: () {
                  // FocusScope.of(context).unfocus();
                },
                onChanged: (value) {
                  model.validateData(context);
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
            tileIcon: ProviderScope.containerOf(context).read(newBillsPageViewModelProvider).titleIcon ?? "",
          ),
        )
      ],
    );
  }

  _billerNameAppTextField() {
    return AppTextField(
      labelText: S.of(context).billerName.toUpperCase(),
      hintText: S.of(context).pleaseSelect,
      controller: model.billerNameTextController,
      readOnly: true,
      onPressed: () {
        model.billerDetailsList = [];
        model.billerDetailsList =
            AppConstantsUtils.billerDetailsCacheList[AppConstantsUtils.billerDetailsCacheListKey];
        if (model.billerDetailsList == null ||
            model.billerDetailsList != null && model.billerDetailsList!.isEmpty) {
          model.billerList();
        } else {
          _showBillerNameDialog(model.billerDetailsList);
        }
      },
      suffixIcon: (value, data) {
        return Container(
            height: 16.h,
            width: 16.w,
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
      },
    );
  }

  _servicesAppTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 16.0.h),
      child: AppTextField(
        labelText: S.of(context).services.toUpperCase(),
        hintText: S.of(context).pleaseSelect,
        controller: model.serviceTypeTextControl,
        readOnly: true,
        onPressed: () {
          model.updateIsPrepaidCategoryListEmptyResponse(true);
          model.amountTextControl.text = "";
          model.amountText = "0";
          AppConstantsUtils.SELECTED_AMOUNT = "";
          AppConstantsUtils.PREPAID_CATEGORY_CODE = "";
          AppConstantsUtils.PREPAID_CATEGORY_DESCRIPTION = "";
          AppConstantsUtils.PREPAID_CATEGORY_TYPE = "";
          model.denominationTextController.text = "";
          if (model.billerService != null && model.billerService.isNotEmpty) {
            SelectServiceDialog.show(context, model.billerService, model.billerCodeString.toString(),
                title: S.of(context).services, onDismissed: () {
              Navigator.pop(context);
            }, onSelected: (billerServices) {
              _onSelectServiceDialogSelected(billerServices);
            });
          }
          model.validateData(context);
        },
        suffixIcon: (value, data) {
          return Container(
              height: 16.h,
              width: 16.w,
              padding: EdgeInsetsDirectional.only(end: 8.w),
              child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
        },
      ),
    );
  }

/*
  _refNoAppTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 16.0.h),
      child: AppTextField(
        labelText: S.of(context).referenceNo.toUpperCase(),
        hintText: S.of(context).pleaseEnter,
        controller: model.refNoController,
        inputType: TextInputType.number,
        onPressed: () {
          FocusScope.of(context).unfocus();
        },
        onChanged: (val) {
          model.validateData(context);
        },
      ),
    );
  }
*/

  _payFromAppTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 16.0.h),
      child: AppTextField(
        labelText: S.of(context).payFrom.toUpperCase(),
        hintText: "",
        controller: model.payFromController,
        readOnly: true,
        onChanged: (val) {
          model.validateData(context);
        },
        /*onPressed: () {
          AccountsDialog.show(context, label: S.of(context).selectAccount, onDismissed: () {
            Navigator.pop(context);
          }, onSelected: (value) {
            model.payFromController.text = value;
            model.validateData(context);
            Navigator.pop(context);
          }, accountsList: [
            ProviderScope.containerOf(context)
                    .read(appHomeViewModelProvider)
                    .dashboardDataContent
                    .account
                    ?.accountNo ??
                ''
          ]);
        },*/
        // suffixIcon: (value, data) {
        //   return Container(
        //       height: 16.h,
        //       width: 16.w,
        //       padding: EdgeInsetsDirectional.only(end: 8.w),
        //       child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
        // },
      ),
    );
  }

  _addThisBillerSwitch(context, bool? isSwitchActive) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 24.0.h),
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
            value: isSwitchActive ?? false,
            onToggle: (isActive) {
              model.addThisBillerToSaveList(isActive, context);
              model.switchStatus(isActive);
            },
            width: 70.w,
            height: 40.h,
            padding: 8,
            activeText: S.of(context).yes.toUpperCase(),
            activeTextColor: AppColor.white,
            inactiveTextColor: AppColor.darkGray,
            activeTextFontWeight: FontWeight.w500,
            showOnOff: true,
            valueFontSize: 10.t,
            activeToggleColor: AppColor.white,
            inactiveText: S.of(context).no.toUpperCase(),
            inactiveToggleColor: AppColor.lightGrayishMagenta,
            inactiveTextFontWeight: FontWeight.w500,
            inactiveSwitchBorder: Border.all(color: AppColor.gray_2),
            activeColor: Theme.of(context).accentTextTheme.bodyText1!.color!,
            inactiveColor: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }

  _nickNameAppTextField(context, bool? isSwitchActive) {
    return Visibility(
      visible: isSwitchActive ?? false,
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 16.0.h),
        child: AppTextField(
          maxLength: 50,
          labelText: S.of(context).nickName.toUpperCase(),
          hintText: S.of(context).pleaseEnter,
          controller: model.nicknameTextControl,
          onPressed: () {
            // FocusScope.of(context).unfocus();
          },
          onChanged: (val) {
            model.validateData(context);
          },
        ),
      ),
    );
  }

  _SwipeToProceedButton() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 32.0.h),
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
    );
  }

  _backToPaymentsButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(
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
  void _onSelectServiceDialogSelected(BillerService billerServices) {
    model.showAmountField = false;
    model.updateStreamForBillingNumber(true);
    model.serviceTypeTextControl.text = !StringUtils.isDirectionRTL(context)
        ? billerServices.serviceDescriptionEn!
        : billerServices.serviceDescriptionAr!;
    model.serviceTypeApiVal = billerServices.serviceType!;
    model.serviceDescriptionEn.text = billerServices.serviceDescriptionEn ?? "";
    AppConstantsUtils.SELECTED_SERVICE_DESCRIPTION_EN = billerServices.serviceDescriptionEn ?? "";
    AppConstantsUtils.SELECTED_SERVICE_TYPE = billerServices.serviceType!;
    AppConstantsUtils.SELECTED_SERVICE_CODE = billerServices.serviceCode!;
    AppConstantsUtils.BILLER_TYPE = billerServices.paymentType!;
    AppConstantsUtils.IS_NEW_PAYMENT = true;
    if (billerServices.paymentType! == AppConstantsUtils.PREPAID_KEY) {
      _paymentTypePrePaid(billerServices);
    } else if (billerServices.paymentType! == AppConstantsUtils.POSTPAID_KEY) {
      _paymentTypePostPaid(billerServices);
    }
  }

  void _paymentTypePrePaid(BillerService billerServices) {
    model.updateStreamForShowAmount(billerServices.containPrepaidCat!);
    model.fieldTextLabelEn =
        !StringUtils.isDirectionRTL(context) ? billerServices.fieldLabelEn! : billerServices.fieldLabelAr!;
    model.updateStreamForBillingNumber(billerServices.billingNoRequired!);
    Future.delayed(Duration(milliseconds: 200)).then((value) => {
      model.getPrePaidCategoriesList(
            AppConstantsUtils.SELECTED_SERVICE_CODE,
            AppConstantsUtils.SELECTED_BILLER_CODE,
          )
        });
  }

  void _paymentTypePostPaid(BillerService billerServices) {
    model.fieldTextLabelEn =
        !StringUtils.isDirectionRTL(context) ? billerServices.fieldLabelEn! : billerServices.fieldLabelAr!;
    model.updateStreamForBillingNumber(true);
    model.updateStreamForShowAmount(false);
  }

  ///show pre paid categories dialog
  Widget _ShowDenomination() {
    return AppStreamBuilder<bool>(
      stream: model.isPrepaidCategoryListEmptyStream,
      initialData: false,
      dataBuilder: (_, isPrepaidCategoryListEmpty) {
        model.isPrepaidCategoryListEmpty = isPrepaidCategoryListEmpty!;
        AppConstantsUtils.IS_PRE_PAID_CATEGORY_LIST_EMPTY = isPrepaidCategoryListEmpty;
        return Visibility(
          visible: !isPrepaidCategoryListEmpty,
          child: Padding(
            padding: EdgeInsetsDirectional.only(top: 16.0.h),
            child: AppTextField(
              labelText: S.of(context).denomination.toUpperCase(),
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
                    padding: EdgeInsetsDirectional.only(end: 8.w),
                    child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
              },
            ),
          ),
        );
      },
    );
  }

  Widget _showAmountForPrepaid() {
    return AppStreamBuilder<bool>(
        stream: model.isShowAmountStream,
        initialData: false,
        dataBuilder: (context, isShowAmount) {
          return Visibility(
            visible: isShowAmount!,
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 16.0.h),
              child: AppTextField(
                labelText: S.of(context).amount.toUpperCase(),
                hintText: S.of(context).pleaseEnter,
                controller: model.amountTextControl,
                inputType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    model.amountText = text;
                    model.amountTextControl.text = text;
                    model.amountTextControl.selection =
                        TextSelection.fromPosition(TextPosition(offset: model.amountTextControl.text.length));
                    model.validateData(context);
                  } else {
                    model.amountText = "0";
                    model.amountTextControl.text = "";
                    model.validateData(context);
                  }
                },
                onPressed: () {
                  // FocusScope.of(context).unfocus();
                },
              ),
            ),
          );
        });
  }

  void _showPrePaidCategoriesList(BuildContext context) {
    DenominationsDialog.show(context,
        getPrePaidCategoriesList: model.getPrepaidCategoriesModelData,
        label: S.of(context).denomination,
        billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
        serviceCode: AppConstantsUtils.SELECTED_SERVICE_CODE, onDismissed: () {
      Navigator.pop(context);
    }, onSelected: (value) {
          AppConstantsUtils.PREPAID_CATEGORY_CODE = value.code.toString();
      AppConstantsUtils.PREPAID_CATEGORY_DESCRIPTION = value.description.toString();
      AppConstantsUtils.PREPAID_CATEGORY_TYPE = value.type.toString();
      model.denominationTextController.text = value.description.toString();
      model.validateData(context);

      Navigator.pop(context);
    });
  }

  void _showBillerNameDialog(List<BillerDetailsList>? billerDetailsList) {
    PayBillDialog.show(context, title: S.of(context).billerName, billerDetailsList: billerDetailsList ?? [],
        onDismissed: () {
      Navigator.pop(context);
    }, onSelected: (billerDetails) {
      resetIfSelectedOtherBillerName(billerDetails.billerCode, model);
      model.updateIsPrepaidCategoryListEmptyResponse(true);
      model.billerNameTextController.text =
          !StringUtils.isDirectionRTL(context) ? billerDetails.billerNameEn! : billerDetails.billerNameAr!;
      AppConstantsUtils.BILLER_NAME =
          !StringUtils.isDirectionRTL(context) ? billerDetails.billerNameEn! : billerDetails.billerNameAr!;
      AppConstantsUtils.SELECTED_BILLER_CODE = billerDetails.billerCode!;
      model.billerCodeTextControl.text = billerDetails.billerCode.toString();
      model.billerCodeString = billerDetails.billerCode.toString();
      model.billerService = billerDetails.billerService!;
      model.validateData(context);
    });
  }
}

void resetIfSelectedOtherBillerName(billerCode, PayBillDetailPageViewModel model) {
  if (billerCode != AppConstantsUtils.SELECTED_BILLER_CODE) {
    model.updateIsPrepaidCategoryListEmptyResponse(true);
    model.amountTextControl.text = "";
    model.amountText = "0";
    AppConstantsUtils.SELECTED_AMOUNT = "";
    AppConstantsUtils.PREPAID_CATEGORY_CODE = "";
    AppConstantsUtils.PREPAID_CATEGORY_DESCRIPTION = "";
    AppConstantsUtils.PREPAID_CATEGORY_TYPE = "";
    model.denominationTextController.text = "";
    model.serviceTypeTextControl.text = "";
    model.billingNumberTextControl.text = "";
    AppConstantsUtils.SELECTED_SERVICE_DESCRIPTION_EN = "";
    AppConstantsUtils.SELECTED_SERVICE_TYPE = "";
    AppConstantsUtils.SELECTED_SERVICE_CODE = "";
    AppConstantsUtils.BILLER_TYPE = "";
  }
}

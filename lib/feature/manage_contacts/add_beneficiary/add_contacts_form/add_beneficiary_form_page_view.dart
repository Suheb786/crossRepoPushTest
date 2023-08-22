import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/check_send_money_message_enum.dart';
import 'package:domain/model/manage_contacts/send_otp_add_benificiary_response.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/payment/number_formatting_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog.dart';
import '../../../../ui/molecules/dialog/payment/purpose_dialog/purpose_dialog.dart';
import '../../../../utils/navgition_type.dart';
import 'add_beneficiary_form_page_view_model.dart';

class AddBeneficiaryFormPageView extends BasePageViewWidget<AddBeneficiaryFormPageViewModel> {
  AddBeneficiaryFormPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<bool>(
        initialData: false,
        stream: model.errorDetectorStream,
        dataBuilder: (context, isError) {
          return ShakeAnimatedWidget(
            enabled: isError ?? false,
            duration: Duration(milliseconds: 100),
            shakeAngle: Rotation.deg(z: 1),
            curve: Curves.easeInOutSine,
            child: AppStreamBuilder<Resource<SendOtpAddBeneficiaryResponse>>(
                initialData: Resource.none(),
                stream: model.addcontactIBANStream,
                onData: (value) {
                  if (value.status == Status.SUCCESS) {
                    model.mobileNumber = value.data?.sendOTPAddBeneficiary?.mobileNumber ?? '';
                    model.mobileCode = value.data?.sendOTPAddBeneficiary?.mobileCode ?? '';
                    ProviderScope.containerOf(context).read(addBeneficiaryViewModelProvider).nextPage();
                    ProviderScope.containerOf(context)
                        .read(addBeneficiaryotpPageViewModel)
                        .otpController
                        .clear();

                    ProviderScope.containerOf(context).read(addBeneficiaryotpPageViewModel).updateTime();
                  }
                },
                dataBuilder: (context, validate) {
                  return AppStreamBuilder<Resource<CheckSendMoneyResponse>>(
                      initialData: Resource.none(),
                      stream: model.checkSendMoneySteam,
                      onData: (value) {
                        if (value.status == Status.SUCCESS) {
                          if (value.data?.checkSendMoneyContent?.transferResponse?.messageEnum ==
                              CheckSendMoneyMessageEnum.Mobile_NUMBER_BANKSMART) {
                            InformationDialog.show(context,
                                isSwipeToCancel: false,
                                title: S.current.mobileNoRegisteredWithBlink,
                                descriptionWidget: Text(
                                  S.current.mobileNoRegisteredWithBlinkDesc,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w400),
                                ),
                                onDismissed: () {}, onSelected: () {
                              Navigator.pop(context);
                            });
                          }
                        }
                      },
                      dataBuilder: (context, validate) {
                        return Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                                    ? 0
                                    : MediaQuery.of(context).viewInsets.bottom - 48),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        AppTextField(
                                            labelText: S.current.nickName.toUpperCase(),
                                            hintText: S.current.pleaseEnter,
                                            controller: model.nameController,
                                            key: model.nameKey,
                                            onChanged: (value) {
                                              model.validate(value);
                                            }),
                                        SizedBox(height: 16.0.h),
                                        Focus(
                                          child: AppTextField(
                                            labelText: model.navigationType == NavigationType.REQUEST_MONEY
                                                ? S.current.accountMobileNoCliQ.toUpperCase()
                                                : S.current.accountMobileNoAlias,
                                            hintText: S.current.pleaseEnter,
                                            controller: model.ibanOrMobileController,
                                            key: model.ibanORaccountORmobileORaliasKey,
                                            onChanged: (value) {
                                              if (value.isEmpty) {
                                                model.showNameVisibility('');
                                                model.ibanFieldValidated = false;
                                              }
                                              model.validate(value);
                                            },
                                            labelIcon: () {
                                              return InkWell(
                                                onTap: () {
                                                  InformationDialog.show(context,
                                                      isSwipeToCancel: false,
                                                      title: S.of(context).contactInformation,
                                                      descriptionWidget: Column(
                                                        children: [
                                                          Text(
                                                            S.of(context).manageContactSendRequestSample,
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                fontSize: 14.t,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                          SizedBox(
                                                            height: 16.h,
                                                          ),
                                                          NumberFormattingWidget(
                                                            title: S.of(context).ibanCliq,
                                                            desc: S.of(context).dummyIBAN,
                                                          ),
                                                          NumberFormattingWidget(
                                                            title: S.of(context).accountBlink,
                                                            desc: S.of(context).dummyAccountNo,
                                                          ),
                                                          NumberFormattingWidget(
                                                            title: S.of(context).mobileNoCliqorBlink,
                                                            desc: S.of(context).dummyMobileNo,
                                                          ),
                                                          NumberFormattingWidget(
                                                            title: S.of(context).aliasCliq,
                                                            desc: S.of(context).dummyAlias,
                                                          )
                                                        ],
                                                      ),
                                                      onDismissed: () {}, onSelected: () {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 5.0.w),
                                                  child: Container(
                                                      height: 14.h,
                                                      width: 14.w,
                                                      child: AppSvg.asset(AssetUtils.info,
                                                          color: Theme.of(context)
                                                              .inputDecorationTheme
                                                              .focusedBorder!
                                                              .borderSide
                                                              .color)),
                                                ),
                                              );
                                            },
                                          ),
                                          onFocusChange: (hasFocus) {
                                            if (!hasFocus) {
                                              model.callAPIforRequestAndSendMoney();
                                            }
                                          },
                                        ),
                                        SizedBox(height: 16.0.h),
                                        AppStreamBuilder<String>(
                                            stream: model.showNameVisibilityStream,
                                            initialData: '',
                                            dataBuilder: (context, visibility) {
                                              return Visibility(
                                                visible: (visibility ?? '').isNotEmpty,
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            S.of(context).nameOfBeneficiary,
                                                            style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 12.0.t,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            visibility ?? '',
                                                            maxLines: 2,
                                                            textAlign: TextAlign.end,
                                                            style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 12.0.t,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              );
                                            }),
                                        SizedBox(height: 24.0.h),
                                        AppStreamBuilder<String>(
                                            stream: model.showNameVisibilityStream,
                                            initialData: '',
                                            dataBuilder: (context, visibility) {
                                              return Visibility(
                                                visible: visibility!.isNotEmpty,
                                                child: AppTextField(
                                                  labelText: S.of(context).purpose,
                                                  hintText: S.of(context).pleaseEnter,
                                                  readOnly: true,
                                                  key: model.purposeKey,
                                                  controller: model.purposeController,
                                                  onPressed: () {
                                                    if (model.purposeList.isNotEmpty) {
                                                      PurposeDialog.show(context,
                                                          purposeList: model.purposeList,
                                                          onSelected: (value) {
                                                        model.updatePurpose(value);
                                                        model.updatePurposeDetaiList(value.purposeDetails!);
                                                        Navigator.pop(context);
                                                      }, onDismissed: () {
                                                        Navigator.pop(context);
                                                      });
                                                    }
                                                  },
                                                  suffixIcon: (value, data) {
                                                    return Container(
                                                        height: 16.0.h,
                                                        width: 16.0.w,
                                                        padding: EdgeInsetsDirectional.only(end: 8.0.w),
                                                        child: AppSvg.asset(AssetUtils.downArrow,
                                                            color:
                                                                Theme.of(context).colorScheme.surfaceTint));
                                                  },
                                                ),
                                              );
                                            }),
                                        SizedBox(height: 16.0.h),
                                        AppStreamBuilder<String>(
                                            stream: model.showNameVisibilityStream,
                                            initialData: '',
                                            dataBuilder: (context, visibility) {
                                              return Visibility(
                                                visible: visibility!.isNotEmpty,
                                                child: AppTextField(
                                                  labelText: S.of(context).purposeDetails,
                                                  hintText: S.of(context).pleaseEnter,
                                                  readOnly: true,
                                                  controller: model.purposeDetailController,
                                                  key: model.purposeDetailKey,
                                                  onPressed: () {
                                                    if (model.purposeDetailList.isNotEmpty) {
                                                      PurposeDetailDialog.show(context,
                                                          purposeDetailList: model.purposeDetailList,
                                                          onSelected: (value) {
                                                        model.updatePurposeDetail(value);
                                                        Navigator.pop(context);
                                                        model.validate('');
                                                      }, onDismissed: () {
                                                        Navigator.pop(context);
                                                      });
                                                    }
                                                  },
                                                  suffixIcon: (value, data) {
                                                    return Container(
                                                        height: 16.0.h,
                                                        width: 16.0.w,
                                                        padding: EdgeInsetsDirectional.only(end: 8.0.w),
                                                        child: AppSvg.asset(AssetUtils.downArrow,
                                                            color:
                                                                Theme.of(context).colorScheme.surfaceTint));
                                                  },
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  )),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                        child: AppStreamBuilder<bool>(
                                            stream: model.showButtonSubjectStream,
                                            initialData: false,
                                            dataBuilder: (context, isValid) {
                                              return AppPrimaryButton(
                                                text: S.of(context).next,
                                                isDisabled: !isValid!,
                                                onPressed: () {
                                                  model.validationUserInput(context);
                                                },
                                              );
                                            }),
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            S.current.backToContact,
                                            style: TextStyle(
                                              color: AppColor.brightBlue,
                                              fontSize: 14.t,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          );
        });
  }
}

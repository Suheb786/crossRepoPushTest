import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/accounts_dialog/accounts_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SendMoneyQrScanningPageView extends BasePageViewWidget<SendMoneyQrScanningPageViewModel> {
  SendMoneyQrScanningPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).qrPayments,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).youAreAcceptingMoneyRequestViaQr,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
              child: Card(
            child: AppStreamBuilder<Resource<TransferSuccessResponse>>(
                stream: model.transferStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    ///TODO: send other data from api response
                    Navigator.pushNamed(context, RoutePaths.SendMoneyQrScanningSuccess,
                        arguments: SendMoneyViaQRSuccessPageArguments(
                            referenceNo: data.data?.transferSuccessContent?.referenceNo ?? '',
                            amount: model.arguments.amount,
                            user: model.arguments.accountHolderName));
                  } else if (data.status == Status.ERROR) {
                    //Navigator.pushNamed(context, RoutePaths.SendMoneyFailure);
                  }
                },
                dataBuilder: (context, snapshot) {
                  return AppStreamBuilder<Resource<CheckSendMoneyResponse>>(
                      stream: model.checkSendMoneyStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.transfer(data.data!.checkSendMoneyContent!.transferResponse!);
                        }
                      },
                      dataBuilder: (context, checkSendMoneyResponse) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity!.isNegative) {
                              if (model.payFromController.text.isEmpty) {
                                model.showToastWithError(AppError(
                                    cause: Exception(),
                                    error: ErrorInfo(message: ''),
                                    type: ErrorType.SELECT_ACCOUNT));
                              } else {
                                model.checkSendMoney();
                              }
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 38,
                                  ),
                                  Text(
                                    S.of(context).amount,
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          model.arguments.amount,
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(start: 4.0, top: 2),
                                          child: Text(
                                            S.of(context).JOD,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: AppColor.verLightGray4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 32, start: 24, end: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          S.of(context).nameOfBeneficiary,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColor.dark_gray_1),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(start: 4.0),
                                          child: Text(
                                            model.arguments.accountHolderName,
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 24, top: 32, end: 24),
                                    child: AppTextField(
                                      labelText: S.of(context).payFrom.toUpperCase(),
                                      hintText: S.of(context).pleaseSelect,
                                      controller: model.payFromController,
                                      key: model.payFromKey,
                                      readOnly: true,
                                      onPressed: () {
                                        AccountsDialog.show(context, label: S.of(context).selectAccount,
                                            onDismissed: () {
                                          Navigator.pop(context);
                                        }, onSelected: (value) {
                                          Navigator.pop(context);
                                          model.payFromController.text = value;
                                          model.validate();
                                        });
                                      },
                                      suffixIcon: (isValid, value) {
                                        return Container(
                                            height: 16,
                                            width: 16,
                                            padding: EdgeInsets.symmetric(horizontal: 7),
                                            child: AppSvg.asset(AssetUtils.downArrow,
                                                color: Theme.of(context).primaryColorDark));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  AppStreamBuilder<bool>(
                                      stream: model.showButtonStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 26.0),
                                          child: Visibility(
                                            visible: isValid!,
                                            child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
                                          ),
                                        );
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          S.of(context).backToPayments,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.brightBlue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                }),
          ))
        ],
      ),
    );
  }
}

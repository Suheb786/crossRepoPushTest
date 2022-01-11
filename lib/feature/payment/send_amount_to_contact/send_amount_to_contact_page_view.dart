import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/edit_transaction_purpose_dialog/edit_transaction_purpose_dialog.dart';
import 'package:neo_bank/ui/molecules/numeric_keyboard.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SendAmountToContactPageView
    extends BasePageViewWidget<SendAmountToContactViewModel> {
  SendAmountToContactPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
          } else {
            Navigator.pop(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Container(
                      height: 50,
                      width: 281,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    child: Column(
                      children: [
                        AppSvg.asset(AssetUtils.downArrow),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            S.of(context).backToPayments,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColor.dark_gray_2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: model.beneficiary.imageUrl.toString().isNotEmpty
                  ? CircleAvatar(
                      radius: 28,
                      backgroundImage: Image.memory(
                        model.beneficiary.imageUrl,
                        fit: BoxFit.cover,
                      ).image,
                    )
                  : CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).canvasColor,
                      child: Text(
                        StringUtils.getFirstInitials(
                            model.beneficiary.fullName),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1!
                                .color),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                S.of(context).sendMoneyTo,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              (model.beneficiary.nickName != null &&
                      model.beneficiary.nickName!.isNotEmpty)
                  ? model.beneficiary.nickName!
                  : model.beneficiary.fullName!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, right: 24, left: 24),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColor.whiteGray)),
                padding:
                    EdgeInsets.only(top: 14, bottom: 14, left: 26, right: 34),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).transactionPurpose,
                      style: TextStyle(
                          color: AppColor.dark_gray_1,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppStreamBuilder<String>(
                              stream: model.purposeStream,
                              initialData: (model.beneficiary.purpose != null &&
                                      model.beneficiary.purpose!.isNotEmpty)
                                  ? model.beneficiary.purpose!
                                  : 'Personal',
                              dataBuilder: (context, value) {
                                return Text(
                                  value!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                );
                              }),
                          InkWell(
                            onTap: () {
                              EditTransactionPurposeDialog.show(context,
                                  onDismissed: () {
                                Navigator.pop(context);
                              }, onSelected: (value1, value2) {
                                print("got value: $value1");
                                model.updatePurpose(value1);
                                model.updatePurposeDetail(value2);
                                Navigator.pop(context);
                              }, beneficiary: model.beneficiary);
                            },
                            child: Text(
                              S.of(context).edit,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .accentTextTheme
                                      .bodyText1!
                                      .color),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: AppStreamBuilder<String>(
                          stream: model.purposeDetailStream,
                          initialData: (model.beneficiary.purposeDetails !=
                                      null &&
                                  model.beneficiary.purposeDetails!.isNotEmpty)
                              ? model.beneficiary.purposeDetails!
                              : 'Transfer to Friend or Family',
                          dataBuilder: (context, value) {
                            return Text(
                              value!,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 27, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          model.currentPinValue,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              fontFamily: 'Montserrat',
                              color: AppColor.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 4),
                          child: Text(
                            "JOD",
                            style: TextStyle(
                                color: AppColor.verLightGray4,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        model.clearValue();
                      },
                      child: AppSvg.asset(AssetUtils.backspaceBlue),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                S.of(context).accountBalance,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: AppColor.dark_gray_1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ProviderScope.containerOf(context)
                        .read(appHomeViewModelProvider)
                        .dashboardDataContent
                        .account!
                        .availableBalance!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.0, top: 2),
                    child: Text(
                      "JOD",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColor.dark_gray_1),
                    ),
                  ),
                ],
              ),
            ),
            AppStreamBuilder<Resource<TransferSuccessResponse>>(
                stream: model.transferStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    Navigator.pushNamed(
                        context, RoutePaths.SendAmountToContactSuccess,
                        arguments: data.data!.transferSuccessContent);
                  } else if (data.status == Status.ERROR) {
                    Navigator.pushNamed(context, RoutePaths.SendMoneyFailure);
                  }
                },
                dataBuilder: (context, snapshot) {
                  return AppStreamBuilder<Resource<CheckSendMoneyResponse>>(
                      stream: model.checkSendMoneyStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          print("check send money success");
                          model.transfer(data
                              .data!.checkSendMoneyContent!.transferResponse!);
                        }
                      },
                      dataBuilder: (context, checkSendMoneyResponse) {
                        return Expanded(
                          child: NumericKeyboard(
                              onKeyboardTap: (value) {
                                model.changeValue(value);
                              },
                              textColor: Colors.black,
                              rightButtonFn: () {
                                model.checkSendMoney();
                              },
                              leftIcon: Icon(
                                Icons.circle,
                                color: AppColor.black,
                                size: 5,
                              ),
                              rightWidget: CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xFF3CB4E5),
                                child: Center(
                                  child: AppSvg.asset(AssetUtils.next),
                                ),
                              ),
                              leftButtonFn: () {
                                model.changeValue(".");
                              },
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}

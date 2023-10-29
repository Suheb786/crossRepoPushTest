import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../di/dashboard/dashboard_modules.dart';
import '../../../../ui/molecules/app_svg.dart';
import '../../../../ui/molecules/dialog/sub_accounts_dialogs/select_account_list_dialog/select_account_list_dialog.dart';
import '../../../../utils/asset_utils.dart';

class RjMakePaymentView extends BasePageViewWidget<RjMakePaymentViewModel> {
  RjMakePaymentView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
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
                child: AppStreamBuilder<Resource<bool>>(
                    initialData: Resource.none(),
                    stream: model.rjOtpValidateStream,
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context)
                            .read(rjFlightBookingDetailViewModelProvider)
                            .nextPage();
                        ProviderScope.containerOf(context)
                            .read(rjOtpValidateViewModelProvider)
                            .otpController
                            .clear();
                      }
                    },
                    dataBuilder: (BuildContext context, data) {
                      return Card(
                        margin: EdgeInsets.zero,
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                            child: Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    S.of(context).payFromRJ,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).colorScheme.surfaceVariant,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.t),
                                  ),
                                ),
                                Visibility(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(top: 16.0.h),
                                    child: AppStreamBuilder<Account>(
                                        initialData: ProviderScope.containerOf(context)
                                            .read(appHomeViewModelProvider)
                                            .dashboardDataContent
                                            .account!,
                                        stream: model.selectedFromAccountStream,
                                        onData: (value) {
                                          // model.addFromAccountData(selectedAccount: value);
                                        },
                                        dataBuilder: (context, selectedFromAccount) {
                                          return InkWell(
                                            onTap: () {
                                              SelectAccountListDialog.show(
                                                context,
                                                title: S.current.payFromRJ,
                                                accountList: ProviderScope.containerOf(context)
                                                    .read(appHomeViewModelProvider)
                                                    .getAllMyAccounts(),
                                                onDismissed: () => Navigator.pop(context),
                                                onConfirm: (value) {
                                                  model.selectedAccount = value;
                                                  model.addFromAccountData(account: value);
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              padding: EdgeInsetsDirectional.all(16.h),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1,
                                                    color: (Theme.of(context)
                                                        .inputDecorationTheme
                                                        .enabledBorder!
                                                        .borderSide
                                                        .color)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 7,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          S.current.payFromRJ.toUpperCase(),
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 10.0.t,
                                                              color: Theme.of(context).primaryColorDark,
                                                              fontWeight: FontWeight.w400),
                                                        ),
                                                        SizedBox(height: 8.h),
                                                        Text(
                                                          "${(selectedFromAccount?.isSubAccount ?? false) ? "${selectedFromAccount?.nickName == null ? S.of(context).subAccount : "${S.of(context).subAccount} - ${selectedFromAccount?.nickName}"}" : "${selectedFromAccount?.nickName == null ? S.of(context).mainAccount : "${S.of(context).mainAccount} - ${selectedFromAccount?.nickName}"}"}",
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 14.0.t,
                                                              color: Theme.of(context).colorScheme.shadow,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(height: 4.h),
                                                        Text(
                                                          selectedFromAccount?.accountNo ?? "",
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 12.0.t,
                                                              color:
                                                                  Theme.of(context).colorScheme.surfaceTint,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(height: 16.h),
                                                        Text(
                                                          StringUtils.formatBalance(
                                                                  selectedFromAccount?.availableBalance ??
                                                                      '0.00') +
                                                              " " +
                                                              S.of(context).JOD,
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 14.0.t,
                                                              color: Theme.of(context).colorScheme.shadow,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                        height: 16.h,
                                                        width: 16.w,
                                                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                                                        child: AppSvg.asset(AssetUtils.downArrow,
                                                            color: Theme.of(context).primaryColorDark)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    AppPrimaryButton(
                                      text: S.of(context).next,
                                      onPressed: () {
                                        if (double.parse(model.selectedAccount?.availableBalance ?? '0.0') <
                                            double.parse(ProviderScope.containerOf(context)
                                                    .read(rjConfirmFlightBookingViewModelProvider)
                                                    .flightDetailResponse
                                                    .flightDetailContent
                                                    ?.paymentAmount ??
                                                '0.0')) {
                                          model.showToastWithError(AppError(
                                              cause: Exception(),
                                              error: ErrorInfo(message: ''),
                                              type: ErrorType.NO_BALANCE_ACCOUNT));
                                        } else {
                                          model.rjOtpValidate();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 31.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ProviderScope.containerOf(context)
                                            .read(rjFlightBookingDetailViewModelProvider)
                                            .previousPage();
                                      },
                                      child: Text(
                                        S.of(context).back,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    }));
          }),
    );
  }
}

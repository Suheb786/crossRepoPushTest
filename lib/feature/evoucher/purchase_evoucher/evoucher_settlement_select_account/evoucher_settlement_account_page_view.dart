import 'package:animated_widgets/animated_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/e_voucher/e_voucher_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/evoucher_settlement_select_account/evoucher_settlement_account_page_view_model.dart.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../payment/account_swiching/payment_account_switcher.dart';

class EvoucherSettlementAccountPageView extends BasePageViewWidget<EvoucherSettlementAccountPageViewModel> {
  EvoucherSettlementAccountPageView(
    ProviderBase model,
  ) : super(model);

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
              child: AppStreamBuilder<Resource<EVoucherOTP>>(
                  initialData: Resource.none(),
                  stream: model.evoucherOtpStream,
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context).read(purchaseEVouchersViewModelProvider).nextPage();
                      ProviderScope.containerOf(context)
                          .read(enterOtpForEVoucherCategoryPurchaseViewModelProvider)
                          .otpController
                          .clear();
                    }
                  },
                  dataBuilder: (context, otpSnapShot) {
                    return AppStreamBuilder<Resource<bool>>(
                      stream: model.selectAccountStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.getOTP();
                        } else if (data.status == Status.ERROR) {
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, data) {
                        return Card(
                          margin: EdgeInsets.zero,
                          child: AppStreamBuilder<SelectedVoucherInformation>(
                              stream: model.getSelectedVoucherInformationStream,
                              initialData: SelectedVoucherInformation(
                                  voucherName: '-', voucherFaceImage: '', settlementValue: 0.0),
                              dataBuilder: (context, selectedInformation) {
                                return Container(
                                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Container(
                                                  height: 72.h,
                                                  width: 72.w,
                                                  child: selectedInformation!.voucherFaceImage.isNotEmpty
                                                      ? CachedNetworkImage(
                                                          imageUrl: selectedInformation.voucherFaceImage,
                                                          placeholder: (context, url) => Container(
                                                              color: Theme.of(context).primaryColor),
                                                          errorWidget: (context, url, error) =>
                                                              Icon(Icons.error),
                                                          fit: BoxFit.fill,
                                                        )
                                                      : SizedBox(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Text(
                                                selectedInformation.voucherName,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: Theme.of(context).indicatorColor,
                                                  fontSize: 14.t,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${selectedInformation.settlementValue.toStringAsFixed(3)}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: Theme.of(context).indicatorColor,
                                                      fontSize: 24.t,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4.h,
                                                  ),
                                                  Text(
                                                    S.current.JOD,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: Theme.of(context).colorScheme.tertiaryContainer,
                                                      fontSize: 14.t,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 32.h,
                                              ),
                                              PaymentAccountSwitcher(
                                                title: S.of(context).payFrom,
                                                onDefaultSelectedAccount: (Account) {
                                                  print('onDefaultSelectedAccount $Account');
                                                },
                                                onSelectAccount: (Account) {
                                                  print('onSelectAccount $Account');
                                                },
                                                isSingleLineView: false,
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.only(top: 12.0.h, bottom: 23.h),
                                              child: AppStreamBuilder<bool>(
                                                stream: model.showButtonStream,
                                                initialData: false,
                                                dataBuilder: (context, isValid) {
                                                  return AppPrimaryButton(
                                                    text: S.of(context).next,
                                                    isDisabled: !isValid!,
                                                    onPressed: () {
                                                      model.validateFields(context);
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                ProviderScope.containerOf(context)
                                                    .read(purchaseEVouchersViewModelProvider)
                                                    .previousPage();
                                              },
                                              child: Text(
                                                S.of(context).back,
                                                style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                                  fontSize: 14.t,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                              }),
                        );
                      },
                    );
                  }),
            );
          }),
    );
  }
}

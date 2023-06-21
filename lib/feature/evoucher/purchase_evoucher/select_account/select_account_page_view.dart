import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_account/select_account_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
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

class SelectAccountPageView extends BasePageViewWidget<SelectAccountPageViewModel> {
  SelectAccountPageView(ProviderBase model) : super(model);

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
                stream: model.selectAccountStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    if (data.data ?? false) {
                      Navigator.pushReplacementNamed(context, RoutePaths.EVouchersPurchaseSuccess);
                    }
                  } else if (data.status == Status.ERROR) {
                    model.showToastWithError(data.appError!);
                  }
                },
                dataBuilder: (context, data) {
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (ProviderScope.containerOf(context)
                              .read(purchaseEVouchersViewModelProvider)
                              .appSwiperController
                              .page ==
                          1.0) {
                        FocusScope.of(context).unfocus();
                        if (StringUtils.isDirectionRTL(context)) {
                          if (!details.primaryVelocity!.isNegative) {
                            model.validateFields();
                          } else {
                            ProviderScope.containerOf(context)
                                .read(purchaseEVouchersViewModelProvider)
                                .previousPage();
                          }
                        } else {
                          if (details.primaryVelocity!.isNegative) {
                            model.validateFields();
                          } else {
                            ProviderScope.containerOf(context)
                                .read(purchaseEVouchersViewModelProvider)
                                .previousPage();
                          }
                        }
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                          child: Column(
                            children: [
                              AppTextField(
                                labelText: S.of(context).payFrom.toUpperCase(),
                                hintText: S.of(context).pleaseSelect,
                                readOnly: true,
                                controller: model.accountController,
                                key: model.accountKey,
                                onPressed: () {
                                  AccountsDialog.show(context,
                                      accountsList: ['5669 4900 2111', '5669 4900 2111'],
                                      label: S.of(context).payFrom, onDismissed: () {
                                    Navigator.pop(context);
                                  }, onSelected: (value) {
                                    Navigator.pop(context);
                                    model.accountController.text = value;
                                    model.validate();
                                  });
                                },
                                suffixIcon: (value, data) {
                                  return Container(
                                      height: 16,
                                      width: 16,
                                      padding: EdgeInsetsDirectional.only(end: 8),
                                      child: AppSvg.asset(AssetUtils.downArrow, color: Theme.of(context).colorScheme.surfaceTint));
                                },
                              ),
                              Spacer(),

                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 12.0),
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
                              // SizedBox(
                              //   height:
                              //       MediaQuery.of(context).viewInsets.bottom,
                              // ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}

import 'package:animated_widgets/animated_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/e_voucher/get_settlement_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SelectRegionAmountPageView extends BasePageViewWidget<SelectRegionAmountPageViewModel> {
  SelectRegionAmountPageView(ProviderBase model) : super(model);

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
                stream: model.selectRegionAmountStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    model.getSettlementAmmount(
                        Amount: model.argument.selectedItem.fromValue.toString(),
                        FromCurrency: model.argument.selectedItem.currency,
                        ToCurrency: "JOD");
                    // ProviderScope.containerOf(context)
                    //     .read(purchaseEVouchersViewModelProvider(model.argument))
                    //     .nextPage();
                  } else if (data.status == Status.ERROR) {
                    model.showToastWithError(data.appError!);
                  }
                },
                dataBuilder: (context, data) {
                  return AppStreamBuilder<Resource<GetSettlementAmount>>(
                      initialData: Resource.none(),
                      stream: model.getSettlementAmountStream,
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          ProviderScope.containerOf(context)
                              .read(evoucherSettlementAccountViewModelProvider(model.argument))
                              .getSettleValue(data.data?.content ?? 0.0);

                          ProviderScope.containerOf(context)
                              .read(purchaseEVouchersViewModelProvider(model.argument))
                              .nextPage();
                          // print("${data.data?.content}:::: this is settlement ammount");
                        }
                      },
                      dataBuilder: (context, settlementAmmount) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (ProviderScope.containerOf(context)
                                    .read(purchaseEVouchersViewModelProvider(model.argument))
                                    .appSwiperController
                                    .page ==
                                0.0) {
                              FocusScope.of(context).unfocus();
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.validateFields();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.validateFields();
                                }
                              }
                            }
                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Container(
                                                height: 72.h,
                                                width: 72.w,
                                                child: CachedNetworkImage(
                                                  imageUrl: model.argument.selectedItem.cardFaceImage,
                                                  placeholder: (context, url) =>
                                                      Container(color: Theme.of(context).primaryColor),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Text(
                                              model.argument.selectedItem.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: Theme.of(context).indicatorColor,
                                                fontSize: 14.t,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 32.h,
                                            ),
                                            AppTextField(
                                              labelText: S.of(context).region.toUpperCase(),
                                              hintText: S.of(context).pleaseSelect,
                                              readOnly: true,
                                              controller: model.selectedRegionController,
                                              key: model.selectedRegionKey,
                                              onPressed: () {
                                                RelationshipWithCardHolderDialog.show(context,
                                                    title: S.of(context).preferredRegion,
                                                    relationSHipWithCardHolder: model.voucherCountries,
                                                    onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.selectedRegionController.text = value;
                                                  model.getVoucherValue();
                                                  model.validate();
                                                });
                                              },
                                              suffixIcon: (value, data) {
                                                return Container(
                                                    height: 16.h,
                                                    width: 16.h,
                                                    padding: EdgeInsetsDirectional.only(end: 8),
                                                    child: AppSvg.asset(AssetUtils.downArrow,
                                                        color: Theme.of(context).colorScheme.surfaceTint));
                                              },
                                            ),
                                            SizedBox(height: 16.h),
                                            AppTextField(
                                              labelText: S.of(context).value.toUpperCase(),
                                              hintText: S.of(context).pleaseSelect,
                                              readOnly: true,
                                              controller: model.amountController,
                                              key: model.amountKey,
                                              onPressed: () {
                                                if (model.selectedRegionController.text != "") {
                                                  RelationshipWithCardHolderDialog.show(context,
                                                      title: S.of(context).minPrice,
                                                      relationSHipWithCardHolder: model.voucherValue,
                                                      onDismissed: () {
                                                    Navigator.pop(context);
                                                  }, onSelected: (value) {
                                                    Navigator.pop(context);
                                                    model.amountController.text = value;
                                                    model.validate();
                                                  });
                                                } else if (model.selectedRegionController.text == "") {
                                                  model.selectedRegionKey.currentState!.isValid = false;
                                                  model.showToastWithError(AppError(
                                                      error: ErrorInfo(message: ''),
                                                      type: ErrorType.SELECT_REGION_FIRST,
                                                      cause: Exception()));
                                                }
                                              },
                                              suffixIcon: (value, data) {
                                                return Container(
                                                    height: 16.h,
                                                    width: 16.h,
                                                    padding: EdgeInsetsDirectional.only(end: 8),
                                                    child: AppSvg.asset(AssetUtils.downArrow,
                                                        color: Theme.of(context).colorScheme.surfaceTint));
                                              },
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                          ],
                                        ),
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
                                                return Visibility(
                                                  visible: isValid!,
                                                  child: AnimatedButton(
                                                    buttonText: S.of(context).swipeToProceed,
                                                  ),
                                                );
                                              }),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
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
                                )),
                          ),
                        );
                      });
                },
              ),
            );
          }),
    );
  }
}

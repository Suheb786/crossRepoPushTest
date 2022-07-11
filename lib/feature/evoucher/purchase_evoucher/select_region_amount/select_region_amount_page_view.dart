import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
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
                    ProviderScope.containerOf(context).read(purchaseEVouchersViewModelProvider).nextPage();
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
                          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                                          height: 72,
                                          width: 72,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'PlayStation',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).indicatorColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 32,
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
                                              relationSHipWithCardHolder: model.preferredRegionList,
                                              onDismissed: () {
                                            Navigator.pop(context);
                                          }, onSelected: (value) {
                                            Navigator.pop(context);
                                            model.selectedRegionController.text = value;
                                            model.validate();
                                          });
                                        },
                                        suffixIcon: (value, data) {
                                          return Container(
                                              height: 16,
                                              width: 16,
                                              padding: EdgeInsetsDirectional.only(end: 8),
                                              child: AppSvg.asset(AssetUtils.downArrow,
                                                  color: AppColor.dark_gray_1));
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      AppTextField(
                                        labelText: S.of(context).value.toUpperCase(),
                                        hintText: S.of(context).pleaseSelect,
                                        readOnly: true,
                                        controller: model.amountController,
                                        key: model.amountKey,
                                        onPressed: () {
                                          RelationshipWithCardHolderDialog.show(context,
                                              title: S.of(context).minPrice,
                                              relationSHipWithCardHolder: model.priceList, onDismissed: () {
                                            Navigator.pop(context);
                                          }, onSelected: (value) {
                                            Navigator.pop(context);
                                            model.amountController.text = value;
                                            model.validate();
                                          });
                                        },
                                        suffixIcon: (value, data) {
                                          return Container(
                                              height: 16,
                                              width: 16,
                                              padding: EdgeInsetsDirectional.only(end: 8),
                                              child: AppSvg.asset(AssetUtils.downArrow,
                                                  color: AppColor.dark_gray_1));
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ///TODO:make dynamic text
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      S.of(context).backToCategory('Games'),
                                      style: TextStyle(
                                        color: AppColor.brightBlue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
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
                                ],
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

import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card/personalize_credit_card/personalize_credit_card_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
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

class PersonalizeCreditCardPageView
    extends BasePageViewWidget<PersonalizeCreditCardPageViewModel> {
  PersonalizeCreditCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PersonalizeCreditCardPageViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.supplementaryCreditCardResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            Navigator.pushNamed(
                                context,
                                RoutePaths
                                    .SupplementaryCreditCardActivationStatus);
                          }
                        },
                        dataBuilder: (context, snapshot) {
                          return AppStreamBuilder<Resource<bool>>(
                              stream: model.personalizeCreditCardResponseStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  model.supplementaryCreditCardRequest(
                                      primaryId: ProviderScope.containerOf(
                                                  context)
                                              .read(
                                                  supplementaryCreditCardViewModelProvider)
                                              .creditCard
                                              .cardId ??
                                          '',
                                      relationShip: ProviderScope.containerOf(
                                              context)
                                          .read(
                                              relationShipWithCardHolderViewModelProvider)
                                          .relationshipController
                                          .text,
                                      scannedDocumentInformation: ProviderScope
                                              .containerOf(context)
                                          .read(
                                              supplementaryIdScanInfoViewModelProvider)
                                          .scannedDocumentInformation);
                                } else if (data.status == Status.ERROR) {
                                  if (data.appError!.type ==
                                      ErrorType.SELECT_MINIMUM_SETTLEMENT) {
                                    model.minimumSettlementKey.currentState!
                                        .isValid = false;
                                  } else if (data.appError!.type ==
                                      ErrorType.SELECT_CREDIT_LIMIT_SETTINGS) {
                                    model.creditLimitSettingsKey.currentState!
                                        .isValid = false;
                                  }
                                  model.showToastWithError(data.appError!);
                                }
                              },
                              dataBuilder: (context, data) {
                                return GestureDetector(
                                  onHorizontalDragEnd: (details) {
                                    if (ProviderScope.containerOf(context)
                                            .read(
                                                supplementaryCreditCardViewModelProvider)
                                            .appSwiperController
                                            .page ==
                                        2.0) {
                                      FocusScope.of(context).unfocus();
                                      if (details.primaryVelocity!.isNegative) {
                                        model.personalizeCreditCard();
                                      } else {
                                        ProviderScope.containerOf(context)
                                            .read(
                                                supplementaryCreditCardViewModelProvider)
                                            .previousPage();
                                        // .previous();
                                      }
                                    }
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                          .viewInsets
                                                          .bottom -
                                                      50 <=
                                                  0
                                              ? 0
                                              : MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom -
                                                  48),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 32, horizontal: 24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                physics:
                                                    ClampingScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    AppTextField(
                                                      labelText: S
                                                          .of(context)
                                                          .creditLimitSettings
                                                          .toUpperCase(),
                                                      hintText: S
                                                          .of(context)
                                                          .pleaseSelect,
                                                      readOnly: true,
                                                      controller: model
                                                          .creditLimitSettingsController,
                                                      onPressed: () {
                                                        RelationshipWithCardHolderDialog.show(
                                                            context,
                                                            onDismissed: () {
                                                          Navigator.pop(
                                                              context);
                                                        }, onSelected: (value) {
                                                          Navigator.pop(
                                                              context);
                                                          model
                                                              .updateCreditLimitSettingValue(
                                                                  value,
                                                                  context);
                                                          model.validate();
                                                        },
                                                            title: S
                                                                .of(context)
                                                                .creditLimitSettings,
                                                            relationSHipWithCardHolder:
                                                                model
                                                                    .creditLimitsSettings);
                                                      },
                                                      suffixIcon:
                                                          (value, data) {
                                                        return Container(
                                                            height: 16,
                                                            width: 16,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 8),
                                                            child: AppSvg.asset(
                                                                AssetUtils
                                                                    .downArrow,
                                                                color: AppColor
                                                                    .dark_gray_1));
                                                      },
                                                      key: model
                                                          .creditLimitSettingsKey,
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    // AppTextField(
                                                    //   labelText: S
                                                    //       .of(context)
                                                    //       .minimumSettlements
                                                    //       .toUpperCase(),
                                                    //   hintText:
                                                    //       S.of(context).pleaseSelect,
                                                    //   readOnly: true,
                                                    //   controller: model
                                                    //       .minimumSettlementController,
                                                    //   onPressed: () {
                                                    //     RelationshipWithCardHolderDialog.show(
                                                    //         context, onDismissed: () {
                                                    //       Navigator.pop(context);
                                                    //     }, onSelected: (value) {
                                                    //       Navigator.pop(context);
                                                    //       model
                                                    //           .minimumSettlementController
                                                    //           .text = value;
                                                    //       model.validate();
                                                    //     },
                                                    //         title: S
                                                    //             .of(context)
                                                    //             .minimumSettlements,
                                                    //         relationSHipWithCardHolder:
                                                    //             model
                                                    //                 .minimumSettlements);
                                                    //   },
                                                    //   suffixIcon: (value, data) {
                                                    //     return Container(
                                                    //         height: 16,
                                                    //         width: 16,
                                                    //         padding: EdgeInsets.only(
                                                    //             right: 8),
                                                    //         child: AppSvg.asset(
                                                    //             AssetUtils.downArrow,
                                                    //             color: AppColor
                                                    //                 .dark_gray_1));
                                                    //   },
                                                    //   key: model.minimumSettlementKey,
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 16,
                                                    // ),
                                                    AppStreamBuilder<bool>(
                                                        stream: model
                                                            .minimumPayBackStream,
                                                        initialData: true,
                                                        dataBuilder: (context,
                                                            readOnly) {
                                                          return AppTextField(
                                                            labelText: S
                                                                .of(context)
                                                                .minimumSettlements
                                                                .toUpperCase(),
                                                            hintText: S
                                                                .of(context)
                                                                .pleaseSelect,
                                                            textFieldBorderColor: readOnly ??
                                                                    false
                                                                ? Theme.of(
                                                                        context)
                                                                    .textSelectionTheme
                                                                    .selectionColor!
                                                                    .withOpacity(
                                                                        0.1)
                                                                : Theme.of(
                                                                        context)
                                                                    .inputDecorationTheme
                                                                    .enabledBorder!
                                                                    .borderSide
                                                                    .color,
                                                            readOnly: true,
                                                            controller: model
                                                                .minimumSettlementController,
                                                            onPressed:
                                                                readOnly ??
                                                                        false
                                                                    ? () {}
                                                                    : () {
                                                                        RelationshipWithCardHolderDialog.show(
                                                                            context,
                                                                            onDismissed:
                                                                                () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }, onSelected:
                                                                                (value) {
                                                                          Navigator.pop(
                                                                              context);
                                                                          model.minimumSettlementController.text =
                                                                              value;
                                                                          model
                                                                              .validate();
                                                                        },
                                                                            title:
                                                                                S.of(context).minimumSettlements,
                                                                            relationSHipWithCardHolder: model.minimumSettlements);
                                                                      },
                                                            suffixIcon:
                                                                (value, data) {
                                                              return readOnly ??
                                                                      false
                                                                  ? Container()
                                                                  : Container(
                                                                      height:
                                                                          16,
                                                                      width: 16,
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              8),
                                                                      child: AppSvg.asset(
                                                                          AssetUtils
                                                                              .downArrow,
                                                                          color:
                                                                              AppColor.dark_gray_1));
                                                            },
                                                            key: model
                                                                .minimumSettlementKey,
                                                          );
                                                        }),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    AppTextField(
                                                      labelText: S
                                                          .of(context)
                                                          .nickName
                                                          .toUpperCase(),
                                                      hintText: S
                                                          .of(context)
                                                          .optional,
                                                      controller: model
                                                          .nickNameController,
                                                      key: model.nickNameKey,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: AppStreamBuilder<bool>(
                                                  stream:
                                                      model.showButtonStream,
                                                  initialData: false,
                                                  dataBuilder:
                                                      (context, isValid) {
                                                    return Visibility(
                                                      visible: isValid!,
                                                      child: AnimatedButton(
                                                        buttonText: S
                                                            .of(context)
                                                            .swipeToProceed,
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

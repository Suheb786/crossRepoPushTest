import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/payment/request_from_new_recipient/request_from_new_recipient_view_model.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog.dart';
import 'package:neo_bank/ui/molecules/profile/profile_row_item.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class RequestFromNewRecipientPageView
    extends BasePageViewWidget<RequestFromNewRecipientViewModel> {
  RequestFromNewRecipientPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, RequestFromNewRecipientViewModel model) {
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
                        stream: model.sendToNewRecipientResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RequestAmountFromContactSuccessPage()));
                          } else if (data.status == Status.ERROR) {
                            // if (data.appError!.type ==
                            //     ErrorType.EMPTY_RESIDENT_COUNTRY) {
                            //   model.residentCountryKey.currentState!.isValid =
                            //       false;
                            // }
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity!.isNegative) {
                                model.sendToNewRecipient();
                              } else {
                                // ProviderScope.containerOf(context)
                                //     .read(
                                //         paymentToNewRecipientViewModelProvider)
                                //     .pageController
                                //     .previous();
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 2,
                              color: Theme.of(context)
                                  .cardTheme
                                  .copyWith(color: AppColor.white)
                                  .color,
                              margin: EdgeInsets.zero,
                              shadowColor: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.32),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 32, left: 24, right: 24),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              S.of(context).requestedMoneyVia,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 16.0),
                                              child: AppTextField(
                                                labelText:
                                                    S.of(context).ibanOrMobile,
                                                hintText:
                                                    S.of(context).pleaseEnter,
                                                controller: model
                                                    .ibanOrMobileController,
                                                onPressed: () {},
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Name",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Shakila Naseem",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Bank",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Jordan Kuwait Bank",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            Padding(
                                              padding: EdgeInsets.only(top: 24),
                                              child: Text(
                                                S.of(context).selectPurpose,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 16),
                                              child: AppTextField(
                                                labelText:
                                                    S.of(context).purpose,
                                                hintText:
                                                    S.of(context).pleaseEnter,
                                                readOnly: true,
                                                controller:
                                                    model.purposeController,
                                                onPressed: () {
                                                  PurposeDialog.show(context,
                                                      onSelected: (value) {
                                                    model.updatePurpose(value);
                                                    Navigator.pop(context);
                                                  }, onDismissed: () {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                suffixIcon: (value, data) {
                                                  return Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding: EdgeInsets.only(
                                                          right: 8),
                                                      child: AppSvg.asset(
                                                          AssetUtils.downArrow,
                                                          color: AppColor
                                                              .dark_gray_1));
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 16),
                                              child: AppTextField(
                                                labelText: S
                                                    .of(context)
                                                    .purposeDetails,
                                                hintText:
                                                    S.of(context).pleaseEnter,
                                                readOnly: true,
                                                controller: model
                                                    .purposeDetailController,
                                                onPressed: () {
                                                  PurposeDetailDialog.show(
                                                      context,
                                                      onSelected: (value) {
                                                    model.updatePurposeDetail(
                                                        value);
                                                    Navigator.pop(context);
                                                  }, onDismissed: () {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                suffixIcon: (value, data) {
                                                  return Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding: EdgeInsets.only(
                                                          right: 8),
                                                      child: AppSvg.asset(
                                                          AssetUtils.downArrow,
                                                          color: AppColor
                                                              .dark_gray_1));
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 24),
                                              child: ProfileRowItem(
                                                title: S
                                                    .of(context)
                                                    .addRecipientToContact,
                                                initialValue: false,
                                                activeText: S.of(context).yes,
                                                inactiveText: S.of(context).no,
                                                providerBase:
                                                    anyOtherNationalityViewModelProvider,
                                                onToggle: (isActive) {
                                                  model.isAnyOtherNationality =
                                                      isActive;
                                                  return Visibility(
                                                    visible: isActive,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 16.0),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 16),
                                                        child: Row(
                                                          children: [
                                                            AppSvg.asset(AssetUtils
                                                                .personCircle),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14),
                                                              child: Text(
                                                                "Shakila",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentTextTheme
                                                                        .bodyText1!
                                                                        .color),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 16,
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: AppStreamBuilder<bool>(
                                                    stream:
                                                        model.showButtonStream,
                                                    initialData: true,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 16),
                                      child: Text(
                                        S.of(context).swipeDownToCancel,
                                        style: TextStyle(
                                            color: AppColor.dark_gray_1,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

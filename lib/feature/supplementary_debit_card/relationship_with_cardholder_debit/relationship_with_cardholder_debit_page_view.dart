import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card/relationship_with_cardholder_debit/relationship_with_cardholder_debit_page_view_model.dart';
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

class RelationshipWithCardholderDebitPageView
    extends BasePageViewWidget<RelationshipWithCardholderDebitPageViewModel> {
  RelationshipWithCardholderDebitPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, RelationshipWithCardholderDebitPageViewModel model) {
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
                        stream: model.relationshipWithCardHolderResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            Future.delayed(Duration(milliseconds: 500), () {
                              ProviderScope.containerOf(context)
                                  .read(supplementaryDebitCardViewModelProvider)
                                  .nextPage();
                              // .next();
                            });
                          } else if (data.status == Status.ERROR) {
                            if (data.appError!.type == ErrorType.INVALID_RELATIONSHIP) {
                              model.relationshipKey.currentState!.isValid = false;
                            }
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.relationshipWithCardHolder();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.relationshipWithCardHolder();
                                }
                              }
                            },
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                                        ? 0
                                        : MediaQuery.of(context).viewInsets.bottom - 48),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextField(
                                        labelText: S.of(context).relationship.toUpperCase(),
                                        hintText: S.of(context).pleaseSelect,
                                        readOnly: true,
                                        controller: model.relationshipController,
                                        onPressed: () {
                                          RelationshipWithCardHolderDialog.show(context, onDismissed: () {
                                            Navigator.pop(context);
                                          }, onSelected: (value) {
                                            Navigator.pop(context);
                                            model.relationshipController.text = value;
                                            model.validate();
                                          },
                                              title: S.of(context).relationship,
                                              relationSHipWithCardHolder: model.relationship);
                                        },
                                        suffixIcon: (value, data) {
                                          return Container(
                                              height: 16,
                                              width: 16,
                                              padding: EdgeInsets.only(right: 8),
                                              child: AppSvg.asset(AssetUtils.downArrow,
                                                  color: AppColor.dark_gray_1));
                                        },
                                        key: model.relationshipKey,
                                      ),
                                      Expanded(child: Container()),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            S.of(context).backToCardSettings,
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.brightBlue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Center(
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

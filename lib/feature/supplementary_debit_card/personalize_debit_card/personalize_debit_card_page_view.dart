import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card/personalize_debit_card/personalize_debit_card_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class PersonalizeDebitCardPageView
    extends BasePageViewWidget<PersonalizeDebitCardPageViewModel> {
  PersonalizeDebitCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PersonalizeDebitCardPageViewModel model) {
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
                        stream: model.applySupplementaryDebitCardResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            Navigator.pushNamed(context,
                                RoutePaths.SupplementaryDebitCardSuccess);
                          }
                        },
                        dataBuilder: (context, data) {
                          return AppStreamBuilder<Resource<bool>>(
                              stream: model.personalizeDebitCardResponseStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  model.applySupplementaryDebitCard(
                                      ProviderScope.containerOf(context)
                                          .read(
                                              relationShipWithCardHolderDebitViewModelProvider)
                                          .relationshipController
                                          .text,
                                      ProviderScope.containerOf(context)
                                          .read(
                                              supplementaryDebitIdScanInfoViewModelProvider)
                                          .scannedDocumentInformation);
                                }
                              },
                              dataBuilder: (context, data) {
                                return GestureDetector(
                                  onHorizontalDragEnd: (details) {
                                    if (details.primaryVelocity!.isNegative) {
                                      model.personalizeDebitCard();
                                    } else {
                                      ProviderScope.containerOf(context)
                                          .read(
                                              supplementaryDebitCardViewModelProvider)
                                          .swiperController
                                          .previous();
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
                                            AppTextField(
                                              labelText: S
                                                  .of(context)
                                                  .nickName
                                                  .toUpperCase(),
                                              hintText: S.of(context).optional,
                                              controller:
                                                  model.nicknameController,
                                              key: model.nicknameKey,
                                            ),
                                            Center(
                                              child: AnimatedButton(
                                                buttonText: S
                                                    .of(context)
                                                    .swipeToProceed,
                                              ),
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

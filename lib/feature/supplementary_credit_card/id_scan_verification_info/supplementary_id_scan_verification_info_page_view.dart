import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card/id_scan_verification_info/supplementary_id_scan_verification_info_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class SupplementaryIdScanVerificationInfoPageView extends BasePageViewWidget<
    SupplementaryIdScanVerificationInfoPageViewModel> {
  SupplementaryIdScanVerificationInfoPageView(ProviderBase model)
      : super(model);

  @override
  Widget build(BuildContext context,
      SupplementaryIdScanVerificationInfoPageViewModel model) {
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
                    child:
                        AppStreamBuilder<Resource<ScannedDocumentInformation>>(
                      stream: model.scanUserDocumentStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          if (data.data!.issuer == 'JOR') {
                            model.scannedDocumentInformation = data.data!;
                            Future.delayed(Duration(milliseconds: 500), () {
                              ProviderScope.containerOf(context)
                                  .read(
                                      supplementaryCreditCardViewModelProvider)
                                  .nextPage();
                              // .next();
                            });
                          } else {
                            model.showToastWithError(AppError(
                                cause: Exception(),
                                error: ErrorInfo(message: ''),
                                type: ErrorType.INVALID_ID_CARD));
                          }
                        }
                      },
                      dataBuilder: (context, scannedData) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity!.isNegative) {
                              model.scanDocument();
                            } else {
                              ProviderScope.containerOf(context)
                                  .read(
                                      supplementaryCreditCardViewModelProvider)
                                  .previousPage();
                              // .previous();
                            }
                          },
                          child: Card(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 24),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      children: [
                                        InformationText(
                                            image: AssetUtils.sun,
                                            title: S
                                                .of(context)
                                                .idVerificationPlaceInfo),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        InformationText(
                                            image: AssetUtils.scanIcon,
                                            title: S.of(context).idScanInfo),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            S.of(context).uploadIdInstead,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1,
                                                color: Theme.of(context)
                                                    .accentTextTheme
                                                    .bodyText1!
                                                    .color),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 56,
                                        ),
                                        AnimatedButton(
                                          buttonText:
                                              S.of(context).swipeToProceed,
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

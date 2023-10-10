import 'package:domain/constants/enum/credit_card_call_status_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_initiate/credit_card_videocall_initiate_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../di/dashboard/dashboard_modules.dart';

class VerifyCreditCardVideoCallWidget extends StatelessWidget {
  final bool isSmallDevices;
  final CreditCard creditCard;
  final int myIndex;

  VerifyCreditCardVideoCallWidget(
      {Key? key, this.isSmallDevices = false, required this.creditCard, required this.myIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<int>(
        stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).currentStep,
        initialData: 0,
        dataBuilder: (context, myyCurrentStep) {
          return AnimatedOpacity(
            opacity: myyCurrentStep == myIndex ? 1 : 0.5,
            duration: const Duration(milliseconds: 400),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetUtils.zigzagBackground),
                        fit: BoxFit.cover,
                        scale: isSmallDevices ? 1.3 : 1,
                        matchTextDirection: true)),
                child: Stack(
                  fit: StackFit.expand,
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    PositionedDirectional(
                      child: topWidget(context),
                      top: 0,
                      start: 0,
                    ),
                    PositionedDirectional(
                      child: bottomWidget(context),
                      bottom: 0,
                      end: 0,
                      start: 0,
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSvg.asset(AssetUtils.cardCircle, height: 96.0.h),
                          Padding(
                              padding: EdgeInsetsDirectional.only(top: 12.0.h, start: 10.0.w, end: 10.0.w),
                              child: Text(
                                getDescription(creditCard.callStatus, context),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12.0.t,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.secondary),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  topWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 23.0.h, end: 23.0.w, start: 23.0.w),
      child: AppSvg.asset(AssetUtils.blink_updated_logo, height: 33.64.h, width: 72.0.w),
    );
  }

  bottomWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.0.w, bottom: 32.h),
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.CreditCardVideoCallInitiate,
                arguments: CreditCardVideoCallInitiateArgs(creditCard: creditCard));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 17.0.h),
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.bodyLarge!.color!,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                S.of(context).verifyNow,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.0.t,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String getDescription(CreditCardCallStatusEnum? callStatus, BuildContext context) {
  switch (callStatus) {
    case CreditCardCallStatusEnum.CALL_NOT_RECEIVED:
      return S.of(context).verifyViaVideoCallCC;
    case CreditCardCallStatusEnum.DROP:
      return S.of(context).callDroppedDesc;
    default:
      return S.of(context).verifyViaVideoCallCC;
  }
}

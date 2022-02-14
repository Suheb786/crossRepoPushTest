import 'package:domain/model/user/logout/logout_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/check_scheduled_videocall/check_scheduled_videocall_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class CheckScheduledVideoCallPageView
    extends BasePageViewWidget<CheckScheduledVideoCallPageViewModel> {
  CheckScheduledVideoCallPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta!.isNegative) {
          ///TODO: navigate according to status
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: AppSvg.asset(AssetUtils.swiggleHello, height: 241),
                    ),
                    AppStreamBuilder<Resource<LogoutResponse>>(
                        stream: model.logoutStream,
                        initialData: Resource.none(),
                        onData: (response) {
                          if (response.status == Status.SUCCESS) {
                            Navigator.popUntil(context,
                                ModalRoute.withName(RoutePaths.OnBoarding));
                          }
                        },
                        dataBuilder: (context, data) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 62.0),
                            child: InkWell(
                              onTap: () {
                                model.logOutUser();
                              },
                              child: AppSvg.asset(AssetUtils.logout),
                            ),
                          );
                        }),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    S.of(context).videoCallDueNow,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).accentColor),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Visibility(
                  ///TODO:hide when call is missed
                  visible: true,
                  child: Center(
                    child: AnimatedButton(
                      buttonText: S.of(context).swipeToProceed,
                      borderColor: Theme.of(context).accentColor,
                      textColor: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    ///TODO:take to reschedule call
                  },
                  child: Text(
                    S.of(context).rescheduleTheCall,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        color: Theme.of(context).accentColor),
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

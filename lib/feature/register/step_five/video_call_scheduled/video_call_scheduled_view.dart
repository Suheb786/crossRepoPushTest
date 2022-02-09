import 'package:domain/model/user/logout/logout_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_five/video_call_scheduled/video_call_scheduled_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_details.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_ready_header.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class VideoCallScheduledView
    extends BasePageViewWidget<VideoCallScheduledViewModel> {
  VideoCallScheduledView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, VideoCallScheduledViewModel model) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: AppStreamBuilder<Resource<LogoutResponse>>(
                stream: model.logoutStream,
                initialData: Resource.none(),
                onData: (response) {
                  if (response.status == Status.SUCCESS) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutePaths.OnBoarding,
                        ModalRoute.withName(RoutePaths.Splash));
                  }
                },
                dataBuilder: (context, data) {
                  return Padding(
                    padding: EdgeInsets.only(top: 43, right: 30),
                    child: InkWell(
                      onTap: () {
                        model.logOutUser();
                      },
                      child: AppSvg.asset(AssetUtils.logout),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetUtils.line),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 111.37,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.vividYellow,
                      ),
                      child: Center(child: AppSvg.asset(AssetUtils.right)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 34,
            ),
            AccountReadyHeader(
                title: S.of(context).callScheduled,
                subTitle: S.of(context).callScheduledNote),
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AccountDetails(
                      title: S.of(context).refNo,
                      value: model.arguments.applicationId ?? "-"),
                  SizedBox(
                    height: 16,
                  ),
                  AccountDetails(
                      title: S.of(context).preferredDateSmall,
                      value: model.arguments.date ?? "-"),
                  SizedBox(
                    height: 16,
                  ),
                  AccountDetails(
                      title: S.of(context).preferredTimeSmall,
                      value: model.arguments.time ?? "-"),
                ],
              ),
            ),
          ],
        ));
  }
}

import 'package:domain/model/activity/activity_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/notification/notification_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class NotificationPageView extends BasePageViewWidget<NotificationViewModel> {
  NotificationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: AspectRatio(
        aspectRatio: 0.62,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity!.isNegative) {
              ProviderScope.containerOf(context)
                  .read(activityHomeViewModelProvider)
                  .pageController
                  .next();
            } else {}
          },
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            color: Theme.of(context)
                .cardTheme
                .copyWith(color: AppColor.white)
                .color,
            margin: EdgeInsets.zero,
            shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).notifications,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: AppStreamBuilder<Resource<ActivityResponse>>(
                        stream: ProviderScope.containerOf(context)
                            .read(activityHomeViewModelProvider)
                            .activityResponse,
                        initialData: Resource.none(),
                        dataBuilder: (context, activities) {
                          return activities!.data!.activityContent!.activities!
                                      .length >
                                  0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: activities.data!.activityContent!
                                      .activities!.length,
                                  padding: EdgeInsets.only(top: 20),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 6,
                                              width: 6,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 7),
                                              child: Text(
                                                activities
                                                    .data!
                                                    .activityContent!
                                                    .activities![index]
                                                    .heading!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 6, bottom: 12),
                                          child: Text(
                                            activities
                                                .data!
                                                .activityContent!
                                                .activities![index]
                                                .description!,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: AppColor.dark_gray_1),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                )
                              : Center(
                                  child: Text("No Transaction to Display"));
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

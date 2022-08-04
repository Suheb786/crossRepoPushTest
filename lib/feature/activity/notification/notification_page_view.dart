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
import 'package:neo_bank/utils/string_utils.dart';

class NotificationPageView extends BasePageViewWidget<NotificationViewModel> {
  NotificationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (StringUtils.isDirectionRTL(context)) {
            if (!details.primaryVelocity!.isNegative) {
              ProviderScope.containerOf(context)
                  .read(activityHomeViewModelProvider)
                  .appSwiperController
                  .nextPage(duration: Duration(milliseconds: 600), curve: Curves.linear);
            }
          } else {
            if (details.primaryVelocity!.isNegative) {
              ProviderScope.containerOf(context)
                  .read(activityHomeViewModelProvider)
                  .appSwiperController
                  .nextPage(duration: Duration(milliseconds: 600), curve: Curves.linear);
            } else {}
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).cardTheme.copyWith(color: AppColor.white).color,
          margin: EdgeInsetsDirectional.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Padding(
            padding: EdgeInsetsDirectional.only(top: 30, start: 24, end: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).notifications,
                  style:
                      TextStyle(fontFamily: StringUtils.appFont, fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: AppStreamBuilder<Resource<ActivityResponse>>(
                      stream: ProviderScope.containerOf(context)
                          .read(activityHomeViewModelProvider)
                          .activityResponse,
                      initialData: Resource.none(),
                      dataBuilder: (context, activities) {
                        return activities!.data!.activityContent!.activities!.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: activities.data!.activityContent!.activities!.length,
                                padding: EdgeInsetsDirectional.only(top: 20),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 6,
                                            width: 6,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context).primaryColor),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(start: 7),
                                            child: Text(
                                              activities.data!.activityContent!.activities![index].heading!,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(top: 6, bottom: 12),
                                        child: Text(
                                          activities.data!.activityContent!.activities![index].description!,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: AppColor.dark_gray_1),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            : Center(child: Text(S.of(context).noActivityToDisplay));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

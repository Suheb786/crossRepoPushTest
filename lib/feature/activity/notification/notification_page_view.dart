import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/notification/notification_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    padding: EdgeInsets.only(top: 20),
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
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  "Card Transaction",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6, bottom: 12),
                            child: Text(
                              "You’ve just spent 10.15 JOD with blink Debit Card ending 9001.",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

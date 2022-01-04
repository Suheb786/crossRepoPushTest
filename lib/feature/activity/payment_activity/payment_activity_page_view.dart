import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PaymentActivityPageView
    extends BasePageViewWidget<PaymentActivityViewModel> {
  PaymentActivityPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: AspectRatio(
        aspectRatio: 0.62,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity!.isNegative) {
            } else {
              ProviderScope.containerOf(context)
                  .read(activityHomeViewModelProvider)
                  .pageController
                  .previous();
            }
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            color: Theme.of(context).canvasColor,
            margin: EdgeInsets.zero,
            shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).paymentActivity,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.dark_yellow),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: index == 0 ? 0 : 23),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  "SR",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 11),
                                child: Text(
                                  "Sara Rose requested 10.00 JOD from you",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
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

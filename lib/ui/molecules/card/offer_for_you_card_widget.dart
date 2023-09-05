import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/offer_campaign/offer/offer_for_you_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../utils/string_utils.dart';

class OfferForYouCardWidget extends StatelessWidget {
  const OfferForYouCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      elevation: 2,
      margin: EdgeInsets.zero,
      shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.0.w, top: 32.h),
            child: Text(
              S.of(context).forYou,
              style: TextStyle(
                  fontSize: 20.t,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Row(
                      children: [
                        Container(
                          width: 104.w,
                          height: 104.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16.w)),
                          child: CachedNetworkImage(
                            imageUrl: "",
                            placeholder: (context, url) => Container(color: Theme.of(context).primaryColor),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gerard",
                                style: TextStyle(
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).scaffoldBackgroundColor),
                              ),
                              SizedBox(
                                height: 4.w,
                              ),
                              Text(
                                "15% discount on Debit Card",
                                style: TextStyle(
                                    fontSize: 12.t,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)),
                              ),
                              SizedBox(
                                height: 16.w,
                              ),
                              Text(
                                "Ends on 27th Sep",
                                style: TextStyle(
                                    fontSize: 12.t,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                padding: EdgeInsetsDirectional.only(
                                    start: 8.0.w, end: 8.0.w, top: 3.5.h, bottom: 1.5.h),
                                decoration: BoxDecoration(
                                    color: getColor(OfferType.EARLY),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  "2 days left",
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0.t),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(OfferType value) {
    switch (value) {
      case OfferType.EARLY:
        return AppColor.darkModerateLimeGreen;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}

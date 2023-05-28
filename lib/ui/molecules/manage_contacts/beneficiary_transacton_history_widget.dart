import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BeneficiaryTransactionWidget extends StatelessWidget {
  const BeneficiaryTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 32,
        ),
        Text(
          "18 Jan",
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: 14.0.t,
              fontWeight: FontWeight.w600,
              color: AppColor.veryDarkGray2),
        ),
        Card(
          margin: EdgeInsets.only(top: 16.0.h, bottom: 32.0.h),
          color: Theme.of(context).colorScheme.secondary,
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 24.0.w, right: 48.h, top: 16.h, bottom: 17.0.h),
            itemBuilder: (context, index) {
              return Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.w,
                      backgroundColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        StringUtils.getFirstInitials('Vivek Singh'),
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.t,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
//For Image
                    /* CircleAvatar(
                          radius: 25.w,
                          backgroundImage: Image.memory(
                           '' as Uint8List,
                            fit: BoxFit.cover,
                          ).image,
                        ),
                        */
                    SizedBox(
                      width: 8.w,
                    ),

                    outwardSendMoney(context),
                  ],
                ),
              );
            },
            shrinkWrap: true,
            itemCount: 4,
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0.h),
                child: AppDivider(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget inwardSendMoney(
    BuildContext context,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              maxLines: 3,
              text: TextSpan(
                  text: "Vivek SinghSinghSinghSingh",
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 12.0.t,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  children: [
                    TextSpan(
                      text: "" + S.of(context).sent.toLowerCase(),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.0.t,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColorDark),
                    ),
                    TextSpan(
                      text: " " + "12.000 JOD",
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.0.t,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      children: [
                        TextSpan(
                          text: " " + S.of(context).toYou,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 12.0.t,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ],
                    ),
                  ])),
          SizedBox(
            height: 4.h,
          ),
          Text(
            // TimeUtils.getFormattedTimeFor12HrsFormat("7:30 PM"),
            "7:30 PM",
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w400,
                fontSize: 12.t,
                color: Theme.of(context).textTheme.titleMedium?.color),
          )
        ],
      ),
    );
  }

  Widget outwardSendMoney(
    BuildContext context,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              maxLines: 3,
              text: TextSpan(
                  text: S.of(context).youPaid,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 12.0.t,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColorDark),
                  children: [
                    TextSpan(
                      text: " " + "12.000 JOD",
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12.0.t,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      children: [
                        TextSpan(
                          text: " " + S.of(context).to + " ",
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 12.0.t,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        TextSpan(
                          text: 'Vivek SinghSinghSinghSingh',
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 12.0.t,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ])),
          SizedBox(
            height: 4.h,
          ),
          Text(
            // TimeUtils.getFormattedTimeFor12HrsFormat("7:30 PM"),
            "7:30 PM",
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w400,
                fontSize: 12.t,
                color: Theme.of(context).textTheme.titleMedium?.color),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RjConfirmFlightDetailDepartAndReturnWidget extends StatelessWidget {
  final String title;
  final String titleDescription;
  final String toDescription;
  final String date;
  final String time;

  const RjConfirmFlightDetailDepartAndReturnWidget(
      {Key? key,
      required this.title,
      required this.titleDescription,
      required this.toDescription,
      required this.date,
      required this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              Spacer(),
              Text(
                titleDescription,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                S.of(context).to.toLowerCase(),
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.gray5,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                toDescription,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
              Text(
                time,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.gray5,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}

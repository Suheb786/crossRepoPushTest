import 'package:domain/model/register/reason_of_unavailability.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ReasonUnavailabilityListWidget extends StatelessWidget {
  final Color? labelColor;
  final Color? descriptionColor;
  final Color? widgetColor;
  final ReasonOfUnavailability reasonOfUnavailability;

  const ReasonUnavailabilityListWidget(
      {Key? key,
      required this.reasonOfUnavailability,
      this.labelColor,
      this.descriptionColor,
      this.widgetColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: widgetColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reasonOfUnavailability.type!,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                color: labelColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              reasonOfUnavailability.reasonDescription!,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: descriptionColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

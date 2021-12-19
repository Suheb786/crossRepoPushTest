import 'package:flutter/material.dart';
import 'package:neo_bank/feature/dashboard_home/locate_atm/locate_atm_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

class LocateATMListWidget extends StatelessWidget {
  final ATMLocationModel? atmLocationModel;
  final Function()? onTap;

  const LocateATMListWidget({Key? key, this.atmLocationModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      atmLocationModel!.name!,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      atmLocationModel!.address!,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        S
                            .of(context)
                            .getDirections,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme
                                .of(context)
                                .accentTextTheme
                                .bodyText1!
                                .color),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 39,
              ),
              Text(
                atmLocationModel!.distance!,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            height: 1,
            color: AppColor.light_grayish_violet,
          ),
        ),
      ],
    );
  }
}

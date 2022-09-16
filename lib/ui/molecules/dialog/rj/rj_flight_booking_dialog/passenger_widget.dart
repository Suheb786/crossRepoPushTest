import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/passenger_view_%20model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PassengerWidget extends StatelessWidget {
  var count = 0;
  int index;
  final List<Passenger> passengerList;
  PassengerWidget({Key? key, required this.passengerList, required this.index}) : super(key: key);

  ProviderBase provideBase() {
    return PassengerViewModelProvider().provide();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PassengerViewModel>(
      // key: ValueKey(data.orderNo),
      providerBase: provideBase(),
      builder: (context, passengerViewModel, widget) {
        return AppStreamBuilder<int>(
          stream: passengerViewModel!.incrementDecrementSubjectStream,
          initialData: 0,
          dataBuilder: (BuildContext context, data) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(passengerList[index].passengerType,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColor.veryDarkGray2)),
                      Text(passengerList[index].passengerAgeRange,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColor.gray1)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    passengerViewModel.decrementCounter(--count);
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.all(16),
                    child: Text(
                      '-',
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColor.brightBlue),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: AppColor.white_gray,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(data.toString(),
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColor.very_dark_gray_black)),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    passengerViewModel.incrementCounter(++count);
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.all(16),
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 20, color: AppColor.brightBlue),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: AppColor.white_gray,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

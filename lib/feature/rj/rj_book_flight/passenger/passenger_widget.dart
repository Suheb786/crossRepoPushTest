import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/passenger/passenger_view_%20model.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/rj_book_flight_page_view_model.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../base/base_widget.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../utils/string_utils.dart';

class PassengerWidget extends StatelessWidget {
  var count = 0;
  int index;
  final List<Passenger> passengerList;
  Function(List<Passenger>) onTap;

  PassengerWidget({Key? key, required this.passengerList, required this.index, required this.onTap})
      : super(key: key);

  ProviderBase provideBase() {
    return PassengerViewModelProvider().provide();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PassengerViewModel>(
      providerBase: provideBase(),
      onModelReady: (model) {
        model.passengerList = passengerList;
      },
      builder: (context, passengerViewModel, widget) {
        return AppStreamBuilder<int>(
          stream: passengerViewModel!.incrementDecrementSubjectStream,
          initialData: 0,
          dataBuilder: (BuildContext context, data) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(passengerList[index].passengerType,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.t,
                              color: Theme.of(context).colorScheme.surfaceVariant)),
                      Text(passengerList[index].passengerAgeRange,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.t,
                              color: Theme.of(context).colorScheme.onInverseSurface)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    passengerViewModel.decrementCounter(--count, index);
                    onTap.call(passengerViewModel.passengerList);
                  },
                  child: Container(
                    height: 32.w,
                    width: 32.w,
                    alignment: Alignment.center,
                    child: Text(
                      '-',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.t,
                        height: 1.59,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  padding: EdgeInsets.only(top: 5.h),
                  width: 36.w,
                  alignment: Alignment.center,
                  child: Text(data.toString(),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.t,
                          color: Theme.of(context).colorScheme.surfaceVariant)),
                ),
                GestureDetector(
                  onTap: () {
                    passengerViewModel.incrementCounter(++count, index);
                    onTap.call(passengerViewModel.passengerList);
                  },
                  child: Container(
                    height: 32.w,
                    width: 32.w,
                    alignment: Alignment.center,
                    child: Text(
                      '+',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.t,
                        height: 1.59,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.inverseSurface,
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

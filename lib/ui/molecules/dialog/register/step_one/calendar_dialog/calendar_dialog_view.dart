import 'package:domain/constants/enum/calendar_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/calendar_dialog/calendar_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/year_month_dialog/year_month_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/calendar_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(DateTime)? onSelected;
  final String? title;
  final DateTime? initialDateTime;
  final Function(String)? onHeaderTapped;

  const CalendarDialogView(
      {this.onDismissed,
      this.onSelected,
      this.title,
      this.onHeaderTapped,
      this.initialDateTime});

  ProviderBase providerBase() {
    return calendarDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CalendarDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: AppStreamBuilder<DateParameters>(
                stream: model!.dateParamsStream,
                initialData: DateParameters(
                    selectedDay: initialDateTime, focusedDay: initialDateTime),
                dataBuilder: (context, dateParams) {
                  return SingleChildScrollView(
                    child: AppKeyBoardHide(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 32.0, bottom: 24),
                              child: Center(
                                child: Text(
                                  title!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Flexible(
                                child: TableCalendar(
                              firstDay: kFirstDay,
                              lastDay: kLastDay,
                              focusedDay: dateParams!.focusedDay!,
                              calendarFormat: CalendarFormat.month,
                              pageJumpingEnabled: false,
                              onHeaderTapped: (time) {
                                YearMonthDialog.show(context,
                                    calendarEnum: CalendarEnum.MONTH,
                                    onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (month) {
                                  Navigator.pop(context);
                                  model.month = TimeUtils.getMonth(month);
                                  YearMonthDialog.show(context,
                                      calendarEnum: CalendarEnum.YEAR,
                                      onDismissed: () {
                                    Navigator.pop(context);
                                  }, onSelected: (year) {
                                    Navigator.pop(context);
                                    model.year = int.parse(year);
                                    model.updateSelectedDate(
                                        dateParams.selectedDay!,
                                        DateTime(model.year, model.month,
                                            model.date));
                                  });
                                });
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(dateParams.selectedDay, day);
                              },
                              enabledDayPredicate: (date) {
                                return date.isBefore(DateTime.now());
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!isSameDay(
                                    dateParams.selectedDay, selectedDay)) {
                                  model.updateSelectedDate(
                                      selectedDay, focusedDay);
                                }
                              },
                              onFormatChanged: (format) {},
                              onPageChanged: (focusedDay) {
                                model.updateSelectedDate(
                                    dateParams.selectedDay!, focusedDay);
                              },
                              calendarStyle: CalendarStyle(
                                outsideTextStyle: TextStyle(
                                    color: AppColor.grayish_violet,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                todayDecoration: BoxDecoration(
                                    color: AppColor.vivid_orange,
                                    shape: BoxShape.circle),
                                todayTextStyle: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                disabledTextStyle: TextStyle(
                                    color: AppColor.grayish_violet,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                defaultTextStyle: TextStyle(
                                    color: AppColor.dark_violet2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                weekendTextStyle: TextStyle(
                                    color: AppColor.dark_violet2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                selectedDecoration: BoxDecoration(
                                    color: AppColor.vivid_orange,
                                    shape: BoxShape.circle),
                                selectedTextStyle: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              headerStyle: HeaderStyle(
                                  titleTextStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.vivid_orange,
                                      fontSize: 12),
                                  headerMargin: EdgeInsets.only(bottom: 24),
                                  rightChevronIcon: AppSvg.asset(
                                    AssetUtils.rightChevron,
                                    color: AppColor.dark_gray_1,
                                  ),
                                  titleCentered: true,
                                  formatButtonVisible: false,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColor.white_gray,
                                      ),
                                      borderRadius: BorderRadius.circular(8))),
                              daysOfWeekHeight: 32,
                              daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                      color: AppColor.gray_black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  weekendStyle: TextStyle(
                                      color: AppColor.gray_black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  dowTextFormatter: (date, locale) =>
                                      DateFormat.E(locale).format(date)[0]),
                            )),
                            InkWell(
                              onTap: () {
                                onSelected?.call(dateParams.selectedDay!);
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.only(top: 30),
                                height: 57,
                                width: 57,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.dark_violet_4),
                                child: AppSvg.asset(AssetUtils.tick),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 16),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    onDismissed?.call();
                                  },
                                  child: Text(
                                    S.of(context).swipeDownToCancel,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.dark_gray_1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
        },
        onModelReady: (model) {
          model.updateSelectedDate(initialDateTime!, initialDateTime!);
        },
        providerBase: providerBase());
  }
}

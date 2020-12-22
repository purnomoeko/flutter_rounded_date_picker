import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class DialogCalendar {
  // Use: DialogCalendar.show(...)
  static Future<void> show({
    @required BuildContext context,
    @required DateTime selectedDay,
    DateTime startDay,
    List<DateTime> listDateDisabled,
    double borderCalendar = 32,
    bool barrierDismissible = true,
    MaterialRoundedDatePickerStyle materialRoundedDatePickerStyle,
    Locale locale = const Locale('en', 'US'),
    Color borderDayColor = Colors.grey,
    Color borderCurrentDayColor = Colors.pink,
    Color backgroundSelectedDay = Colors.blue,
    Color backgroundDisabledDay = Colors.grey,
    TextStyle dayTextStyle,
    TextStyle selectedDayTextStyle,
    TextStyle currentDayTextStyle,
    TextStyle disabledDayTextStyle,
    bool showHeader = false,
    double height = 600,
    Function(DateTime) onPressDay,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)
        transitionBuilder,
  }) {
    final DateTime currentDay = DateTime.now();
    final DateTime firstDate =
        DateTime(startDay?.year ?? DateTime.now().year, DateTime.now().month);
    final DateTime lastDate = currentDay.add(const Duration(days: 365));

    final MaterialRoundedDatePickerStyle datePickerStyle =
        materialRoundedDatePickerStyle ??
            MaterialRoundedDatePickerStyle(
              sizeArrow: 16,
              textStyleDayHeader: TextStyle(),
              paddingDatePicker: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              marginTopArrowNext: 16,
              marginTopArrowPrevious: 16,
              textStyleDayOnCalendarSelected: selectedDayTextStyle,
              paddingMonthHeader: EdgeInsets.only(
                top: 16,
                bottom: 24,
              ),
              textStyleMonthYearHeader: TextStyle(),
            );

    Widget _buildDay(DateTime dateTime) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderDayColor, width: 2.0),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              dateTime.day.toString(),
              style: dayTextStyle ?? TextStyle(),
            ),
          ),
        ),
      );
    }

    Widget _buildSelectedDay(DateTime dateTime) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundSelectedDay,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              dateTime.day.toString(),
              style: selectedDayTextStyle ?? TextStyle(),
            ),
          ),
        ),
      );
    }

    Widget _buildCurrentDay(DateTime dateTime) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderCurrentDayColor, width: 2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              dateTime.day.toString(),
              style: currentDayTextStyle ?? TextStyle(),
            ),
          ),
        ),
      );
    }

    Widget _buildDisableDay(DateTime dateTime) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundDisabledDay,
            border: Border.all(color: backgroundDisabledDay, width: 2.0),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              dateTime.day.toString(),
              style: disabledDayTextStyle ?? TextStyle(),
            ),
          ),
        ),
      );
    }

    Widget _buildCTA() {
      return Padding(
        padding: EdgeInsets.only(top: 16, bottom: 24),
        child: MaterialButton(
          child: Text('Confirm'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      );
    }

    return showRoundedDatePicker(
      context: context,
      locale: locale,
      initialDate: selectedDay,
      firstDate: firstDate,
      lastDate: lastDate,
      borderRadius: borderCalendar,
      height: height ?? 460,
      barrierDismissible: barrierDismissible,
      listDateDisabled: listDateDisabled,
      showHeader: showHeader,
      transitionBuilder: transitionBuilder,
      selectableDayPredicate: (DateTime day) {
        return day.day == DateTime.now().day || day.isAfter(DateTime.now());
      },
      styleDatePicker: datePickerStyle,
      customWeekDays: <String>['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
      builderDay: (
        DateTime dateTime,
        bool isCurrentDay,
        bool isDisable,
        bool isSelected,
        TextStyle defaultTextStyle,
      ) {
        if (isSelected) {
          return _buildSelectedDay(dateTime);
        }

        if (isCurrentDay) {
          return _buildCurrentDay(dateTime);
        }

        if (isDisable) {
          return _buildDisableDay(dateTime);
        }

        return _buildDay(dateTime);
      },
      builderActions: _buildCTA(),
      onTapDay: (DateTime dateTime, bool available) {
        if (available && onPressDay != null) {
          onPressDay(dateTime);
        }
        return available;
      },
    );
  }
}

import 'package:flutter/material.dart';

class FormatDateTime {
  String formatDate(DateTime date) {
    String formattedDate = date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString();

    return formattedDate;
  }

  String formatTime(TimeOfDay timeOfDay) {
    String formattedTime =
        timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString();

    return formattedTime;
  }

  String formatDateTime(DateTime date, TimeOfDay time) {
    String formattedDateTime = formatTime(time) + ", " + formatDate(date);

    return formattedDateTime;
  }
}
